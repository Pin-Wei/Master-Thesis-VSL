#!/usr/bin/env python
# coding: utf-8

# bash
# mamba activate pymvpa
# python Run_pymvpa_RSA.py -a {0,1,2,3} [--lss] [-t] [--reml] [--runs {0,1}] [-s {0,1,2}] [--meas {0,1,2}] [--re_do]

import warnings
warnings.filterwarnings("ignore")

import os
import pickle
import numpy as np
import pandas as pd
import argparse

from mvpa2.suite import vstack
from mvpa2.mappers.zscore import zscore
from mvpa2.mappers.fx import mean_group_sample
from mvpa2.measures import rsa

from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import stype_dict, stype_choices, stype_default, stype_help_txt
from MVPA_constants import meas_list, meas_help_txt, meas_choices, meas_default
from MVPA_constants import pre_post_runs, expo_runs, all_runs
from roiList_MVPA import m_name_list
# m_name_list = ['High-Vis', 'MTL', 'Hipp-CA2+3', 'Hipp-DG+CA4', 'Hippocampus']

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
parser.add_argument("--re_do", action='store_true', default=False)
args = parser.parse_args()

## Setup variables: -----------------------------------------------------------------------------
# Data version: 
afni_desc = ap_version_list[args.ap_idx] 
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)

# Data includes:
data_include = ['union', 'no_missing'][0]
subj_include = ['all', 'rapid', 'slow'][0]
subj_list_all, g_sufx = {
    'all'  : (list(pd.read_csv(  'subjList.txt', header=None)[0]), ''), 
    'rapid': (list(pd.read_csv('subjList_1.txt', header=None)[0]), '_rapid'), 
    'slow' : (list(pd.read_csv('subjList_2.txt', header=None)[0]), '_slow')
}[subj_include]

# Which runs:
runs_include = ["r01_x_r10", "r02_to_r09"][args.runs] # "r01_x_r10_no-Z"
run_list = {
     "r01_x_r10" : pre_post_runs,
     "r02_to_r09": expo_runs
}[runs_include]

## Stimulus type:
stim_type, stim_list = list(stype_dict.items())[args.stimuli_type]

## Setup (dis)similarity matrix measure: --------------------------------------------------------
meas = meas_list[args.meas]
pdist = rsa.PDist(pairwise_metric=meas, # see scipy.spatial.distance.pdist for more metric options.
                  center_data=False,    # subtracting the column mean from each element.
                  square=True)          # if False, returns the flattened upper triangle.

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
data_top = os.path.join(top_dir, 'Combined_group', 'derivatives', 'PyMVPA', 
                        'masked_data', 'ap-{:}'.format(afni_desc))
out_mats = os.path.join(top_dir, 'Combined_group', 'derivatives', 'PyMVPA', 
                        'similarity_matrices', stim_type, 'ap-{:}'.format(afni_desc), lss+estm, 
                        'PDist_{:}'.format(meas))
out_dir = os.path.join(out_mats, runs_include)
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

## Main =========================================================================================
print "\n## ===================================================================="
print "--> Data version:", afni_desc
print "--> Parameter estimate:", lss+estm
print "--> (dis)similarity matrix measure:", meas
print "--> Stimuli name by:", stim_type
print ""

for m_name in m_name_list:
    if ( not args.re_do ) & ( os.path.isfile(os.path.join(out_dir, "{:}_{:}.csv".format(m_name, 'sub-02'))) ):
        print "** mask '{:}' has processed, skip!".format(m_name)
        pass

    else:
        ## Load data: -------------------------------------------------------------------------------
        # print ">>", m_name
        data_DS, info_DS, subj_list, subj_indices = {}, {}, {}, {}

        for run in run_list: 
            data_dir = os.path.join(data_top, 'run-{:}'.format(run), lss+estm)

            ## The masked 'fmri_datasets':
            data_fn = "{:}_masked_{:}{:}.pkl".format(data_include, m_name, g_sufx)
            with open(os.path.join(data_dir, data_fn), 'rb') as infile:
                data_DS[run] = pickle.load(infile)
            subj_list[run] = list(data_DS[run].keys()) 

            ## Participant's info DS:
            info_fn = 'DS_raw_paths_{:}{:}.pkl'.format(data_include, g_sufx)
            with open(os.path.join(data_dir, info_fn), 'rb') as infile:
                info_DS[run] = pickle.load(infile)
            subj_indices[run] = [ ds.sid for ds in info_DS[run] if ds.mask[m_name] != None ]

            ## Double-check the participant list
            if sorted(subj_list[run]) != sorted(subj_indices[run]):
                print "Subject list didn't match, exit script !!"
                exit()
            
        ## Pre-processing: --------------------------------------------------------------------------
        subj_list = subj_list[run] # since only union datasets are included
        DS_stacked = {}

        for subj in subj_list:

            ## Stack data: 
            DS_stacked[subj] = []
            for run in run_list:
                DS_stacked[subj].append(data_DS[run][subj])
            DS_stacked[subj] = vstack(DS_stacked[subj], a=0)
            
            ds = DS_stacked[subj]
            sidx = subj_indices[run].index(subj)
            info_ds = info_DS[run][sidx]

            ## Change the names of targets (if required):
            if stim_type == 'tpl_orig':
                old_targets = ds.sa.targets.copy()
                sorted_2_old_tpl = {}
                for tpl in info_ds.update_tpl.items():
                    for ord in range(1, 4):
                        sorted_2_old_tpl[tpl[1]+str(ord)] = tpl[0]+str(ord)
                ds.sa.targets = [ sorted_2_old_tpl[tar] for tar in old_targets ]

            elif stim_type == 'shape_png':
                old_targets = ds.sa.targets.copy()
                tpl_2_shape_dict = info_ds.sorted_tpl_2_shape
                ds.sa.targets = [ tpl_2_shape_dict[tar] for tar in old_targets ]

            ## Further pre-processing:
            zscore(ds, chunks_attr='chunks') # z-scoring within each run (per voxel, done in-place)
            mgs_ds = mean_group_sample(['targets', 'chunks'])(ds)

        ## Perform RSA: -----------------------------------------------------------------------------
            dsm = pdist(mgs_ds)
            dsm_name = "{:}_{:}.csv".format(m_name, subj)
            np.savetxt(os.path.join(out_dir, dsm_name), dsm, delimiter=',')

        print "# ROI: {:},\tN = {:}".format(m_name, len(subj_list))

    print "## =============================== Done =============================== \n"
    
