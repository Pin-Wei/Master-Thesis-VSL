#!/usr/bin/env python

# python Compute_DSMs_corr.py -a AP_IDX [--lss] [-t] [--reml] [--runs {0,1}] [--meas {0,1,2}]
#                             [-s {r,p,z}] [-dels DEL_SUBJS [DEL_SUBJS ...]]

import os
import re
import glob
import copy
import argparse
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy import stats
    # NOTE: this version is outdated (Python2 didn"t support updates),
    # we can only get two-tailed p-value: http://library.isr.ist.utl.pt/docs/scipy/generated/scipy.stats.ttest_rel.html

# from Plot_RDMs import plot_heatmap
from MVPA_functions import pearsonr_p, z_pearsonr, z_spearmanr
from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import meas_list, meas_help_txt, meas_choices, meas_default
from MVPA_constants import stype_dict, stype_choices, stype_default, stype_help_txt
from roiList_MVPA import roi_list, m_name_list

parser = argparse.ArgumentParser()
parser.add_argument("-a", "--ap_idx", type=int, required=True, help=ap_idx_help_txt)
parser.add_argument("--lss", action='store_true')
parser.add_argument("-t", "--tstats", action='store_true', help=tstat_help_txt)
parser.add_argument("--reml", action='store_true', help=reml_help_txt)
parser.add_argument("--runs",
                    type=int, choices=[0, 1], default=0,
                    help="Do for which runs: \
                        [0] pre- & post-exposure run \
                        [1] exposure runs")
parser.add_argument("--meas", type=int, choices=meas_choices, default=meas_default, help=meas_help_txt)
# parser.add_argument("-s", "--stimuli_type", type=int, choices=stype_choices, default=stype_default, help=stype_help_txt)
parser.add_argument("-s", "--stats_of_SMs", 
                    type=str, choices=["r", "p", "z"], default="r",
                    help="Caculate what statistic values between the similarity matrices: \
                    ['r']: Pearson correlation coefficients. \
                    ['p']: p-values of Pearson correlation coefficients. \
                    ['z']: Fisher's z-transformed Pearson correlation coefficient.")
parser.add_argument("-dels", "--del_subjs", 
                    nargs="+", default=[],
                    help="Specify numerical index(es) of subject(s) that you don't want to use.")
args = parser.parse_args()

## Setup variables: =============================================================================
# Data version: 
afni_desc = ap_version_list[args.ap_idx] 
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)

# Dis-similarity matrix measure:
meas = meas_list[args.meas]

# Which runs:
runs_include = ["r01_x_r10", "r02_to_r09"][args.runs] # "r01_x_r10_no-Z"
run_list, sufx = {
     "r01_x_r10" : (["01", "10"], "pre-post"),
     "r02_to_r09": (["{:02d}".format(x) for x in range(2, 10)], "expo-runs")
}[runs_include]
# t1, t2 = run_list[0], run_list[-1]

## Stimulus type:
stim_type, stim_list = list(stype_dict.items())[2]
# "tpl_sorted", ["A-1","A-2","A-3","B-1","B-2","B-3","C-1","C-2","C-3","D-1","D-2","D-3"]

## The similarity matrix (SM) of each ROI is measured by: 
sm_meas = "Pearson_r_z"

## The computed dissimilarity matrix is measured by: 
opencv_method_list = [
    "HuM_2",    # 0: Hu Moments
    "log_HuM",  # 1: Log-transformed Hu Moments
    "ZernikeM", # 2: Zernike Moments
    "ORB",      # 3: Oriented FAST and Rotated BRIEF
    "SSIM",     # 4: Structural Similarity
    "Pixel"     # 5: Pixel-level Similarity
]
cdsm_method_list = copy.deepcopy(opencv_method_list)
cnn_name = "googlenet"
cnn_meas = "1-corr" if meas == "correlation" else meas
cnn_layers = ["4d", "4e", "5a", "5b"]
cdsm_method_list = cdsm_method_list + [ "{:}_{:}".format(cnn_name, layer) for layer in cnn_layers ]

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
cnn_dir = os.path.join(top_dir, "Combined_group", "derivatives", "GoogLeNet")
rdm_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", "similarity_matrices")
mats_dir = os.path.join(rdm_top, stim_type, "ap-{:}".format(afni_desc), lss+estm, 
                        "PDist_{:}".format(meas), runs_include)
if stim_type == "shape_png":
    cdsm_dir = os.path.join(top_dir, "Combined_group", "derivatives", "Computed_DSMs", "original")
else:
    cdsm_dir = os.path.join(top_dir, "Combined_group", "derivatives", "Computed_DSMs", "individuals")
out_dir = os.path.join(cdsm_dir, "..", "DSM_corr")
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

## Main: ========================================================================================
print("\n## ====================================================================")
print("--> Data version:", afni_desc)
print("--> Parameter estimate:", lss+estm)
print("--> dis-similarity matrix measure:", meas)
print("--> Stimuli sort by:", stim_type)
# print("--> The computed dis-similarity matrix is measured by --", cdsm_meas)
if len(args.del_subjs) > 0 :
    print("** Skippig subjects:", args.del_subjs, "**")

cdsm_flatten_dict = {}
if stim_type == "shape_png":
    for method in cdsm_method_list:
        if method in opencv_method_list:
            cdsm_fp = os.path.join(cdsm_dir, "DSM_{:}.csv".format(method))
        else:
            layer = method.replace("{:}_".format(cnn_name), "")
            cdsm_fp = os.path.join(cnn_dir, "{:}_RDMs-{:}_inception{:}.csv".format(cnn_name, cnn_meas, layer))
        cdsm = np.loadtxt(cdsm_fp, delimiter=',')
        cdsm_flatten_dict[method] = cdsm[np.tril_indices(cdsm.shape[0], -1)]

corr_DF = { run: { roi: { method: {} for method in cdsm_method_list } for roi in m_name_list } for run in run_list }
corr_avg_DF = copy.deepcopy(corr_DF) 

for r, run in enumerate(run_list):
    out_fn = mats_dir.replace(rdm_top, "Run-{:}".format(run))
    # out_fn = out_fn.replace(runs_include, "")
    out_fn = out_fn.replace("_", "-")
    out_fn = "_".join(out_fn.split("/")[:-2])

    for roi in m_name_list:
        file_paths = glob.glob(os.path.join(mats_dir, "{:}_sub-*.csv".format(roi)))
        sorted_file_paths = sorted(file_paths, key=lambda s: int(re.search(r'\d+'.split("/")[-1], s).group()))
        subj_list = [ re.search(r'sub-[\d]+', fp.split("/")[-1])[0] for fp in sorted_file_paths ]

        for method in cdsm_method_list:
            cdsm_flatten = cdsm_flatten_dict[method]
            corr_avg = []

            for subj, file_path in zip(subj_list, sorted_file_paths):
                # sidx = int(subj[:3])
                full_mat = np.loadtxt(file_path, delimiter=",")
                sub_mat = full_mat[12*r: 12*(r+1), 12*r: 12*(r+1)]
                sub_mat_flatten = sub_mat[np.tril_indices(sub_mat.shape[0], -1)]            

                # if stim_type == "tpl_sorted":
                # elif stim_type == "tpl_orig":                
            
                ## How the SM of each ROI correlates with the computed DSM:
                if args.stats_of_SMs == 'z':
                    dsm_corr_val = z_pearsonr(cdsm_flatten, sub_mat_flatten)
                elif args.stats_of_SMs == 'p':
                    r_val, dsm_corr_val = stats.pearsonr(cdsm_flatten, sub_mat_flatten)
                else: # default
                    dsm_corr_val, p_val = stats.pearsonr(cdsm_flatten, sub_mat_flatten)

                corr_DF[run][roi][method][subj] = dsm_corr_val
                corr_avg.append(dsm_corr_val)

            corr_avg_DF[run][roi][method] = np.array(corr_avg).mean()

    out_DF = pd.DataFrame(corr_avg_DF[run])
    out_DF.to_csv(os.path.join(out_dir, "{:}.csv".format(out_fn)))

    x_labs = list(out_DF.columns)
    y_labs = cdsm_method_list
    wd, hi = 30, 15 # len(x_labs), len(y_labs)
    fig_title = out_fn.replace("_", "  ")

    plt.figure(figsize=(wd, hi), dpi=500)
    sns.set(style='white', font_scale=1.5)
    ax = sns.heatmap(out_DF, square=True, # vmin=cmin, vmax=cmax, 
                     cmap=["Spectral_r", "Reds", "jet", "coolwarm"][0], 
                     annot=True, fmt='.2f')
    ax.xaxis.set_major_locator(mpl.ticker.FixedLocator(np.arange(0, len(x_labs))))
    ax.yaxis.set_major_locator(mpl.ticker.FixedLocator(np.arange(0, len(y_labs))))
    ax.set_xticklabels(x_labs, rotation=90, ha="left")
    ax.set_yticklabels(y_labs, rotation=0, va="top")
    # ax.set_title(fig_title, fontsize=20)
    plt.suptitle(fig_title, fontsize=20)
    plt.tight_layout()
    plt.savefig(os.path.join(out_dir, "{:}.png".format(out_fn)), format='png')
    plt.close()
    plt.clf()
