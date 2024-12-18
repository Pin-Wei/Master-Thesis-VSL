#!/usr/bin/env python
# coding: utf-8

import os
import re
import glob
import numpy as np
import pandas as pd
import nibabel as nib
import matplotlib.pyplot as plt
from scipy import stats

try:
    from mvpa2.suite import SampleAttributes
except ImportError:
    pass

try:
    import brainiak.utils.utils as utils
except ImportError:
    pass

try:
    import cPickle as pickle
except ImportError:
# except ModuleNotFoundError:
    import pickle
    
def save_object(obj, filename):
    with open(filename, 'wb') as outp:  # Overwrites any existing file.
        pickle.dump(obj, outp, pickle.HIGHEST_PROTOCOL)

def subj_file_exist(fd, fn):
    path_list = glob.glob(os.path.join(fd, fn))
    subj_list = [ re.findall('(sub-[0-9]+)', path)[0] for path in path_list ]
    return set(subj_list)

def get_the_mask(space, mask_type, roi=None, subj='', prep_dir='', afni_dir='', grp_dir=''):
    name = {'w': 'w',                                   # whole brain mask
            # 'f': 'func{:}'.format(roi),                 # functional significant cluster
            'a': roi,                                   # anatomical ROI mask
            # 's': 'sph-{:}'.format(roi),                 # spherical mask
            # 'g': 'grp-func_{:}'.format(roi)             # group-based functional cluster  
    }[mask_type] 
    # ver = 1029 if space == 'T1w' else 1207
    fdir = {
        'w':{'fd': os.path.join(prep_dir, subj, 'anat'),
             'fn': 'mask_space-{:}_resam.nii.gz'.format(space)},
        # 'f':{'fd': os.path.join(afni_dir,'SS_results_{:}'.format(ver),'{:}.results'.format(subj)),
        #      'fn': '{0}_all-expo{1}_cluster-mask.nii.gz'.format(subj, roi)},
        'a':{'fd': os.path.join(prep_dir, subj, 'anat', 'ROImasks'),
             'fn': 'roimask_space-{0}_{1}_resam.nii.gz'.format(space, roi)},
        # 's':{'fd': os.path.join(grp_dir, 'derivatives', 'single-subj_masks'),
        #      'fn': '{0}_func-roi_{1}_{2}_sphere.nii.gz'.format(subj, roi, space)},
        # 'g':{'fd': os.path.join(grp_dir, 'derivatives', 'single-subj_masks', 'group_clusters'),
        #      'fn': '{0}_func-roi_{1}_mask_{2}.nii.gz'.format(subj, roi, space)}
    }[mask_type]    
    return name, fdir['fd'], fdir['fn']

def get_coords(roimask):
    ''' Retrive the coordinates of voxels from the ROI mask'''
    I, J, K = roimask.shape
    all_coords = np.zeros((I, J, K, 3)) 
    all_coords[..., 0] = np.arange(I)[:, np.newaxis, np.newaxis]
    all_coords[..., 1] = np.arange(J)[np.newaxis, :, np.newaxis]
    all_coords[..., 2] = np.arange(K)[np.newaxis, np.newaxis, :]
    ROI_coords = nib.affines.apply_affine(roimask.affine, 
                                          all_coords[roimask.get_fdata().astype(bool)])
    return ROI_coords

def pearsonr_p(x, y):
    r, p = stats.pearsonr(x, y)  
    return p

def z_pearsonr(x, y):
    ''' 
    Calculate Pearson correlation coefficient 
    and do Fisher's z-transformation (which is equalvent to the inverse hyperbolic tangent)
        i.e., arctanh(r) == np.log((1+r)/(1-r))/2 )
    '''
    r, p = stats.pearsonr(x, y)
    r_z = np.arctanh(r)   
    return r_z

def z_spearmanr(x, y):
    r, p = stats.spearmanr(x, y)
    r_z = np.arctanh(r)   
    return r_z

def get_ci(r_z, n, alpha=.05):
    '''
    Get confidient interval
    '''
    se = 1 / np.sqrt(n-3)                # standard error
    zscore = stats.norm.ppf(1 - alpha/2) # percent point function 
    lo_z = r_z - se*zscore
    hi_z = r_z + se*zscore
    lo, hi = np.tanh((lo_z, hi_z))
    return lo, hi

def make_run_windows(R_0=2, R_n=8, WS=3):
    """
    Args:
        R_0 (int): start run.
        R_n (int): run length.
        WS  (int): window size.
    returns:
        desc_list (str list)      : list of "names" (e.g., "r_234" if run=2, ws=3).
        window_list (list of list): list of "indices" (e.g., ["02", "03", "04"])
    """
    desc_list, window_list = [], []
    for R_i in range(R_0, (R_0 +R_n -WS +1)):
        r_name = "r_"
        for x in range(WS):
            r_name += str(R_i+x) 
        desc_list.append(r_name) 
        window_list.append(["{:02d}".format(R_i+x) for x in range(WS)]) 

    return desc_list, window_list

### for PyMVPA: (use env: 'python2') -----------------------------------------------------------------
class rawDataSet_4_Py2:
    def __init__(self, sid, data_dir, data_fn, attr_fn):       
        '''
        Save the PATH of trial-wise parameter estimations 
            # includes t-statistic values and least-square sum (LSS) estimated beta values
        and LOAD the corresponding attribute file.
            # default target type is "trials" (instead of "Triplets")    
        '''
        self.sid = sid
        self.mask = {}
        
        if os.path.exists(data_dir):
            self.data_dir = data_dir # AFNI output dir
            self.data_path = os.path.join(data_dir, data_fn)
            self.data_attr = SampleAttributes(os.path.join(data_dir, attr_fn))
        
    def save_mask_paths(self, m_name, mask_dir):
        if os.path.exists(mask_dir):
            self.mask[m_name] = mask_dir
        else:
            self.mask[m_name] = None
            # print 'NOTE:', self.sid, "don't have '{:}' mask".format(m_name)

    def add_familarity_score(self, behav_data, sorted_tpl, sorted_tpl_scores):
        s_int = int(self.sid.replace('sub-', ''))
        self.test_score = behav_data['N_correct'][s_int]
        self.update_tpl, self.tpl_scores = {}, {}
        for x, new_id in enumerate(['A-', 'B-', 'C-', 'D-']):
            old_id = sorted_tpl[x+1][s_int]
            self.update_tpl[old_id] = new_id 
                # take sub-02 for example, {'B':'A-' ,'C':'B-' ,'D':'C-' ,'A':'D-' }
            tpl_score = sorted_tpl_scores[x+1][s_int]
            self.tpl_scores[new_id] = tpl_score
                # take sub-02 for example, {'A-':8 ,'B-':5 ,'C-':4 ,'D-':3 }
        self.inverse_tpl = { tpl[1]: tpl[0] for tpl in self.update_tpl.items() }

    def to_orig_shapes(self, stim_list, tpl_2_shapes):
        s_int = int(self.sid.replace('sub-', ''))
        self.tpl_2_shape = { stim: tpl_2_shapes[stim][s_int] for stim in stim_list }
        old_2_sorted_tpl = {}
        for tpl in self.update_tpl.items():
            for ord in range(1, 4):
                old_2_sorted_tpl[tpl[0]+str(ord)] = tpl[1]+str(ord)
        self.sorted_tpl_2_shape = { old_2_sorted_tpl[item[0]]: item[1] for item in self.tpl_2_shape.items() }

###
def plot_mtx_Py2(mtx, labels, title, fd=None, fn=None, cmin=-1, cmax=1, cmap='coolwarm'):
    if fd == None:
        fd = '../derivatives/PyMVPA'
    if fn == None:
        fn = title.replace('\n', ' ') + '.png'
    fig = plt.figure(num=None, figsize=(5, 5), dpi=100)
    plt.imshow(mtx, interpolation='nearest', cmap=cmap)
    x = 2.5
    for n in range(3): 
        plt.axvline(x, color='black')
        plt.axhline(x, color='black')
        x += 3
    plt.xticks(range(len(mtx)), labels, rotation=-45)
    plt.yticks(range(len(mtx)), labels)
    plt.title(title)
    plt.clim((cmin, cmax))
    plt.colorbar()
    plt.savefig(os.path.join(fd, fn))
    plt.close(fig)
    plt.clf()

### for Baysian RSA: (use env: 'mybrainiak') ---------------------------------------------------------
class rawDataSet_4_Bayes:
    def __init__(self, sid, data_dir):        
        self.sid = sid
        self.mask_dir = {}
        self.mask = {}
        self.mask_xyz = {}

        if os.path.exists(data_dir):
            # AFNI output dir:
            self.data_dir = data_dir
            # Pre-processed BOLD signal (concatenate all fMRI runs):
            self.preproc_bold = nib.load(os.path.join(data_dir, 'all_runs.{:}.nii.gz'.format(sid)))
            # The file indicating which time points are to be included (1) OR excluded (0):
            self.cencor_1D = pd.read_csv(os.path.join(data_dir, 'censor_{:}_combined_2.1D'.format(sid)), header=None)
            # The regression model (design matrix, setup by 3dDeconvolve):
            self.design = utils.ReadDesign(os.path.join(data_dir, 'X.xmat.1D'))           
                # NOTE.1: times offset is corrected. 
                # NOTE.2: model BOLD-HRF with a fixed shape (default 'GAM', gamma function)
        
    def load_motion_1D(self, suffix):
        if os.path.exists(self.data_dir):
            # The 6 head-motion parameters (extracted from fMRIPrep outputs):
            fn = os.path.join(self.data_dir, 'head-motion_{:}.1D'.format(suffix))
            self.motion_1D = pd.read_csv(fn, sep='\t', header=None,
                                         names=['trans_x','trans_y','trans_z','rot_x','rot_y','rot_z'])            
                
    def load_mask_infos(self, m_name, mask_dir):
        if os.path.exists(mask_dir):
            self.mask_dir[m_name] = mask_dir
            self.mask[m_name] = nib.load(mask_dir)
            self.mask_xyz[m_name] = get_coords(self.mask[m_name]) # (x, y, z) coordinates
        else:
            self.mask_dir[m_name] = None
            # print('NOTE:', self.sid, "don't have '{:}' mask".format(m_name))
            
    def add_familarity_score(self, behav_data, sorted_tpl, sorted_tpl_scores):
        s_int = int(self.sid.replace('sub-', ''))
        self.test_score = behav_data['N_correct'][s_int]
        self.update_tpl, self.tpl_scores = {}, {}
        for x, new_id in enumerate(['A-', 'B-', 'C-', 'D-']):
            old_id = sorted_tpl[x+1][s_int]
            self.update_tpl[old_id] = new_id 
                # take sub-02 for example, {'B':'A-' ,'C':'B-' ,'D':'C-' ,'A':'D-' }
            tpl_score = sorted_tpl_scores[x+1][s_int]
            self.tpl_scores[new_id] = tpl_score
                # take sub-02 for example, {'A-':8 ,'B-':5 ,'C-':4 ,'D-':3 }
###
def plot_mtx_Py3(mtx, labels, title, fd=None, fn=None, cmin=-1, cmax=1, cmap='coolwarm'):
    if fd == None:
        fd = '../derivatives'
    if fn == None:
        fn = title.replace('\n', ' ') + '.png'    
    fig = plt.figure(num=None, figsize=(5, 5), dpi=100)
    plt.pcolor(mtx, cmap=cmap)
    plt.colorbar()
    x = 3
    for n in range(3): 
        plt.axvline(x, color='white')
        plt.axhline(x, color='white')
        x += 3
    ax = plt.gca()
    ax.set_aspect('equal')
    plt.xlim([0, len(labels)])
    plt.ylim([0, len(labels)])    
    plt.title(title)
    plt.xlabel('conditions')
    plt.ylabel('conditions')
    ticks = [x+0.5 for x in range(len(mtx))]
    plt.xticks(ticks, labels, rotation=-45)
    plt.yticks(ticks, labels)
    plt.clim((cmin, cmax))
    plt.savefig(os.path.join(fd, fn))
    plt.close(fig)
    plt.clf()



    
