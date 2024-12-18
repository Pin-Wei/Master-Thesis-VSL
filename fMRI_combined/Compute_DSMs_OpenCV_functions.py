
import cv2
import mahotas
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance as dist
from skimage.metrics import structural_similarity

def plot_image(image):
    fig = plt.gcf()
    fig.set_size_inches(2, 2)
    plt.imshow(image, cmap='binary')
    plt.show()

def get_image_infos(contour):
    M = cv2.moments(contour) 
    mc = (int(M['m10'] / M['m00']),  # mass center, X
          int(M['m01'] / M['m00']))  # mass center, Y
    # mc = (int(M['m10'] / (M['m00'] + 1e-5)),
    #       int(M['m01'] / (M['m00'] + 1e-5)))  # add 1e-5 to avoid division by zero
    area = cv2.contourArea(contour)         # area, in pixel units
    peri = cv2.cv2.arcLength(contour, True) # perimeter, closed object=True
    return mc, area, peri

def make_Hu_dsm(images):
    '''
    OpenCV comes with a function cv.matchShapes() 
        which enables us to compare two shapes, or two contours 
        and returns a metric showing the similarity. 
    The lower the result, the better match it is. 
    It is calculated based on the Hu-moment values.
    - https://docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#gaadc90cb16e2362c9bd6e7363e6e4c317
    - https://docs.opencv.org/3.4/d5/d45/tutorial_py_contours_more_functions.html
    '''
    nr = len(images)
    DSM = np.zeros((nr, nr))    
    match_mode = cv2.CONTOURS_MATCH_I2
        # more options: https://docs.opencv.org/3.4/d3/dc0/group__imgproc__shape.html#gaf2b97a230b51856d09a2d934b78c015f
    for i in range(nr-1):
        for j in range(i+1, nr):
            diff = cv2.matchShapes(images[i], images[j], match_mode, 0)
            DSM[i, j] = diff
            DSM[j, i] = DSM[i, j]
    return DSM

def compute_log_Hu_dsm(images):
    '''
    Hu moments are computed based on the central moments of up to 3rd order, 
        so hu[0] is not comparable in magnitude as hu[6]. 
    Perform a log transformation can bring them in the same range.
    - https://learnopencv.com/shape-matching-using-hu-moments-c-python/
    - https://cvexplained.wordpress.com/2020/07/21/10-4-hu-moments/
    '''
    # nr = len(images)
    # DSM = np.zeros((nr, nr))
    # Nord = 2 # L2-Norm, = Euclidean length
    log_Hu_M_list = [] 
    for img in images:
        M = cv2.moments(img)
        Hu_M = cv2.HuMoments(M).flatten()
        log_Hu_M = [ -1 * np.sign(hum) * np.log10(np.abs(hum)) for hum in Hu_M ]
        log_Hu_M_list.append(log_Hu_M)
    # for i in range(nr-1):
    #     for j in range(i+1, nr):
    #         diff = np.linalg.norm(log_Hu_M_list[i] - log_Hu_M_list[j], ord=Nord)
    #         DSM[i, j] = diff
    #         DSM[j, i] = DSM[i, j]
    DSM = dist.cdist(log_Hu_M_list, log_Hu_M_list, 'euclidean')
    return DSM, log_Hu_M_list
    # SM = dist.cdist(log_Hu_M_list, log_Hu_M_list, 'correlation')
    # return SM, log_Hu_M_list

def compute_Zernike_dsm(images, contours):
    '''
    Zernike Moments are similar but generally out-performed Hu Moments
        because they are based on orthogonal functions, 
            so there is no information redundancy between moments.
    - https://cvexplained.wordpress.com/2020/07/21/10-5-zernike-moments/
    '''
    Zer_M_list = []
    for x, img in enumerate(images):
        Radi = cv2.minEnclosingCircle(contours[x][0])[1]
        Zer_M = mahotas.features.zernike_moments(img, radius=Radi, degree=8)
        Zer_M_list.append(Zer_M.flatten())
    DSM = dist.cdist(Zer_M_list, Zer_M_list, 'euclidean')
    return DSM, Zer_M_list
    # SM = dist.cdist(Zer_M_list, Zer_M_list, 'correlation')
    # return SM, Zer_M_list

def detect_compute_dsm(images, desc, matcher):
    '''
    The descriptor can be, for example, SIFT or ORB.
    - SIFT (Scale-Invariant Feature Transform): https://docs.opencv.org/3.4/da/df5/tutorial_py_sift_intro.html
    - ORB (Oriented FAST and Rotated BRIEF): https://docs.opencv.org/3.4/d1/d89/tutorial_py_orb.html
        - FAST (Features from Accelerated Segment Test) algorithm: https://docs.opencv.org/3.4/df/d0c/tutorial_py_fast.html
            a faster Feature/Corner/Keypoint detector.
        - BRIEF (Binary Robust Independent Elementary Features): https://docs.opencv.org/3.4/dc/d7d/tutorial_py_brief.html
            convert SIFT descriptors (in floating point numbers) to binary strings.
    
    The matcher can be BFMatcher or FLANN based matcher: https://docs.opencv.org/4.x/dc/dc3/tutorial_py_matcher.html
    - Brute-Force Matcher is simple. 
        It takes the descriptor of one feature in first set 
            and is matched with all other features in second set using some distance calculation. 
            And the closest one is returned.
        Default distance measurement is NORM_L2. It is good for SIFT.
            but for binary string based descriptors (like ORB), NORM_HAMMING should be used.
        If crossCheck is true, Matcher returns only those matches with value (i, j). 
            That is, the two features in both sets should match each other. 
    - FLANN (Fast Library for Approximate Nearest Neighbors) 
        is optimized for fast nearest neighbor search in large datasets and for high dimensional features. 

    The result of bf.match(des1, des2) line is a list of DMatch objects.
        DMatch.distance is a float between {0:100}, lower means more similar.
    '''
    nr = len(images)
    DSM = np.zeros((nr, nr))
    keypoints, descriptors = [], []
    for img in images:
        kp, des = desc.detectAndCompute(img, None)
        keypoints.append(kp)
        descriptors.append(des)
    for i in range(nr-1):
        for j in range(i+1, nr):
            dmatches = matcher.match(descriptors[i], descriptors[j])
            # dmatch = sorted(dmatchs, key=lambda x: x.distance)
            DSM[i, j] = sum( dmatch.distance for dmatch in dmatches ) / len(dmatches)
            DSM[j, i] = DSM[i, j]
    return DSM, descriptors

def compute_ssim_dsm(image_list):
    '''
    Compute structural similarity with scikit-image.
    ** Requires consistent image size.
    - https://scikit-image.org/docs/stable/auto_examples/transform/plot_ssim.html
    '''
    nr = len(image_list)
    SM = np.ones((nr, nr))
    for i in range(nr-1):
        for j in range(i+1, nr):
            sim, diff = structural_similarity(image_list[i], image_list[j], full=True)
            SM[i, j] = sim
            SM[j, i] = SM[i, j]

    DSM = np.ones(SM.shape) - SM
    return DSM

def compute_pixel_dsm(image_list, height, width, cmax=255):
    '''
    Compute pixel-level distance.
    ** Requires consistent image size.
    - https://gist.github.com/OverlordQ/70b603c2d188cb50e086bc60fc389744
    '''
    nr = len(image_list)
    DSM = np.zeros((nr, nr))
    for i in range(nr-1):
        for j in range(i+1, nr):
            diff = np.sum(np.absolute(image_list[i] - image_list[j])) / (height*width) / cmax
            DSM[i, j] = diff
            DSM[j, i] = DSM[i, j]
    return DSM