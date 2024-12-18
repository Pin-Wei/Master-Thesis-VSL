#!/usr/bin/env python
# coding: utf-8

# python Plot_RDMs.py -a {0,1,2,3,4} [--lss] [-t] [--reml] [--runs {0,1}] [-s {0,1,2}] [--meas {0,1}] [--re_plot]

import warnings
warnings.filterwarnings("ignore")

import os
import re
import glob
import argparse
import numpy as np
# import pandas as pd
import seaborn as sns
import matplotlib as mpl
# mpl.use('Agg')
import matplotlib.pyplot as plt

from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import stype_dict, stype_choices, stype_default, stype_help_txt
from MVPA_constants import meas_list, meas_help_txt, meas_choices, meas_default
from MVPA_constants import pre_post_runs, expo_runs, all_runs
# from roiList_MVPA import m_name_list

## Create argument parser objects: --------------------------------------------------------------
parser = argparse.ArgumentParser(description="")
parser.add_argument("-a", "--ap_idx", type=int, required=True, help=ap_idx_help_txt)
parser.add_argument("--lss", action='store_true')
parser.add_argument("-t", "--tstats", action='store_true', help=tstat_help_txt)
parser.add_argument("--reml", action='store_true', help=reml_help_txt)
parser.add_argument("--runs",
                    type=int, choices=[0, 1], default=0,
                    help="Do for which runs: \
                        [0] pre- & post-exposure run \
                        [1] exposure runs")
parser.add_argument("-s", "--stimuli_type", type=int, choices=stype_choices, default=stype_default, help=stype_help_txt)
parser.add_argument("--meas", type=int, choices=meas_choices, default=meas_default, help=meas_help_txt)
parser.add_argument("--re_plot", action='store_true', default=False)
args = parser.parse_args()

## Define function(s): --------------------------------------------------------------------------
def plot_heatmap(cormat, labels, fig_title, fp, 
                 mask_triu=True, wd=8, hi=8, ft_size=20,
                 cmap=["Spectral", "Blues", "jet", "coolwarm_r"][0], 
                #  cmin=-1, cmax=1,
                 draw_lines=None,
                 show_value=False, fmt='.1f'):
    ''''''
    plt.figure(figsize=(wd, hi), dpi=500)
    sns.set(style='white', font_scale=1.2)
    if mask_triu:
        mask = np.zeros_like(cormat)            # Mask the upper triangle
        mask[np.triu_indices_from(mask)] = True # Return the indices for the upper-triangle of arr.
        ax = sns.heatmap(cormat, cmap=cmap, square=True, mask=mask, 
                         # vmin=cmin, vmax=cmax, 
                         annot=show_value, fmt=fmt)
    else:
        ax = sns.heatmap(cormat, cmap=cmap, square=True, 
                         # vmin=cmin, vmax=cmax, 
                         annot=show_value, fmt=fmt)
    ax.xaxis.set_major_locator(mpl.ticker.FixedLocator(np.arange(0, len(labels))))
    ax.yaxis.set_major_locator(mpl.ticker.FixedLocator(np.arange(0, len(labels))))
    # ax.set_xticklabels(labels, rotation=45, ha='left')
    # ax.xaxis.tick_top()
    ax.set_xticklabels(labels, rotation=90)
    ax.set_yticklabels(labels, rotation=0)
    for p in np.arange(0, len(labels), 3):
        ax.axhline(p, color="#FFFFFF")
        ax.axvline(p, color="#FFFFFF")
    if draw_lines is not None:
        for p in np.arange(0, len(labels), 12):
            ax.axhline(p, color="#FFFFFF", linewidth=3)
            ax.axvline(p, color="#FFFFFF", linewidth=3)
        # ax.hlines(draw_lines, 0, len(labels), color="#FFFFFF", linewidth=2.5) # linestyles="dashed"
        # ax.vlines(draw_lines, 0, len(labels), color="#FFFFFF", linewidth=2.5)
    ax.set_title(fig_title, fontsize=ft_size)
    # plt.suptitle(fig_title, fontsize=20)
    plt.tight_layout()
    plt.savefig(fp, format='png')
    plt.close()
    plt.clf()

## Setup variables: -----------------------------------------------------------------------------
# Data version: 
afni_desc = ap_version_list[args.ap_idx] 
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)

# Which runs:
runs_include = ["r01_x_r10", "r02_to_r09"][args.runs] # "r01_x_r10_no-Z"
run_list = {
     "r01_x_r10" : pre_post_runs,
     "r02_to_r09": expo_runs
}[runs_include]

## Stimulus type:
stim_type, stim_list = list(stype_dict.items())[args.stimuli_type]

meas = meas_list[args.meas]

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
mats_dir = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", 
                        "similarity_matrices", stim_type, "ap-{:}".format(afni_desc), lss+estm, 
                        "PDist_{:}".format(meas), runs_include)
fig_dir = mats_dir.replace("similarity_matrices", "similarity_matrix_figures")
if not os.path.exists(fig_dir):
    os.makedirs(fig_dir)

## Main: ========================================================================================
print "\n## ===================================================================="
print "--> Data version:", afni_desc
print "--> Parameter estimate:", lss+estm
print "--> (dis)similarity matrix measure:", meas
print "--> Stimuli name by:", stim_type
print ""

for file_path in glob.glob(os.path.join(mats_dir, '*.csv')):
    file_name = file_path.split("/")[-1]
    fig_name = file_name.replace(".csv", ".png")
    
    if os.path.isfile(os.path.join(fig_dir, fig_name)) & ( not args.re_plot ):
        # print "** figure '{:}' has processed, skip!".format(fig_name)
        pass
    elif file_name == "all_similarity_changes.csv":
        pass
    else:
        subj = re.findall(r'(sub-[\d]+).csv', file_name)[0]
        roi = file_name.replace("_{:}.csv".format(subj), "")
        fig_title = "ROI: {:}, {:}\n{:}-based RDM".format(roi, subj, meas)

        full_mat = np.loadtxt(file_path, delimiter=',')
        f_wd, f_hi, f_tit = (10, 10, 20) if args.runs == 0 else (20, 18, 30)
        labels = []
        for r in run_list:
            labels += stim_list
        print "... plotting {:} ...".format(fig_name)
        plot_heatmap(full_mat, 
                     labels=labels, 
                     draw_lines=len(stim_list),
                     fig_title=fig_title, wd=f_wd, hi=f_hi, ft_size=f_tit,
                     fp=os.path.join(fig_dir, fig_name))
        
        if args.runs == 0:
            sub_mats = {
                '01': full_mat[:12, :12],
                '10': full_mat[12:, 12:]
            }
            for run, mat in sub_mats.items():
                f_title = "ROI: {:}, {:}, run-{:}\n{:}-based RDM".format(roi, subj, run, meas)
                fig_dir_changed = fig_dir.replace(runs_include, "run-{:}".format(run))
                if not os.path.exists(fig_dir_changed):
                    os.makedirs(fig_dir_changed)
                plot_heatmap(mat, labels=stim_list, 
                            fig_title=f_title, 
                            fp=os.path.join(fig_dir_changed, fig_name))
            
print "## =============================== Done =============================== \n"
