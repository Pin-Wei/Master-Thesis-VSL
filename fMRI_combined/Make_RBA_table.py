#!/usr/bin/env python
# coding: utf-8

# python Make_RBA_table.py $reml

import os
import sys
import copy
import numpy as np 
import pandas as pd

from roiList_RBA import roi_list, roi_titles

## Setup -----------------------------------------------------------------------------

reg_ver = "runs_MNI_3ord_v6" 
reml = ['', '_REML'][int(sys.argv[1])]

cond_list = ["Fst", "Snd", "Trd"]
glt_list = ["any.stim", "1.and.2", "2.and.3", "1.vs.2", "3.vs.2", "1.vs.3", "1.2.vs.3", "2.3.vs.1", "1.vs.2.3", "3.vs.1.2"]
# glt_list = ["1+2+3", "1+2", "2+3", "1-2", "3-2", "1-3"] # v5
exposure_runs = [ "{:02d}".format(x) for x in range(2, 10) ]

top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
data_dir = os.path.join(top_dir,  "derivatives", "ROIstats", f"{reg_ver}{reml}")
out_dir = os.path.join(top_dir,  "derivatives", "RBA", reg_ver, f"dataSet{reml}")
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

subj_DF = pd.read_csv(["subj_score_LN.tsv", 
                       "subj_score_Learn.tsv", 
                       "subj_age_score.txt"][0], sep="\t")
    # Note: Subj's score tables are made with "Plot_familiarity_test_score.R":
subj_DF_cols = ["Subj", "Design", "Score", "Group"] 

## Main: ==================================================================================================
DF_load, DF_out_small = {}, {}

for run in exposure_runs:
    DF_load[run], DF_out_small[run] = {}, {}
    
    for cond in cond_list+glt_list:
        DF_temp = {}
        
        for data_type in ['maskave', 'maskave_t-val']:
            DF_temp[data_type] = copy.deepcopy(subj_DF)

            for roi, roiname in zip(roi_list, roi_titles):
                data_fn = f"run-{run}_MNI_{roi}_{cond}_{data_type}.csv"
                print("Load data: {:}".format(data_fn))

                data = pd.read_csv(os.path.join(data_dir, data_fn), 
                                   header=None, names=["Subj", roiname])

                DF_temp[data_type] = (DF_temp[data_type].
                                      merge(data, how='left'))

            DF_temp[data_type] = (DF_temp[data_type].
                                  melt(id_vars=subj_DF_cols, 
                                       var_name="ROI", 
                                       value_name=cond))
            
        DF_load[run][cond] = DF_temp["maskave"]
        DF_load[run][cond][f"{cond}_tval"] = DF_temp["maskave_t-val"][cond]

        DF_out_small[run][cond] = (DF_load[run][cond].
                                   rename(columns={cond: "Y", f"{cond}_tval": "tval"}))
        
        DF_out_small[run][cond].dropna(axis=0, inplace=True)
        DF_out_small[run][cond].to_csv(os.path.join(out_dir, f"data_{cond}_run-{run}.txt"), sep="\t", index=False)
            # ("Subj", "Design", "Score", "Group"), "ROI", "Y", "tval"
        
        if cond in cond_list:
            DF_out_temp = copy.deepcopy(DF_out_small[run][cond])

            DF_out_temp.insert(len(subj_DF_cols), "Cond", cond)
            if (run == exposure_runs[0]) & (cond == cond_list[0]):
                DF_out_run = DF_out_temp
            else:
                DF_out_run = pd.concat([DF_out_run, DF_out_temp])

            DF_out_temp.insert(len(subj_DF_cols), "Run", run)            
            if (run == exposure_runs[0]) & (cond == cond_list[0]):
                DF_out = DF_out_temp
            else:
                DF_out = pd.concat([DF_out, DF_out_temp])

    DF_out_run.to_csv(os.path.join(out_dir, f"data_allCond_run-{run}.txt"), sep="\t", index=False)
        # ("Subj", "Design", "Score", "Group"), "Cond", "ROI", "Y", "tval"
        
DF_out.to_csv(os.path.join(out_dir, "data_allCond.txt"), sep="\t", index=False)
    # ("Subj", "Design", "Score", "Group"), "Run", "Cond", "ROI", "Y", "tval"

