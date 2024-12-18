#!/usr/bin/env python
# coding: utf-8

# bash
# mamba activate pymvpa
# nohup python Run_pymvpa_Clf_ROIbased.py -a AP_IDX [--lss] [-t] [--reml] [--tpl] 
#                                         --clf {0,1,2,3} [-nf N_FOLD] [--mapper {0,1,2,3,4}] [--do_avg] [--re_do]

import os
import pickle
import numpy as np
import pandas as pd
import argparse

import warnings
warnings.filterwarnings("ignore")

# from mvpa2.base.hdf5 import h5load, h5save
from mvpa2.suite import *
from mvpa2.mappers.zscore import zscore
from mvpa2.mappers.fx import mean_group_sample
from mvpa2.generators.partition import NFoldPartitioner
# from MVPA_functions import rawDataSet_4_Py2 as rawDataSet
from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import tstat_help_txt, reml_help_txt
from MVPA_constants import tpl_help_txt, tpl_help_txt, do_avg_help_txt
from MVPA_constants import expo_runs, all_runs
from MVPA_constants import mapper_help_txt, mapper_key_list, mapper_choices, mapper_default
from MVPA_constants import clf_help_txt, clf_key_list, clf_choices
from roiList_MVPA import m_name_list

## Create argument parser objects: --------------------------------------------------------------
parser = argparse.ArgumentParser(description="")
parser.add_argument("-a", "--ap_idx", type=int, required=True, help=ap_idx_help_txt)
parser.add_argument("--lss", action='store_true')
parser.add_argument("-t", "--tstats", action='store_true', help=tstat_help_txt)
parser.add_argument("--reml", action='store_true', help=reml_help_txt)
parser.add_argument("--tpl", action="store_true", help=tpl_help_txt)
parser.add_argument("--mapper", type=int, choices=mapper_choices, default=mapper_default, help=mapper_help_txt)
parser.add_argument("--clf", type=int, choices=clf_choices, required=True, help=clf_help_txt)
parser.add_argument("-nf", "--n_fold", type=int, default=None, help=tpl_help_txt)
parser.add_argument("--do_avg", action="store_true", help=do_avg_help_txt)
parser.add_argument("--re_do", action="store_true", default=False)
args = parser.parse_args()

## Define functions: ----------------------------------------------------------------------------
def get_cv_results(DS, cv, foldN, do_avg):                       
    poly_detrend(DS, polyord=1, chunks_attr='chunks')
    zscore(DS, chunks_attr='chunks')
    if do_avg:
        run_averager = mean_group_sample(['targets', 'chunks'])
        DS = DS.get_mapped(run_averager)
    if foldN is not None:
        seed = np.random.randint(0, foldN)
        DS.sa.chunks = [ (x+seed)%foldN for x in range(len(DS)) ]
    cv_results = cv(DS)
    cv_outprint = cv.ca.stats.as_string(description=True) # conditional attribute
    # matrix = cv.ca.stats.matrix # confusion matrix

    return np.mean(cv_results), cv, cv_outprint

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

# Target type:
t_type = 'Tpls' if args.tpl else 'shapes' 

# Which runs:
run_list = [expo_runs, all_runs][0]
runs_name = ["exposure_runs", "all_10_runs"][0]
        
## Setup classifier & mapper: -------------------------------------------------------------------
# m_preform_list = ['High-Vis', 'MTL', 'Hipp-CA2+3', 'Hipp-DG+CA4', 'Hippocampus']
m_preform_list = m_name_list

map_name = mapper_key_list[args.mapper]
mapper = None
# mapper = {
#     ""          : None,
#     "SVD."      : SVDMapper(), 
#     "StatProj." : StaticProjectionMapper(), 
#     "StatFeat." : StaticFeatureSelection(),
#     "1WayAnova.": OneWayAnova()
# }[map_name]

clf_name = clf_key_list[args.clf]
raw_clf = {
    "LinearCSVMC": LinearCSVMC(),
    "RbfCSVMC"   : RbfCSVMC(), 
    "10NN"       : kNN(k=10, dfx=one_minus_correlation, voting="majority"),
    "SMLR"       : SMLR()
}[clf_name]

clf = MappedClassifier(raw_clf, mapper) if mapper is not None else raw_clf
CV = CrossValidation(clf, NFoldPartitioner(), 
                     errorfx=lambda p, t: np.mean(p == t), # to report accuracy 
                     enable_ca=["stats"])

do_avg = "_avg" if args.do_avg else ""

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
data_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", "masked_data", 
                        "ap-{:}".format(afni_desc))
out_top = os.path.join(top_dir, "Combined_group", "derivatives", "PyMVPA", "classification_out")
out_dir = os.path.join(out_top, "ap-{:}".format(afni_desc), lss+estm, 
                       "{:}_model-{:}".format(t_type, clf_name), runs_name)
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

## Main =========================================================================================
print "\n## ===================================================================="
print "--> Data version:", afni_desc
print "--> Parameter estimate:", lss+estm
print "--> Type of mapper:", mapper
print "--> Type of classifer:", clf_name
print "--> Type of targets:", t_type
print ""

acc_outfn = "ROIs_{:}-fold{:}.csv".format(args.n_fold, do_avg)
long_outfn = "long_ROIs_{:}-fold{:}.csv".format(args.n_fold, do_avg)
roisizes_fn = "ROI_sizes.csv"
long_rois_fn = "long_ROI_sizes.csv"

acc_outpath = os.path.join(out_dir, acc_outfn)
longDF_outpath = os.path.join(out_dir, long_outfn)
roisizes_outpath = os.path.join(out_top, roisizes_fn)
ACC_dict, ROI_sizes = {}, {}

if os.path.isfile(acc_outpath) and not args.re_do: # Output exist, and not going to re-do 
    print "** {:} has processed, skip!".format(acc_outfn)
    out_df = pd.read_csv(acc_outpath, index_col=0)
    pass

else: # Perform processing ==============================================================================
    if os.path.isfile(acc_outpath): # Output exist, but re-do
        ACC_dict = pd.read_csv(acc_outpath, index_col=0).to_dict()
        print ">> Loading pre-exist output:"
        print pd.DataFrame(ACC_dict).head()

    print  "\n>> Gonna perform to:\n", m_preform_list
    
    for m_name in m_preform_list:
        mid_file_path = os.path.join(out_dir, 
                                    "temp.{:}_{:}-fold{:}.csv".format(m_name, args.n_fold, do_avg))
        
        if not os.path.isfile(mid_file_path):
            print "++", m_name

            ## Load data: -------------------------------------------------------------------------------         
            data_DS, info_DS, subj_list = {}, {}, {}

            for run in run_list: 
                data_dir = os.path.join(data_top, 'run-{:}'.format(run), lss+estm)

                ## The masked 'fmri_datasets':
                data_fn = "{:}_masked_{:}{:}.pkl".format(data_include, m_name, g_sufx)
                with open(os.path.join(data_dir, data_fn), 'rb') as infile:
                    data_DS[run] = pickle.load(infile)

                ## Participant's info DS:
                info_fn = 'DS_raw_paths_{:}{:}.pkl'.format(data_include, g_sufx)
                with open(os.path.join(data_dir, info_fn), 'rb') as infile:
                    info_DS[run] = pickle.load(infile)
                
                info_DS[run] = [ ds for ds in info_DS[run] if ds.mask[m_name] != None ]
                subj_list[run] = [ ds.sid for ds in info_DS[run] ]

            ## Perform classification: ------------------------------------------------------------------          
            ACC_dict[m_name] = { subj: None for subj in subj_list_all }
            ROI_sizes[m_name] = { subj: None for subj in subj_list_all }
            
            for subj in subj_list_all:

                ## Stack all run in run_list:
                ds_list = [] 
                for run in run_list:
                    try:
                        ds = data_DS[run][subj] # NOTE: for old dataset, replace subj to subj_list[run].index(subj)
                        ds_list.append(ds)
                        ROI_sizes[m_name][subj] = ds.nfeatures
                    except:
                        pass

                ## Main:
                if ROI_sizes[m_name][subj] is not None:
                    ds_stacked = vstack(ds_list, a=0)
                    if args.tpl:
                        old_targs = ds_stacked.sa.targets
                        ds_stacked.sa.targets = [ tar[0] for tar in old_targs ]
                    try:
                        clf_acc, trained_cv, outprint = get_cv_results(ds_stacked, CV, args.n_fold, args.do_avg)
                        ACC_dict[m_name][subj] = clf_acc
                        print subj
                    except:
                        ACC_dict[m_name][subj] = None 
                        print subj, "failed"
            
            pd.DataFrame(ACC_dict[m_name], index=[m_name]).T.to_csv(mid_file_path)
            print "-- Saved --"

        else:
            ACC_dict[m_name] = pd.read_csv(mid_file_path, index_col=0).to_dict()[m_name]
            print ">> Load:", m_name

    ## Save to file: ====================================================================================
    out_df = pd.DataFrame(ACC_dict)
    out_df = out_df.reindex(columns=m_name_list, index=subj_list_all)
    out_df.to_csv(acc_outpath)
    print "-- FINISH -- Congratulations!!! "

## Melt and merge: --------------------------------------------------------------------------------------
# if not os.path.isfile(longDF_outpath):
out_df["SID"] = out_df.index
long_DF = out_df.melt(id_vars="SID", var_name="ROI", value_name="ACC")
long_DF.to_csv(longDF_outpath, index=False)

## ROI mask sizes: --------------------------------------------------------------------------------------
if not os.path.isfile(roisizes_outpath):
    roi_sizes = pd.DataFrame(ROI_sizes).reindex(columns=m_name_list)
    roi_sizes.to_csv(roisizes_outpath)
    print "++ Saved ROI sizes, saved at:\n\t", roisizes_outpath

    roi_sizes["SID"] = roi_sizes.index
    long_roisizes = roi_sizes.melt(id_vars="SID", var_name="ROI", value_name="Size")
    long_roisizes.to_csv(roisizes_outpath.replace(roisizes_fn, long_rois_fn), index=False)
    print "++ Saved ROI sizes in long format as well, name:", long_rois_fn
