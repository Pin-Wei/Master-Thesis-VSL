#!/usr/bin/env python
# -*- coding: utf-8 -*-

## Data modeling versions: ------------------------------------------------------------------------------------
ap_version_list = [
    "runs",         #  0 # IM + LSS  # no_blur
    "runs_v2",      #  1 # IM + LSS  # no_blur  # csf+wm
    "runs+behav",   #  2 # IM + LSS  # no_blur  # behav  <-- BAD
    "runs_v+",      #  3 # not IM    # no_blur
    "runs_v4",      #  4 # not IM    # blur_4   # csf+wm
    "runs_v4.2",    #  5 # LSS only  # blur_4   # csf+wm + task_targ  # single trial
    "runs_v4.3",    #  6 # LSS only  # no_blur  # csf+wm + task_targ
    "runs_v5",      #  7 # LSS only  # no_blur  # csf+wm + task_targ         # scaled
    "runs_v6",      #  8 # IM + LSS  # no_blur  # csf+wm + jigg_stim & press # scaled
    "runs_v7",      #  9 # IM + LSS  # no_blur  # csf+wm + (many jigg)       # scaled # adjust offset to include the 1-st trial
    "runs_v7.5",    # 10 # LSS only  # blur_4   # remains are the same as runs_v7
    "runs_v7.6",    # 11 # LSS only  # same as runs_v7.5 but include "jigg" trials
    "runs_v7.7"     # 12 # LSS only  # same as runs_v7.5 but polort = A
]
ap_default = 10
default_lss = [0, 1, 2, 5, 6, 7, 10, 11, 12]
ap_idx_help_txt = "Data modeling version. (Options: {:})".format(
    " ".join([ "[{:}] {:}".format(x, ap) for x, ap in enumerate(ap_version_list) ])
)

## Other help texts for data selection: -----------------------------------------------------------------------
tstat_help_txt = '''
    Serves t-statistics as the samples data in 'fmri_datasets' (default use LSS-estimated beta values)
'''
reml_help_txt = '''
    Use GLS estimated parameters (allows for serial correlation in the time series noise)
'''
no_im_help_txt = '''
    'NO' Individual Modulation (i.e., trial-wise estimations)
'''

## Runs selection: --------------------------------------------------------------------------------------------
from MVPA_functions import make_run_windows

pre_post_runs = ["01", "10"]
expo_runs = ["{:02d}".format(x) for x in range(2, 10)]
all_runs = ["{:02d}".format(x) for x in range(1, 11)]
run_group_dict = {
    0: {"name"   : "single_run", 
        "desc"   : "each single run",
        "ridxs"  : all_runs,
        "columns": ["run-{:}".format(run) for run in all_runs]
        },
    1: {"name"   : "run_windows", 
        "desc"   : "exposure run windows (default size=3)",
        "ridxs"  : expo_runs,
        "columns": make_run_windows(R_0=2, R_n=8, WS=3)[0],
        "indices": make_run_windows(R_0=2, R_n=8, WS=3)[1]
        },
    2: {"name"   : "exposure_runs", 
        "desc"   : "exposure runs combined",
        "ridxs"  : expo_runs,
        "columns": ["expo_runs"]
        },
    3: {"name"   : "all_10_runs", 
        "desc"   : "all 10 runs combined",
        "ridxs"  : all_runs,
        "columns": ["all_runs"]
        }
}
r_seg_help_txt = "Runs are group/segment by: (Options: {:})".format(
    " ".join([ "[{:}] {:}".format(x, xdict["desc"]) for x, xdict in run_group_dict.items() ])
)
r_seg_choices = list(range(len(run_group_dict)))
r_seg_default = 1

## Measurements of dis-similarity matrix: ---------------------------------------------------------------------
meas_list = ["euclidean", "correlation", "hamming", "cosine", "sqeuclidean"] 
    # see scipy.spatial.distance.pdist for more metric options.
meas_help_txt = "What measurement: (Options: {:})".format(
    " ".join([ "[{:}] {:}-based dis-similarity matrix".format(x, meas) for x, meas in enumerate(meas_list) ])
)
meas_choices = list(range(len(meas_list)))
meas_default = 1

## Stimulus sort types: ---------------------------------------------------------------------------------------
stype_dict = {
    'tpl_orig': ['A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','D3'],
    'tpl_sorted': ['A-1','A-2','A-3','B-1','B-2','B-3','C-1','C-2','C-3','D-1','D-2','D-3'],
    'shape_png': [ '{:02d}'.format(x) for x in range(1, 13) ]
}
stype_choices = list(range(len(stype_dict)))
stype_default = 1
stype_help_txt = '''
    The type of stimulus to serve as the matrix index:      \
    [0] The original triplets defined for each participant. \
    [1] The triplets sorted by each participant's score.    \
    [2] The geometric shapes (.png file name).
'''

## Mappers & Classifiers: -------------------------------------------------------------------------------------
mapper_name_dict = {
    ""          : "None", 
    "SVD."      : "Singular Value Decomposition", 
    "StatProj." : "Static Projection", 
    "StatFeat." : "Static Feature Selection", 
    "1WayAnova.": "One-Way Anova"
}
mapper_help_txt = "Type of mapper: (Options: {:})".format(
    " ".join([ "[{:}] {:}".format(x, desc) for x, desc in enumerate(mapper_name_dict.values()) ])
)
mapper_key_list = list(mapper_name_dict.keys())
mapper_choices = list(range(len(mapper_name_dict)))
mapper_default = 0

clf_name_dict = {
    "LinearCSVMC": "Linear Support Vector Machine", 
    "RbfCSVMC":    "Radial Basis Function Support Vector Machine", 
    "10NN":        "K-Nearest Neighbor (K=10)", 
    "SMLR":        "Sparse Multinomial Logistic Regression"
}
clf_help_txt = "Type of classfier: (Options: {:})".format(
    " ".join([ "[{:}] {:}".format(x, desc) for x, desc in enumerate(clf_name_dict.values()) ])
)
clf_key_list = list(clf_name_dict.keys())
clf_choices = list(range(len(clf_name_dict)))

## Other help texts for Classification: -----------------------------------------------------------------------
tpl_help_txt = '''
    Classifying the 4 triplets instead of the 12 shapes.
'''
n_fold_help_txt = '''
    Number of folds for cross validation (default: None)
'''
do_avg_help_txt = '''
    Apply 'mean_group_sample' for each target per chunk
'''

