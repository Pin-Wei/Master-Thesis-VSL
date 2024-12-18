#!/usr/bin/python

import os
import re
import glob
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

import cv2
import imutils
import mahotas

from scipy.spatial import distance as dist
from sklearn.metrics.pairwise import pairwise_distances
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

def compute_ssim(image_list):
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
    return SM

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

### -----------------------------------------------------------------------------------------------------------
height, width = [219, 219]

## Load image files: 
images, contours, contours_ext = [], [], []
img_dir = os.path.join(os.getcwd(), 'stimuli', 'png')
for fn in sorted(glob.glob(os.path.join(img_dir, '*')), 
                 key=lambda s: int(re.search(r'\d+', s).group())):
    img = cv2.imread(fn, cv2.IMREAD_UNCHANGED)
    alpha = img[:, :, 3]  # extract the alpha channel
    binary = ~ alpha      # invert black & white
    images.append(binary)
    cnt1 = cv2.findContours(binary, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    cnt1 = imutils.grab_contours(cnt1)
    contours.append(cnt1)
    cnt2 = cv2.findContours(binary, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnt2 = imutils.grab_contours(cnt2)
    contours_ext.append(cnt2)

# ## Show images: 
# cv2.imshow('Image', images[0])
# cv2.waitKey(0)
# cv2.destroyAllWindows()
# plot_image(images[0]) # show images with the self-defined function 
## Make the image size consistent:

# ## Get the mass centers, area & perimeter: 
# mc_list, area_list, peri_list = [], [], []
# for cnt in contours:
#     mc, area, peri = get_image_infos(cnt)
#     mc_list.append(mc)
#     area_list.append(area)
#     peri_list.append(peri)

## Make the image size consistent:
image_list = []
for cnt in contours:
    mask = np.zeros([height, width])
    cv2.drawContours(mask, cnt, -1, 255, cv2.FILLED)
        # https://docs.opencv.org/4.x/d6/d6e/group__imgproc__draw.html#ga746c0625f1781f1ffc9056259103edbc
    image_list.append(-1*mask+255)

### -----------------------------------------------------------------------------------------------------------
SM_list, DSM_list = {}, {}

# Method-1: Hu Moments:
method = 'HuM_2' # CONTOURS_MATCH_I2
DSM_list[method] = make_Hu_dsm(images)

# Method-2: Log-transformed Hu Moments:
method = 'log_HuM'
DSM_list[method], log_Hu_M_list = compute_log_Hu_dsm(images)

# Method-3: Zernike Moments:
method = 'ZernikeM'
DSM_list[method], Zer_M_list = compute_Zernike_dsm(images, contours_ext)

# # Method-4: SIFT (Scale-Invariant Feature Transform):
# method = 'SIFT'
# sift = cv2.SIFT_create()
# bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True) 
# DSM_list[method], descriptors = detect_compute_dsm(images, sift, bf)

# Method-5: ORB (Oriented FAST and Rotated BRIEF):
method = 'ORB'
orb = cv2.ORB_create()
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True) 
DSM_list[method], descriptors = detect_compute_dsm(images, orb, bf)

# Method-6: Structural Similarity:
method = 'SSIM'
SM_list[method] = compute_ssim(image_list)
DSM_list[method] = np.ones(SM_list[method].shape) - SM_list[method]

# Method-7: Pixel-level Similarity:
method = 'Pixel'
DSM_list[method] = compute_pixel_dsm(image_list, height, width, cmax=255)

for method_name, dissimilarity_matrix in DSM_list.items():
    fn = 'DSM_{:}.csv'.format(method_name)
    fd = os.path.join('dis-similarity_matrices', 'original')
    if not os.path.exists(fd):
        os.makedirs(fd)
    np.savetxt(os.path.join(fd, fn), dissimilarity_matrix, delimiter=",")

### Bonus: ----------------------------------------------------------------------------------------------------
# Apply to realistic images: https://chtseng.wordpress.com/2016/12/05/opencv-contour%E8%BC%AA%E5%BB%93/