#!/usr/bin/env python
# coding: utf-8

# python Make_RBA_table.py $reml

import os
import sys
import numpy as np 
import pandas as pd

from roiList_RBA import roi_list, roi_titles

## 1st-level analysis version:
reg_ver = "runs_MNI_3ord_v5" 
reml = ['', '_REML'][int(sys.argv[1])]

cond_list = ["Fst", "Snd", "Trd", "1+2+3", 
             "1+2", "2+3", "1-2", "3-2", "1-3"] 
# "runs_MNI_3ord_v4" ["Fst", "Snd", "Trd", "1+2", "2+3", "1-2", "2-3", "1-3", "1+2+3"], 
# "runs_MNI_3ord_v3": ["Fst", "Snd", "Trd", "1+2-3", "2+3-1", "1+2+3"]
# "runs_MNI_all-only": ["all"]

## setup paths:
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
data_dir = os.path.join(top_dir,  "derivatives", "ROIstats", f"{reg_ver}{reml}")

# out_desc = reg_ver + "_LearnOrNot"
out_dir = os.path.join(top_dir,  "derivatives", "RBA", reg_ver, f"dataSet{reml}")
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

## Specify subj dataframe:
df_ref = ["subj_score_LN.tsv", "subj_score_Learn.tsv", "subj_age_score.txt"][0]
    # Note: Tables are made with "Plot_familiarity_test_score.R"

subj_DF = pd.read_csv(df_ref, sep="\t")
subj_DF_cols = ["Subj", "Design", "Score", "Group"] # ["Subj", "Age", "Design", "Score", "Guess"]

## Main: ==================================================================================================
DF_all, DF_all_unlabel = {}, {}
exposure_runs = [ "{:02d}".format(x) for x in range(2, 10) ]

for run in exposure_runs:
    DF_all[run], DF_all_unlabel[run] = {}, {}
    fn_per_run = f"data_run-{run}.txt"

    for cond in cond_list:
        DF_per_cond = {}
        fn_per_cond_run = f"data_{cond}_run-{run}.txt"
        
        for data_type in ['maskave', 'maskave_t-val']:
        # for data_type in ['maskave', 'maskave_t-val', 'sigma']:
            DF_per_cond[data_type] = subj_DF.copy()

            for roi, roiname in zip(roi_list, roi_titles):
                data_fn = f"run-{run}_MNI_{roi}_{cond}_{data_type}.csv"
                data = pd.read_csv(os.path.join(data_dir, data_fn), header=None, names=["Subj", roiname])
                print("Loaded data: {:}".format(data_fn))
                DF_per_cond[data_type] = DF_per_cond[data_type].merge(data, how='left')

            DF_per_cond[data_type] = DF_per_cond[data_type].melt(id_vars=subj_DF_cols, 
                                                                 var_name="ROI", 
                                                                 value_name=cond)
        DF_all[run][cond] = DF_per_cond['maskave']
        DF_all[run][cond][f"{cond}_tval"] = DF_per_cond['maskave_t-val'][cond]
        # DF_all[run][cond][f"{cond}_SE"] = DF_per_cond['sigma'][cond] / np.sqrt(len(subj_DF))

        ## per condition & per run: ----------------------------------------------------------------------
        DF_all_unlabel[run][cond] = DF_all[run][cond].rename(columns={cond: 'Y', 
                                                                      f"{cond}_tval": "tval", 
                                                                      f"{cond}_SE": "SE"})
        DF_all_unlabel[run][cond].dropna(axis=0, inplace=True)
        DF_all_unlabel[run][cond].to_csv(os.path.join(out_dir, fn_per_cond_run), sep="\t", index=False)

        ## per run: ---------------------------------------------------------------------------------------
        if cond == cond_list[0]:
            run_out_DF = DF_all[run][cond]
        else:
            run_out_DF = run_out_DF.merge(DF_all[run][cond], how='left')

    run_out_DF.dropna(axis=0, inplace=True)
    run_out_DF.to_csv(os.path.join(out_dir, fn_per_run), sep="\t", index=False)

## per condition: -----------------------------------------------------------------------------------------
for cond in cond_list:
    fn_per_cond = f"data_{cond}.txt"

    for run in exposure_runs:
        DF_temp = DF_all_unlabel[run][cond]
        DF_temp["Run"] = run

        if run == exposure_runs[0]:
            cond_out_DF = DF_temp
        else:
            cond_out_DF = pd.concat([cond_out_DF, DF_temp], ignore_index=True, sort=False)
            
    cond_out_DF.dropna(axis=0, inplace=True)
    cond_out_DF.to_csv(os.path.join(out_dir, fn_per_cond), sep="\t", index=False)