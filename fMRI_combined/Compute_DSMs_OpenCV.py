#!/usr/bin/python

import os
import re
import glob
import cv2
import imutils
import numpy as np
import pandas as pd
from Compute_DSMs_OpenCV_functions import make_Hu_dsm, compute_log_Hu_dsm, compute_Zernike_dsm, detect_compute_dsm, compute_ssim_dsm, compute_pixel_dsm

method_list = [
    'HuM_2',    # Hu Moments
    'log_HuM',  # Log-transformed Hu Moments
    'ZernikeM', # Zernike Moments
    'ORB',      # Oriented FAST and Rotated BRIEF
    'SSIM',     # Structural Similarity
    'Pixel'     # Pixel-level Similarity
]

top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
behav_dir = os.path.join(top_dir, "behavioral_data")
img_dir = os.path.join(behav_dir, 'stimuli', 'png')
out_dir = os.path.join(top_dir, "Combined_group", "derivatives", "Computed_DSMs", "original")
if not os.path.exists(out_dir):
    os.makedirs(out_dir)
out_dir2 = out_dir.replace("original", "individuals")
if not os.path.exists(out_dir2):
    os.makedirs(out_dir2)

## Load image files: 
images, contours, contours_ext = [], [], []
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
height, width = [219, 219]
for cnt in contours:
    mask = np.zeros([height, width])
    cv2.drawContours(mask, cnt, -1, 255, cv2.FILLED)
        # https://docs.opencv.org/4.x/d6/d6e/group__imgproc__draw.html#ga746c0625f1781f1ffc9056259103edbc
    image_list.append(-1*mask+255)

### Original: -------------------------------------------------------------------------------------------------
for method in method_list:
    file_path = os.path.join(out_dir, "DSM_{:}.csv".format(method))
    if os.path.isfile(file_path):
        pass
    else:
        if method == 'HuM_2':                   # Hu Moments
            dsm = make_Hu_dsm(images)
        elif method == 'log_HuM':               # Log-transformed Hu Moments
            dsm, log_Hu_M_list = compute_log_Hu_dsm(images)
        elif method == 'ZernikeM':              # Zernike Moments
            dsm, Zer_M_list = compute_Zernike_dsm(images, contours_ext)
        # elif method == 'SIFT':                # Scale-Invariant Feature Transform
        #     sift = cv2.SIFT_create()
        #     bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True) 
        #     dsm, descriptors = detect_compute_dsm(images, sift, bf)
        elif method == 'ORB':                   # Oriented FAST and Rotated BRIEF
            orb = cv2.ORB_create()
            bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True) 
            dsm, descriptors = detect_compute_dsm(images, orb, bf)
        elif method == 'SSIM':                  # Structural Similarity
            dsm = compute_ssim_dsm(image_list)
        elif method == 'Pixel':                 # Pixel-level Similarity
            dsm = compute_pixel_dsm(image_list, height, width, cmax=255)

        np.savetxt(file_path, dsm, delimiter=",")
   
### For each participant: -------------------------------------------------------------------------------------
file_paths = glob.glob(os.path.join(behav_dir, "logs", "*", "???_jigg_task.xlsx"))
sorted_file_paths = sorted(file_paths, key=lambda s: int(re.search(r'\d+', s.split("/")[-1]).group()))
sidx_list = [ int(fp.split("/")[-1][:3]) for fp in sorted_file_paths ]

### Make "Triplet_to_shapes.csv": -----------------------------------------------------------------------------
tpl_2_shapes_file = os.path.join(behav_dir, "familarity_test", "Triplet_to_shapes.csv")

tpl_2_shapes, DF, index4resort, index4resort_2 = {}, {}, {}, {}
sorted_tpl = pd.read_csv(os.path.join(behav_dir, "familarity_test", "Triplets_sortby_score.csv"), 
                            index_col=0, header=None)

for sidx, file_path in zip(sidx_list, sorted_file_paths):
    DF[sidx] = pd.read_excel(file_path, sheet_name='RUN_1', engine='openpyxl')
    DF[sidx] = DF[sidx].loc[:, ['Triplet', 'Label', 'Item']].drop_duplicates()

    ## Save the correspondence table between triplet groups and shape stimuli for each participant:
    tpl_2_shapes[sidx] = DF[sidx].sort_values(by=['Triplet', 'Label']).Item

    ## Sort by items first to align the original dissimilarity matrix:
    DF[sidx] = DF[sidx].sort_values(by=['Item']) 
    DF[sidx].reset_index(inplace=True)

    ## Then sort by the subject's triplet group to obtain the index of the reordered dissimilarity matrix:
    index4resort[sidx] = list(DF[sidx].sort_values(by=['Triplet', 'Label']).index)

    ## Translate: 'A' in sorted_tpl >> 1 in DF.Triplet
    old2new = {}
    for x in [1, 2, 3, 4]:
        o = sorted_tpl[x][int(sidx)]
        old2new[{'A': 1, 'B': 2, 'C': 3, 'D': 4}[o]] = x

    DF[sidx]['Sorted_Tpl'] = [ old2new[n] for n in DF[sidx].Triplet ]
    index4resort_2[sidx] = list( DF[sidx].sort_values(by=['Sorted_Tpl', 'Label']).index )

if os.path.isfile(tpl_2_shapes_file):
    pass
else:
    tpl_2_shapes = pd.DataFrame(tpl_2_shapes).T
    tpl_2_shapes.columns = ['A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','D3']
    tpl_2_shapes.to_csv(os.path.join(tpl_2_shapes_file))

### Main: -----------------------------------------------------------------------------------------------------
for method_name in method_list:
    DSM = np.genfromtxt(os.path.join(out_dir, "DSM_{:}.csv".format(method)), delimiter=",")

    for sidx in sidx_list:
        ## Use the index to reordered the dissimilarity matrix :
        sub_dsm = DSM[:, index4resort[sidx]][index4resort[sidx]]
        sub_fn = 'dsm_sub-{:}_{:}.csv'.format(sidx, method_name).format()
        np.savetxt(os.path.join(out_dir2, sub_fn), sub_dsm, delimiter=",")

        ## Again, for sorted triplets (by score):
        sub_dsm2 = DSM[:, index4resort_2[sidx]][index4resort_2[sidx]]
        sub_fn2 = 'dsm_sub-{:}_sorted_{:}.csv'.format(sidx, method_name).format()
        np.savetxt(os.path.join(out_dir2, sub_fn2), sub_dsm2, delimiter=",")