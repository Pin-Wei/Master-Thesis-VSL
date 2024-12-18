#!/usr/bin/python

import os
import re
import glob
import numpy as np
import pandas as pd

mat_dir = os.path.join('dis-similarity_matrices', 'original')
out_dir = mat_dir.replace('original', 'individual')
if not os.path.exists(out_dir):
    os.makedirs(out_dir)
out_dir2 = mat_dir.replace('original', 'individual_sorted')
if not os.path.exists(out_dir2):
    os.makedirs(out_dir2)

method_list = [
    'HuM_2',    # Hu Moments
    'log_HuM',  # Log-transformed Hu Moments
    'ZernikeM', # Zernike Moments
    'ORB',      # Oriented FAST and Rotated BRIEF
    'SSIM',     # Structural Similarity
    'Pixel'     # Pixel-level Similarity
]

## =====================================================================================
SID_list = [f'PW%03d' %x for x in range(2, 13)] + \
    ['Slow101', 'Slow102'] + ['Slow{:}'.format(x) for x in range(104, 128)] 

sorted_tpl = pd.read_csv(os.path.join('familarity_test', 'Triplets_sortby_score.csv'), 
                         index_col=0, header=None)

tpl_2_shapes, DF, index4resort, index4resort_2 = {}, {}, {}, {}

for SID in SID_list:
    sidx = re.search(r'\d+', SID).group()

    fd = os.path.join('logs', SID)
    fn = '{:}_jigg_task.xlsx'.format(sidx)

    DF[sidx] = pd.read_excel(os.path.join(fd, fn), sheet_name='RUN_1', engine='openpyxl')
    DF[sidx] = DF[sidx].loc[:, ['Triplet', 'Label', 'Item']].drop_duplicates()

    ## Save the correspondence table between triplet groups and shape stimuli for each participant:
    tpl_2_shapes[sidx] = DF[sidx].sort_values(by=['Triplet', 'Label']).Item

    ## Sort by items first to align the original (dis)similarity matrix:
    DF[sidx] = DF[sidx].sort_values(by=['Item']) 
    DF[sidx].reset_index(inplace=True)

    ## Then sort by the subject's triplet group to obtain the index of the reordered (dis)similarity matrix:
    index4resort[sidx] = list(DF[sidx].sort_values(by=['Triplet', 'Label']).index)

    ## Translate: 'A' in sorted_tpl >> 1 in DF.Triplet
    old2new = {}
    for x in [1, 2, 3, 4]:
        o = sorted_tpl[x][int(sidx)]
        old2new[{'A': 1, 'B': 2, 'C': 3, 'D': 4}[o]] = x

    DF[sidx]['Sorted_Tpl'] = [ old2new[n] for n in DF[sidx].Triplet ]
    index4resort_2[sidx] = list( DF[sidx].sort_values(by=['Sorted_Tpl', 'Label']).index )
    
tpl_2_shapes = pd.DataFrame(tpl_2_shapes).T
tpl_2_shapes.columns = ['A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','D3']
tpl_2_shapes.to_csv(os.path.join('familarity_test', 'Triplet_to_shapes.csv'))

## =====================================================================================
for method_name in method_list:
    DSM_fn = 'DSM_{:}.csv'.format(method_name)
    DSM = np.genfromtxt(os.path.join(mat_dir, DSM_fn), delimiter=",")

    for SID in SID_list:
        sidx = re.search(r'\d+', SID).group()

        ## Use the index to reordered the (dis)similarity matrix :
        sub_dsm = DSM[:, index4resort[sidx]][index4resort[sidx]]
        sub_fn = 'dsm_{:}_{:}.csv'.format(sidx, method_name).format()
        np.savetxt(os.path.join(out_dir, sub_fn), sub_dsm, delimiter=",")

        ## Again, for sorted triplets (by score):
        sub_dsm2 = DSM[:, index4resort_2[sidx]][index4resort_2[sidx]]
        sub_fn2 = 'dsm_{:}-sorted_{:}.csv'.format(sidx, method_name).format()
        np.savetxt(os.path.join(out_dir2, sub_fn2), sub_dsm2, delimiter=",")

