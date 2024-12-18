#!/usr/bin/env python
# coding: utf-8

# bash
# mamba activate pymvpa
# nohup -x python Make_fmri_dataset.py -a AFNI_VER [--no_im] [--lss] [-t] [--reml]

import os
import pickle
import argparse
# import pandas as pd

import warnings
warnings.filterwarnings("ignore")

from mvpa2.suite import *
# from mvpa2.base.dataset import save
from MVPA_functions import save_object
from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import no_im_help_txt, tstat_help_txt, reml_help_txt
from roiList_MVPA import roi_list_uni, roi_list_LR, m_name_list

parser = argparse.ArgumentParser(description="")
parser.add_argument("-a", "--ap_idx", type=int, required=True, help=ap_idx_help_txt)
parser.add_argument("--no_im", action='store_true', help=no_im_help_txt)
parser.add_argument("--lss", action='store_true')
parser.add_argument("-t", "--tstats", action='store_true', help=tstat_help_txt)
parser.add_argument("--reml", action='store_true', help=reml_help_txt)
parser.add_argument("--re_do", action='store_true', default=False)
args = parser.parse_args()

afni_desc = ap_version_list[args.ap_idx] 
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)
data_include = ['union', 'no_missing'][0]

m_name_list.append("whole_brain")
# m_name_list = ['High-Vis', 'MTL', 'Hipp-CA2+3', 'Hipp-DG+CA4', 'Hippocampus']

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
out_top = os.path.join(top_dir, 'Combined_group', 'derivatives', 'PyMVPA', 
                       'masked_data', 'ap-{:}'.format(afni_desc))

## Main =========================================================================================
print "\n## ===================================================================="
print "### Data modeling version:", afni_desc
print '-->', lss+estm

for m_name in m_name_list:
    print ">> {:}".format(m_name)

    for g_sufx in ['', '_rapid', '_slow']:
        for run in [ '{:02d}'.format(x) for x in range(1, 11) ]: # all 10 runs

            out_dir = os.path.join(out_top, 'run-{:}'.format(run), lss+estm)
            out_fn = "union_masked_{:}{:}.pkl".format(m_name, g_sufx)

            if os.path.isfile(os.path.join(out_dir, out_fn)) and not args.re_do:
                # print "** 'run-{:}/{:}' has processed, skip!".format(run, out_fn)
                pass

            else:
                info_fn = 'DS_raw_paths_{:}{:}.pkl'.format(data_include, g_sufx)
                with open(os.path.join(out_dir, info_fn), 'rb') as infile:
                    info_DS = pickle.load(infile)

                masked_fmri_dataset = {}
                n_subj = 0
                for ds in info_DS:
                    if ds.mask[m_name] is not None:
                        subj = ds.sid
                        old_targ_list = ds.data_attr['targets']
                        new_targ_list = [ tar.replace(tar[0], ds.update_tpl[tar[0]]) for tar in old_targ_list ]
                        # tpl_attr = SampleAttributes(os.path.join(ds.data_dir, 
                        #                                          '{:}all-stim_Triplets_attrs.txt'.format(lss)))
                        fmri_DS = fmri_dataset(samples = ds.data_path, 
                                               targets = new_targ_list, 
                                               chunks = ds.data_attr['chunks'], 
                                               mask = ds.mask[m_name])
                        masked_fmri_dataset[subj] = fmri_DS
                        n_subj += 1
                
                save_object(masked_fmri_dataset, os.path.join(out_dir, out_fn))
                print ">> run-{:}/{:} saved,\tN = {:}".format(run, out_fn, n_subj)

                # n_subj = len(info_DS)
                # print ">> {:}: N = {:}\t(file = run-{:}/{:})".format(m_name, n_subj, run, info_fn)

                # for n in range(n_subj):
                #     if info_DS[n].mask[m_name] is not None:
                #         old_targ_list = info_DS[n].data_attr['targets']
                #         new_targ_list = [ tar.replace(tar[0], info_DS[n].update_tpl[tar[0]]) for tar in old_targ_list ]
                #         # tpl_attr = SampleAttributes(os.path.join(info_DS[n].data_dir, 
                #         #                                          '{:}all-stim_Triplets_attrs.txt'.format(lss)))
                #         fmri_DS = fmri_dataset(samples = info_DS[n].data_path, 
                #                                targets = new_targ_list, 
                #                                chunks = info_DS[n].data_attr['chunks'], 
                #                                mask = info_DS[n].mask[m_name])
                #         masked_fmri_dataset.append(fmri_DS)
                        
                # save_object(masked_fmri_dataset, os.path.join(out_dir, out_fn))

print "## =============================== Done =============================== \n"
