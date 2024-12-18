#!/usr/bin/env python
# coding: utf-8

import os
import glob
import subprocess
import pandas as pd
import numpy as np

task = 'slowVSL'
top_dir = '/media/data2/pinwei/SL_hippocampus/Nifti_slow'
space = 'MNI152NLin2009cAsym'
sufx = 'tlrc'

prep_dir = os.path.join(top_dir, 'derivatives', 'fmriprep_fmap_RL')
afni_dir = os.path.join(top_dir, 'derivatives', 'afni_out', 'SS_results_1207')

stat_ver = 'Order.'
cond = 'exposure_All_GLT'
pfx = 'all-expo'

nn = 3
FWERs = 0.05 # family-wise error rate

roi_list = ['PHC', 'PRC', 'ERC', 'HPC', 'DG', 'CA3', 'CA1', 'Sub', 
            'Lat_Occi', 'V1', 'V2', 'V3', 'MT', None]

# Loop over all subject results directories:
subjList = list(pd.read_csv('subjList.txt', header=None)[0])

for side in ['1sided', 'bisided']: # -------------------------------------------------------------------------
    if side == '1sided':
        p_val = 0.001
        set_p_threshold = '-{0} {1} p={2}'.format(side, 'RIGHT_TAIL', p_val)
    elif side == 'bisided':
        p_val = 0.05
        set_p_threshold = '-{0} p={1}'.format(side, p_val)

    for subj in subjList: # ----------------------------------------------------------------------------------        
        roimask_dir = os.path.join(prep_dir, subj, 'anat', 'ROImasks')
        func_mask_dir = os.path.join(prep_dir, subj, 'func', 'Masks')
        subj_fd = '{:}.results'.format(subj)
        out_dir = os.path.join(afni_dir, subj_fd, 'Clusters')
        if not os.path.exists(out_dir):
            os.makedirs(out_dir)

        # Read the cluster threshold from the ClustSim output file
        clustsim_file = os.path.join(afni_dir, subj_fd, 'files_ClustSim', 
                                    'ClustSim.ACF.NN{:}_{:}.1D'.format(nn, side))
        
        thresholds = pd.read_csv(clustsim_file, delim_whitespace=True, comment="#", index_col=0, header=None)
            ## indexs: uncorrected (per voxel) p-values # colnames: corrected (whole volume) alpha-values
        col = ['pthr', .10, .09, .08, .07, .06, .05, .04, .03, .02, .01].index(FWERs)
        n_vox = np.ceil(thresholds[col][p_val])# cluster threshold

        for roi in roi_list: # -------------------------------------------------------------------------------
            if roi is not None:
                subj_mask = os.path.join(roimask_dir, 'roimask_space-{:}_{:}_resam.nii.gz'.format(space, roi))
                out_desc = '{:}_{:}_{:}_{:}'.format(subj, pfx, roi, side)
            else:
                # Load (or make if not exist) the functional mask (as the restriction mask for 3dClusterize):
                subj_mask = os.path.join(func_mask_dir, '{:}_all-runs_space-{:}_mask.nii.gz'.format(subj, space))
                if not os.path.exists(subj_mask):
                    command = ['3dmask_tool', '-overwrite', '-fill_holes', '-frac', '0.9', 
                            '-prefix', subj_mask, '-input', 
                            os.path.join(func_mask_dir, '{:}_task-{:}_run-??_space-{:}_desc-brain_mask.nii.gz'.format(subj, task, space))]
                    subprocess.run(command)
                out_desc = '{:}_{:}_wholeBrain_{:}'.format(subj, pfx, side)
                    
            # Run 3dClusterize on the subject's statistical image file:
            input_stats = os.path.join(afni_dir, subj_fd, '{:}stats.{:}+{:}'.format(stat_ver, subj, sufx))
            out_prefix = os.path.join(out_dir, out_desc)        
            command = ['3dClusterize', '-overwrite', 
                    '-pref_map', '{:}_cluster-mask'.format(out_prefix), 
                    '-pref_dat', '{:}_cluster-dat'.format(out_prefix),                
                    '-mask', subj_mask, 
                    '-inset', input_stats, 
                    '-idat', "{:}'#0_Coef'".format(cond), 
                    '-ithr', "{:}'#0_Tstat'".format(cond),                
                    '-NN', str(nn), '-clust_nvox', str(n_vox), set_p_threshold, 
                    '>', '{:}_cluster-report.1D'.format(out_prefix)]
            subprocess.run(' '.join(command), shell=True)

            # delete if **NO CLUSTERS FOUND**
            report_file = os.path.join(out_dir, '{:}_cluster-report.1D'.format(out_prefix))
            with open(report_file, "r") as f:
                if f.readline().strip() == "#** NO CLUSTERS FOUND ***":
                    del_files = glob.glob('{:}*'.format(out_prefix))
                    for del_file in del_files:
                        os.remove(del_file)

            # 3dcopy a nifti version:
            for out_type in ['mask', 'dat']:
                command = ['3dcopy', '-overwrite', 
                        '{:}_cluster-{:}+{:}'.format(out_prefix, out_type, sufx), 
                        '{:}_cluster-{:}.nii.gz'.format(out_prefix, out_type)]
                subprocess.run(command)
