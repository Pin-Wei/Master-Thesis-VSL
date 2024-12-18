#!/usr/bin/env python
# coding: utf-8

# conda activate pymvpa
# python Run_pymvpa_RSA_exposure.py

import warnings
warnings.filterwarnings("ignore")

import os
import pickle
import numpy as np
import pandas as pd
import argparse
from copy import deepcopy

from mvpa2.suite import vstack
from mvpa2.mappers.zscore import zscore
from mvpa2.mappers.fx import mean_group_sample
from mvpa2.measures import rsa

from MVPA_constants import ap_version_list, ap_default, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import stype_dict, stype_choices, stype_default, stype_help_txt
from MVPA_constants import meas_list, meas_help_txt, meas_choices, meas_default
from MVPA_constants import pre_post_runs, expo_runs, all_runs
from roiList_MVPA import m_name_list

def change_ds_targets(ds, info_ds, stim_type):
    old_targets = deepcopy(ds.sa.targets)

    if stim_type == "tpl_orig":
        sorted_2_old_tpl = {}
        for tpl in info_ds.update_tpl.items():
            for ord in range(1, 4):
                sorted_2_old_tpl[tpl[1]+str(ord)] = tpl[0]+str(ord)
        ds.sa.targets = [ sorted_2_old_tpl[tar] for tar in old_targets ]

    elif stim_type == "shape_png":
        tpl_2_shape_dict = info_ds.sorted_tpl_2_shape
        ds.sa.targets = [ tpl_2_shape_dict[tar] for tar in old_targets ]

    elif stim_type == "triplets":
        ds.sa.targets = [ tar[0] for tar in old_targets ]

    return ds

## Create argument parser objects: --------------------------------------------------------------
parser = argparse.ArgumentParser(description="")
parser.add_argument("-a", "--ap_idx", type=int, default=ap_default, help=ap_idx_help_txt)
parser.add_argument("--reml", action="store_true", help=reml_help_txt)
parser.add_argument("--lss", action="store_true")
parser.add_argument("-t", "--tstats", action="store_true", help=tstat_help_txt)
parser.add_argument("--meas", type=int, choices=meas_choices, default=meas_default, help=meas_help_txt)
parser.add_argument("-rg", "--run_groupby", type=int, default=1,
                    help="Compute for [0] Each or [1] Binded runs")
parser.add_argument("-sg", "--stim_groupby", type=int, default=1, 
                    help="Group stimuli by  "+
                         "[0] Their original labels (e.g., A1) "+
                         "[1] Labels that sorted by score (e.g., A-1; A is the triplet with highest score) "+
                         "[2] Only with triplet labels (e.g., A)")
parser.add_argument("--re_do", action="store_true", default=False)
args = parser.parse_args()

## Setup variables: -----------------------------------------------------------------------------
# Data version: 
afni_desc = ap_version_list[args.ap_idx]
reml = ["", "_REML"][args.reml]
lss = "LSS." if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else "" # automatically
lss = "LSS." if args.lss else lss # manually
estm = "Tstats{:}".format(reml) if args.tstats else "Betas{:}".format(reml)

# Data includes:
data_include = ["union", "no_missing"][0]
subj_include, g_sufx = "all", ""

run_list = ["{:02d}".format(x) for x in range(2, 10)]
run_groupby = ["each", "binded"][args.run_groupby]
r_columns = {
    "each"  : { "run-{:}".format(x): [x] for x in run_list }, 
    "binded": {
        "R23": ["02", "03"], 
        "R45": ["04", "05"], 
        "R67": ["06", "07"], 
        "R89": ["08", "09"]
    }
}[run_groupby]

## Stimulus type:
stim_type, stim_list = [
    ("tpl_orig", ["A1","A2","A3","B1","B2","B3","C1","C2","C3","D1","D2","D3"]),
    ("tpl_sorted", ["A-1","A-2","A-3","B-1","B-2","B-3","C-1","C-2","C-3","D-1","D-2","D-3"]),
    ("triplets", ["A", "B", "C", "D"])
    # ("shape_png", [ "{:02d}".format(x) for x in range(1, 13) ])
][args.stim_groupby]

if stim_type == "triplets":
    stim_avg_dict = { "Tpl": stim_list }
else:
    stim_avg_dict = {
        "Fst": [ stim_list[x*3] for x in range(4) ], 
        "Snd": [ stim_list[x*3+1] for x in range(4) ], 
        "Trd": [ stim_list[x*3+2] for x in range(4) ], 
        "All": stim_list
    } 

## Setup (dis)similarity matrix measure: --------------------------------------------------------
meas = meas_list[args.meas]
pdist = rsa.PDist(pairwise_metric=meas, # see scipy.spatial.distance.pdist for more metric options.
                  center_data=False,    # subtracting the column mean from each element.
                #   center_data=True,
                  square=True)          # if False, returns the flattened upper triangle.

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
data_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", 
                        "masked_data", "ap-{:}".format(afni_desc))
out_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", 
                       "odd_even_trials_similarity", "ap-{:}".format(afni_desc), meas)
raw_mat_out_dir = os.path.join(out_top, "raw_matrices", stim_type)
frame_out_dir = os.path.join(out_top, "dataframe_{:}".format(stim_type))

for out_dir in [raw_mat_out_dir, frame_out_dir]:
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

## Main =========================================================================================
# print m_name_list
        
longDF_fn = "allROI_allRlist_allCond_allSubj_{:}_{:}.csv".format(stim_type, run_groupby)
longDF_outpath = os.path.join(out_top, longDF_fn)
longDF_prepare = { m_name: {} for m_name in m_name_list }

for m_name in m_name_list:
    frame_out_sample = "{:}_{:}.csv".format(m_name, r_columns.keys()[-1])

    if ( not args.re_do ) & ( os.path.isfile(os.path.join(frame_out_dir, frame_out_sample)) ):
        print "** mask '{:}' has processed, skip!".format(m_name)

        for r_key in r_columns.keys():
            frame_out_fn = "{:}_{:}.csv".format(m_name, r_key)
            frame_out = pd.read_csv(os.path.join(frame_out_dir, frame_out_fn), index_col=0)
            longDF_prepare[m_name][r_key] = frame_out
        pass

    else:
        ## Load data: -------------------------------------------------------------------------------
        print ">>", m_name
        data_DS, info_DS, subj_list, subj_indices = {}, {}, {}, {}

        for run in run_list: 
            data_dir = os.path.join(data_top, "run-{:}".format(run), lss+estm)

            ## The masked "fmri_datasets":
            data_fn = "{:}_masked_{:}{:}.pkl".format(data_include, m_name, g_sufx)
            with open(os.path.join(data_dir, data_fn), "rb") as infile:
                data_DS[run] = pickle.load(infile)

            subj_list[run] = list(data_DS[run].keys()) 

            ## Participant's info DS:
            info_fn = "DS_raw_paths_{:}{:}.pkl".format(data_include, g_sufx)
            with open(os.path.join(data_dir, info_fn), "rb") as infile:
                info_DS[run] = pickle.load(infile)

            subj_indices[run] = [ ds.sid for ds in info_DS[run] if ds.mask[m_name] != None ]

            ## Double-check the participant list
            if sorted(subj_list[run]) != sorted(subj_indices[run]):
                print "Subject list didn't match, exit script !!"
                exit()

        ## Clean up subject list: -------------------------------------------------------------------
        subj_list_final = set(subj_list[run_list[0]])
        for run in run_list:
            subj_list_final = subj_list_final.intersection(set(subj_list[run]))
        subj_list_final = list(subj_list_final)

        ## Main of main: ----------------------------------------------------------------------------
        for r_key, r_list in r_columns.items():
            frame_out = { stim: {} for stim in stim_list }
            frame_out_fn = "{:}_{:}.csv".format(m_name, r_key)

            for subj in subj_list_final:   
                DS = []

                ## Pre-process dataframe: 
                for run in r_list:
                    ds = data_DS[run][subj]
                    info_ds = info_DS[run][subj_indices[run].index(subj)]
                    ds = change_ds_targets(ds, info_ds, stim_type)
                    zscore(ds, chunks_attr="chunks") # z-scoring within each run (per voxel, done in-place)
                    ds.sa.chunks = [ x%2 for x in range(len(ds)) ] # split into even and odd trials
                    DS.append(ds)
                DS = vstack(DS, a=0)

                ## Average per item for even and odd trials:
                DS_mgs = mean_group_sample(['targets', 'chunks'])(DS) 

                ## Compute pairwise distances (matrix):
                RDM = pdist(DS_mgs)

                ## Convert to similarity and average per condition:
                RSM = np.ones_like(RDM) - RDM

                ## SAVE the raw matrix (per ROI, subj, and rlist):
                out_fn = "{:}_{:}_{:}.csv".format(m_name, r_key, subj)
                np.savetxt(os.path.join(raw_mat_out_dir, out_fn), RSM, delimiter=',')

                ## Extract the similarity of the same item to itself
                #  in (averaged) odd and even trials:
                for x, stim in enumerate(stim_list):
                    frame_out[stim][subj] = RSM[x, len(stim_list)+x]

            ## SAVE: 
            frame_out = pd.DataFrame(frame_out)
            frame_out.to_csv(os.path.join(frame_out_dir, frame_out_fn))
            longDF_prepare[m_name][r_key] = frame_out

## Finally, store long: -----------------------------------------------------------------------------
longDF_outfile = []

for m_name in m_name_list:
    for r_key in r_columns.keys():
        sm_frame = longDF_prepare[m_name][r_key]

        sm_avg = {}
        for stim_avg_col, stim_avg_list in stim_avg_dict.items():
            sm_avg[stim_avg_col] = list(sm_frame[stim_avg_list].mean(axis=1))

        sm_avg_df = pd.DataFrame(sm_avg)
        sm_avg_df["Subj"] = sm_frame.index

        long_sm_avg_df = sm_avg_df.melt(id_vars="Subj", 
                                        var_name="Cond", 
                                        value_name="Similarity")
        long_sm_avg_df["Runs"] = r_key
        long_sm_avg_df["ROI"] = m_name

        longDF_outfile.append(long_sm_avg_df)

pd.concat(longDF_outfile).to_csv(longDF_outpath, index=False)




            
