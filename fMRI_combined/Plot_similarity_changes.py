#!/usr/bin/env python
# -*- coding: utf-8 -*-

# python Plot_similarity_changes.py 

import os
import re
import glob
import argparse
import numpy as np
import pandas as pd
from scipy import stats       
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt

from RSA_target_matrices import *
from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import stype_dict, stype_choices, stype_default, stype_help_txt
from MVPA_constants import meas_list, meas_help_txt, meas_choices, meas_default
from roiList_MVPA import m_name_list

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
parser.add_argument("--targA", type=int, default=0, 
                    help="See which target? \
                        [0] Items within the same triplet \
                        [1] The 1-st pairs within a triplet \
                        [2] The 2-nd pairs within a triplet \
                        [3] Non-adjcent items within a triplet \
                        [4] Across-boundaries items (rare_connect) \
                        [5] Items within the triplet that get highest score \
                        [6] The First items of each triplet \
                        [7] The second items of each triplet \
                        [8] The third items of each triplet \
                        [9] Items in different triplet ")
parser.add_argument("--targB", type=int, default=0, 
                    help="Compare to which target? \
                        [0] Items that had never came together (irrelvant) \
                        [1] Across-boundaries items (rare_connect) \
                        [2] Items in different triplet")
parser.add_argument("--fn_extend", type=str, default="", help="add to filename")
parser.add_argument("--re_plot", action='store_true', default=False)
parser.add_argument("--re_stats", action='store_true', default=False)
parser.add_argument("--update_df", action='store_true', default=False)
args = parser.parse_args()

## Setup variables: -----------------------------------------------------------------------------
# Data version: 
afni_desc = ap_version_list[args.ap_idx] 
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)
meas = meas_list[args.meas]
sub_folder = ["r01_x_r10", "r02_to_r09"][args.runs]
stim_type, stim_list = list(stype_dict.items())[args.stimuli_type]

subj_include = ["", "_rapid", "_slow"][0]

# fig_roi_options = ["Vis.MTL.Hipp", "Hipp.MTL_LR"]
fig_roi_options = ["Vis.Hipp", "Hipp_sub4"]

roi_select_dict = {
    "Vis.Hipp": ([
        "V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "Hippocampus"
    ], (10, 10)), 
    "Hipp_sub4": ([
        "Hipp-DG+CA4", "Hipp-CA2+3", "Hipp-CA1", "Hipp-Sub" 
    ], (10, 10)), 
    "Vis.MTL.Hipp": ([
        "V1+2", "LOC-V12", "Fusiform", "Inf_Temp", 
        "PHC", "PRC", "ERC", "Hippocampus", 
    ], (15, 10)), 
    "Hipp.MTL_LR": ([
        "lh-PHC",         "rh-PHC", 
        "lh-PRC",         "rh-PRC", 
        "lh-ERC",         "rh-ERC", 
        "lh-Hippocampus", "rh-Hippocampus", 
        "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", 
        "lh-Hipp-CA2+3",  "rh-Hipp-CA2+3", 
        "lh-Hipp-CA1",    "rh-Hipp-CA1", 
        "lh-Hipp-Sub",    "rh-Hipp-Sub"
    ], (20, 10))
}

targ_matrices = [fst_pairs, snd_pairs, tpl_nonadj, within_tpl, 
                 rare_connect, irrelvant, diff_tpl, 
                 tpl_A, tpl_B, tpl_C, tpl_D, Fst, Snd, Trd]
targ_namelist = ['fst.pairs', 'snd.pairs', 'tpl.nonadj', 'within.tpl', 
                 'rare.connect', 'irrelvant', 'diff.tpl',
                 "tpl.A", "tpl.B", "tpl.C", "tpl.D", "Fst", "Snd", "Trd"]

tar_a, tar_a_color = [
    ("within.tpl", "b"),       # blue
    ("fst.pairs",  "#FF9933"), # orange
    ("snd.pairs",  "#33FF99"), # mint
    ("tpl.nonadj", "#FF6699"), # pink
    ("rare.connect", "r"),     # red
    ("tpl.A",      "#3399FF"), # another blue
    ("Fst",        "#9933FF"), # purple
    ("Snd",        "#9933FF"), # purple
    ("Trd",        "#9933FF"), # purple
    ("diff.tpl",   "#FFCC00")  # yellow
][args.targA]

tar_b, tar_b_color = [
    ("irrelvant",    ".85"),    # gray
    ("rare.connect", "r"),      # red
    ("diff.tpl",     "#FFCC00") # yellow
][args.targB]

## Define function(s): --------------------------------------------------------------------------
def do_ttests(smc_DF, roi_list, targ1, targ2=None, alt="two-sided"):
    tt_res = { roi: {} for roi in m_name_list }
    for roi in roi_list:
        select_roi = smc_DF.columns.get_level_values("ROI").isin([roi])
        smc_DF_roi = (smc_DF.loc[:, select_roi]
                            .melt(var_name=["ROI", "Targ"], value_name="Avg_SMC"))
        ## ons-sample t-test:
        if targ2 is None:
            tt_res[roi]["t_vals"], tt_res[roi]["p_vals"] = stats.ttest_1samp(
                smc_DF_roi.loc[smc_DF_roi["Targ"] == targ1, :]["Avg_SMC"], 
                popmean=0, alternative=alt)
            tt_res[roi]["Mean"] = smc_DF_roi.loc[smc_DF_roi["Targ"] == targ1, :]["Avg_SMC"].mean()
            tt_res[roi]["SEM"] = smc_DF_roi.loc[smc_DF_roi["Targ"] == targ1, :]["Avg_SMC"].sem()
                # SEM: standard error of the mean
        ## paired-sample t-test:
        else:
            tt_res[roi]["t_vals"], tt_res[roi]["p_vals"] = stats.ttest_rel(
                smc_DF_roi.loc[smc_DF_roi["Targ"] == targ1, :]["Avg_SMC"],
                smc_DF_roi.loc[smc_DF_roi["Targ"] == targ2, :]["Avg_SMC"],
                alternative=alt)
        
    return pd.DataFrame(tt_res).T

def plot_my_ttest(ttype, DF_sig, selected_rois, 
                  ax, pos_y, pos_ha, pos_va, txt_color):
    idx_list = [ selected_rois.index(roi) for roi in list(DF_sig.index) ]
    pval_list = list(DF_sig["p_vals"])
    for pos_x, p_val in zip(idx_list, pval_list):
        p_print = "p = {:.3f}".format(p_val)
        p_print = p_print.replace("0.", ".")
        ## ons-sample t-test:
        if ttype == "1samp":
            ax.text(s=p_print, x=pos_x, y=pos_y, 
                    color=txt_color, fontsize=18, style="italic", weight="bold",
                    rotation=45, va=pos_va, ha=pos_ha)
        ## paired-sample t-test:
        if ttype == "2samp":
            ax.hlines(y=pos_y, xmin=pos_x -.2, xmax=pos_x +.2, 
                      colors=txt_color, linewidth=5, alpha=.5)
            ax.text(s=p_print, x=pos_x, y=pos_y +.005, 
                    color=txt_color, fontsize=20, style="italic", weight="bold",
                    rotation=45, va=pos_va, ha=pos_ha)
    return ax

def plot_my_compares(long_DF, selected_rois, tar_a, tar_b, 
                     DF_1s_a_pSig, DF_1s_b_pSig, DF_1s_a_nSig, DF_1s_b_nSig, DF_pwtt_sig, 
                     fig_title, fp, fig_size=(20, 10), 
                     tar_a_color=tar_a_color, tar_b_color=tar_b_color,
                     legend_loc='lower left', ylim=None):
    
    fig, ax = plt.subplots(figsize=fig_size, dpi=200)
    sns.set_theme(style='white', font_scale=2)
    sns.barplot(
        data=long_DF, x="ROI", y="Avg_SMC", order=selected_rois,
        hue="Targ", hue_order=[tar_a, tar_b], 
        palette={tar_a: tar_a_color, tar_b: tar_b_color}, 
        errorbar="se" #, linewidth=1, color="k"
    )
    ax.set_xticklabels(selected_rois, rotation=90, fontsize=24)
    ax.axhline(0, color="r", linestyle=":", linewidth=2, alpha=.8)
    
    ypos_roi_means = long_DF.groupby(["ROI", "Targ"])["Avg_SMC"].mean()
    
    ## ons-sample, positive:
    for DF_sig, pos_ha, txt_color in [(DF_1s_a_pSig, "center", tar_a_color), 
                                      (DF_1s_b_pSig, "left", tar_b_color)]:
        if DF_sig is not None and len(DF_sig) > 0: 
            ax = plot_my_ttest("1samp", DF_sig, selected_rois, ax, 
                               pos_y=max(ypos_roi_means)+.005, 
                               pos_ha=pos_ha, pos_va="bottom", 
                               txt_color=txt_color)
    ## ons-sample, negitive:
    for DF_sig, pos_ha, txt_color in [(DF_1s_a_nSig, "right", tar_a_color), 
                                      (DF_1s_b_nSig, "left", tar_b_color)]:
        if DF_sig is not None and len(DF_sig) > 0: 
            ax = plot_my_ttest("1samp", DF_sig, selected_rois, ax, 
                               # pos_y=ypos_1stt * -1, 
                               pos_y=min(ypos_roi_means)-.005, 
                               pos_ha=pos_ha, pos_va="top", 
                               txt_color=txt_color)
    ## paired-sample:
    if len(DF_pwtt_sig) > 0: 
        ax = plot_my_ttest("2samp", DF_pwtt_sig, selected_rois, ax, 
                           # pos_y=ypos_pwtt
                           pos_y=max(ypos_roi_means)+.03,
                           pos_ha="center", pos_va="bottom", 
                           txt_color="#FF0000")
    if ylim is not None:
        ax.set_ylim(ylim)  
    ax.set_xlabel(None)
    ax.set_ylabel("similarity changes", size=24)
    ax.tick_params(axis="y", labelsize=20)
    ax.legend(loc=legend_loc) 
    sns.despine(left=True, bottom=True)
    plt.suptitle(fig_title)
    plt.tight_layout()
    plt.savefig(fp, format="png")
    plt.close()
    plt.clf()

def remove_outlier_indices(data, col="Avg_SMC"):
    if type(data) is pd.DataFrame:
        data = data[col]
    Q1 = data.quantile(0.25)
    Q3 = data.quantile(0.75)
    IQR = Q3 - Q1
    not_outliers = ~ ((data < (Q1 - 1.5 * IQR)) | (data > (Q3 + 1.5 * IQR)))
    return not_outliers
    
## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
rdm_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", "similarity_matrices")
mats_dir = os.path.join(rdm_top, stim_type, "ap-{:}".format(afni_desc), lss+estm, 
                        "PDist_{:}".format(meas), sub_folder)

out_dir = rdm_top.replace("similarity_matrices", 
                          f"similarity_changes{subj_include}")
out_csv_dir = os.path.join(out_dir, "Stats", "{:} vs. {:}".format(tar_a, tar_b))
out_fig_dir = os.path.join(out_dir, "Figs")
for dir in [out_csv_dir, out_fig_dir]:
    if not os.path.exists(dir):
        os.makedirs(dir)

## Main: ========================================================================================
print("\n## ====================================================================")
print("--> Data version:", afni_desc)
print("--> Parameter estimate:", lss+estm)
print("--> Compare between runs:", sub_folder)
print("--> (dis)similarity matrix measure:", meas)
print("--> Target:", tar_a)
print("--> Control:", tar_b)
print("--> Stimuli name by:", stim_type)

data_desc = mats_dir.replace(rdm_top, "")
data_desc = data_desc.replace("_", "-")
data_desc = "_".join(data_desc.split("/")[1:-1])
data_desc = "_".join(data_desc, args.fn_extend) if args.fn_extend != "" else data_desc

### Load full dataset: ---------------------------------------------------------------
smc_DF_file = os.path.join(mats_dir, "all_similarity_changes.csv")

if not os.path.exists(smc_DF_file) or args.update_df:
    smc_df_list = []

    for roi in m_name_list:
        similarity_change = { targ_name: {} for targ_name in targ_namelist }

        for file_path in glob.glob(os.path.join(mats_dir, '{:}_*.csv'.format(roi))):
            file_name = file_path.split("/")[-1]
            subj = re.findall(r'(sub-[\d]+).csv', file_name)[0]
            full_mat = np.loadtxt(file_path, delimiter=',')
            if meas == "correlation":
                full_mat = np.arctanh(full_mat) # do Fisher's z-transformation
            sub_mats = {
                'pre': full_mat[:12, :12],
                'post': full_mat[-12:, -12:]
            }
            for targ_mat, targ_name in zip(targ_matrices, targ_namelist):
                sm_diff = np.subtract(sub_mats['pre'],   # pre-exposure  "dis-similarity"
                                      sub_mats['post'])  # post-exposure "dis-similarity"
                                                         # --> post > pre "similarity"
                extract_vals = sm_diff * targ_mat
                avg = extract_vals.sum() / targ_mat.sum()
                similarity_change[targ_name][subj] = avg # "similarity" increase

        smc_df = pd.DataFrame(similarity_change)
        smc_df_list.append(smc_df)

    smc_DF = pd.concat(smc_df_list, axis = 1, keys=(m_name_list), names=["ROI", "Targ"])
    smc_DF.to_csv(smc_DF_file) # Save to file 
else:
    smc_DF = pd.read_csv(smc_DF_file, header=[0, 1], index_col=0)

### Filter with selected targets and do statistics: ----------------------------------
check_csv_file = os.path.join(out_csv_dir, "pwtt__{:}.csv".format(data_desc))
long_DF_file = os.path.join(out_csv_dir, "long_DF__{:}.csv".format(data_desc))

if not os.path.exists(check_csv_file) or not os.path.exists(long_DF_file) or args.re_stats:
    
    select_targ = smc_DF.columns.get_level_values("Targ").isin([tar_a, tar_b])
    
    # select_rois = smc_DF.columns.get_level_values("ROI").isin(m_name_list)
    # used_smc_DF = smc_DF.loc[:, (select_rois & select_targ)]

    if subj_include == "_rapid":
        select_subj = [ sid for sid in smc_DF.index if int(sid.replace("sub-", "")) < 100 ]
        used_smc_DF = smc_DF.loc[select_subj, select_targ]
    elif subj_include == "_slow":
        select_subj = [ sid for sid in smc_DF.index if int(sid.replace("sub-", "")) > 100 ]
        used_smc_DF = smc_DF.loc[select_subj, select_targ]
    else:
        used_smc_DF = smc_DF.loc[:, select_targ]

    # long_DF = pd.melt(used_smc_DF.reset_index(), id_vars="index", 
    #                   var_name=["ROI", "Targ"], value_name="Avg_SMC")   
    # long_DF["Group"] = [ "rapid" if int(sid.replace("sub-", "")) < 100 else "slow" for sid in long_DF["index"] ]
    # long_DF.to_csv(os.path.join(out_csv_dir, "long_DF.csv"), index=False)

    long_DF = used_smc_DF.melt(var_name=["ROI", "Targ"], value_name='Avg_SMC')
      
    # within_3sd = long_DF.groupby(["ROI", "Targ"]).apply(remove_outlier_indices).to_list()
    # long_DF = long_DF[within_3sd]

    # used_smc_DF = used_smc_DF[used_smc_DF.apply(remove_outlier_indices)]
    # long_DF = used_smc_DF.melt(var_name=["ROI", "Targ"], value_name='Avg_SMC').dropna()

    long_DF.to_csv(long_DF_file, index=False) # Save to file

    ### Do statistics: 
    DF_1s_a_pos = do_ttests(used_smc_DF, m_name_list, tar_a, alt="greater")
    DF_1s_b_pos = do_ttests(used_smc_DF, m_name_list, tar_b, alt="greater")
    DF_1s_a_neg = do_ttests(used_smc_DF, m_name_list, tar_a, alt="less")
    DF_1s_b_neg = do_ttests(used_smc_DF, m_name_list, tar_b, alt="less")
    DF_pwtt = do_ttests(used_smc_DF, m_name_list, tar_a, tar_b)

    for tt_out, tt_desc in zip([DF_1s_a_pos, DF_1s_b_pos, DF_1s_a_neg, DF_1s_b_neg, DF_pwtt], 
                               ["1s.pos_{:}".format(tar_a), 
                                "1s.pos_{:}".format(tar_b), 
                                "1s.neg_{:}".format(tar_a), 
                                "1s.neg_{:}".format(tar_b), 
                                "pwtt"]):
        tt_filename = "{:}__{:}.csv".format(tt_desc, data_desc)
        tt_out.to_csv(os.path.join(out_csv_dir, tt_filename)) # Save to file

        print("++ Saved:", tt_filename)
else:
    long_DF = pd.read_csv(long_DF_file, header=0)

    DF_1s_a_pos = pd.read_csv(os.path.join(out_csv_dir, "1s.pos_{:}__{:}.csv".format(tar_a, data_desc)), index_col=0)
    DF_1s_b_pos = pd.read_csv(os.path.join(out_csv_dir, "1s.pos_{:}__{:}.csv".format(tar_b, data_desc)), index_col=0)
    DF_1s_a_neg = pd.read_csv(os.path.join(out_csv_dir, "1s.neg_{:}__{:}.csv".format(tar_a, data_desc)), index_col=0)
    DF_1s_b_neg = pd.read_csv(os.path.join(out_csv_dir, "1s.neg_{:}__{:}.csv".format(tar_b, data_desc)), index_col=0)
    DF_pwtt = pd.read_csv(os.path.join(out_csv_dir, "pwtt__{:}.csv".format(data_desc)), index_col=0)

## Plot figures for (multiple sets of) selected ROIs: -------------------------------
for rois_desc in fig_roi_options:
    fig_name = "[{:}] {:} vs. {:} ({:}).png".format(rois_desc, tar_a, tar_b, data_desc)
    
    if not os.path.isfile(os.path.join(out_fig_dir, fig_name)) or args.re_plot:
        fig_roi_list, fig_size = roi_select_dict[rois_desc]

        plot_my_compares(long_DF.query("ROI in @fig_roi_list"), 
                         fig_roi_list, tar_a, tar_b, 
                         DF_1s_a_pSig = DF_1s_a_pos.query("p_vals <= .05 & index in @fig_roi_list"),  
                         DF_1s_b_pSig = DF_1s_b_pos.query("p_vals <= .05 & index in @fig_roi_list"),  
                         DF_1s_a_nSig = DF_1s_a_neg.query("p_vals <= .05 & index in @fig_roi_list"),  
                         DF_1s_b_nSig = DF_1s_b_neg.query("p_vals <= .05 & index in @fig_roi_list"),  
                         DF_pwtt_sig  = DF_pwtt.query("p_vals <= .05 & index in @fig_roi_list"),  
                         # ylim = [-.5, .5] if meas == 'correlation' else None,
                         fig_title = None,
                         # fig_title = data_desc.replace("_", "  "), 
                         fp = os.path.join(out_fig_dir, fig_name),  
                         fig_size=fig_size) 
        
        print("\n++ Finish:", fig_name)

print("\n## =============================== Done =============================== \n")
