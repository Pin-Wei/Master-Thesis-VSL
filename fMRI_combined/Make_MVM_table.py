#!/usr/bin/env python
# coding: utf-8

# python Make_MVM_table.py

import os
import numpy as np 
import pandas as pd
import copy

## Setup 1st-level stats version: ---------------------------------------------------
ss_ver = "runs_MNI_3ord_v6" 
reml = ["", "_REML"][1]

## Setup dirs: ----------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
out_dir = os.path.join(top_dir, "Combined_group", "derivatives", 
                       "WholeBrain", "ap.{:}".format(ss_ver), "MVM")
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

def get_file_path(subj, run, cond, ss_ver=ss_ver, reml=reml, top_dir=top_dir):
    sid = int(subj.replace("sub-", ""))
    nifti = "Nifti_slow" if sid > 100 else "Nifti"
    file_path = os.path.join(top_dir, nifti, "derivatives", "afni_out", 
                             "SS_results_{:}".format(ss_ver), 
                             "{:}_r{:}.results".format(subj, run), 
                             "stats.{:}{:}+tlrc[{:}#0_Coef]".format(subj, reml, cond))
    return file_path

## Setup conditions (3ord or other GLTs): -------------------------------------------
out_pfx, cond_list = [
    ("_3ord", ["Fst", "Snd", "Trd"]) # , 
    # ("_", ["Predicting_GLT", "Predicted_GLT"])
][0]

## Setup subject (all or learner-only): ---------------------------------------------
out_sufx, subj_select, col_sel = [
    ("_Learner", "Learn", 0), 
    ("_LearnOrNot", "LN", 1), 
    ("_Score", "LN", 2)
][2]

subj_DF = pd.read_csv(f"subj_score_{subj_select}.tsv", sep="\t") 
colname_subj , colname_run, colname_ord, colname_fdir = "Subj", "Run", "Order", "InputFile"
col_select = [
    [colname_subj, colname_run, colname_ord, colname_fdir], 
    [colname_subj, "Group", colname_run, colname_ord, colname_fdir], 
    [colname_subj, "Score", colname_run, colname_ord, colname_fdir]
][col_sel]

## Setup included runs (fixed): -----------------------------------------------------
exposure_runs = [ "{:02d}".format(x) for x in range(2, 10) ]
output_per_run = False

## ==================================================================================
out_desc = f"{out_pfx}{out_sufx}{reml}" 

for run in exposure_runs:
    for cond in cond_list:
        if reml == "_REML":
            cond = cond.replace("_GLT", "")

        mvm_df = copy.deepcopy(subj_DF)
        mvm_df[colname_run] = "r{:}".format(run)
        mvm_df[colname_ord] = cond.replace("_GLT", "")
        mvm_df[colname_fdir] = mvm_df[colname_subj].apply(lambda x: get_file_path(x, run, cond))

        if (run == exposure_runs[0]) & (cond == cond_list[0]):
            big_dataTable = mvm_df
        else:
            big_dataTable = pd.concat([big_dataTable, mvm_df])

        if (cond == cond_list[0]):
            run_dataTable = mvm_df
        else:
            run_dataTable = pd.concat([run_dataTable, mvm_df])
    ###
    if output_per_run:
        run_dataTable = run_dataTable.loc[:, col_select]
        run_dataTable.to_csv(os.path.join(out_dir, "dataTable{:}_r{:}.tsv".format(out_desc, run)), sep="\t", index=False)

big_dataTable = big_dataTable.loc[:, col_select]
big_dataTable.to_csv(os.path.join(out_dir, "dataTable{:}.tsv".format(out_desc)), sep="\t", index=False)
