#!/usr/bin/env python
# Make (or update) self-defined 'INFO' dataset ("rawDataSet" objects), 
# which store subj's ID & file directories. 

# bash
# mamba activate pymvpa
# python Make_info_dataset.py -a AFNI_VER [--no_im] [--lss] [-t] [--reml]

import os
import argparse
import pandas as pd

import warnings
warnings.filterwarnings("ignore")

from MVPA_functions import rawDataSet_4_Py2 as rawDataSet
from MVPA_functions import subj_file_exist, get_the_mask, save_object
from MVPA_constants import ap_version_list, default_lss, ap_idx_help_txt
from MVPA_constants import no_im_help_txt, tstat_help_txt, reml_help_txt
from roiList_MVPA import space, roi_list, mask_types, m_name_list

parser = argparse.ArgumentParser(description="")
parser.add_argument("-a", "--ap_idx", type=int, required=True, help=ap_idx_help_txt)
parser.add_argument("--no_im", action='store_true', help=no_im_help_txt)
parser.add_argument("--lss", action='store_true')
parser.add_argument("-t", "--tstats", action='store_true', help=tstat_help_txt)
parser.add_argument("--reml", action='store_true', help=reml_help_txt)
args = parser.parse_args()

afni_desc = ap_version_list[args.ap_idx] 
afni_ver = 'runs' if args.ap_idx == 3 else afni_desc
reml = ['', '_REML'][args.reml]
lss = 'LSS.' if (not args.tstats) & (not args.reml) & (args.ap_idx in default_lss) else '' # automatically
lss = 'LSS.' if args.lss else lss # manually
estm = 'Tstats{:}'.format(reml) if args.tstats else 'Betas{:}'.format(reml)

run_stage = [['01', '10'], 
             ['{:02d}'.format(x) for x in range(2, 10)]]

## Setup paths: ---------------------------------------------------------------------------------
top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
behav_dir = os.path.join(top_dir, 'behavioral_data', 'familarity_test')
out_top = os.path.join(top_dir, 'Combined_group', 'derivatives', 'PyMVPA', 
                       'masked_data', 'ap-{:}'.format(afni_desc))

## Load familarity test results: ----------------------------------------------------------------
behav_data = pd.read_csv(os.path.join(behav_dir, 'familarity_test_score.csv'), index_col=0)
sorted_tpl = pd.read_csv(os.path.join(behav_dir, 'Triplets_sortby_score.csv'), index_col=0, header=None)
sorted_tpl_scores = pd.read_csv(os.path.join(behav_dir, 'Sorted-score_foreach_triplet.csv'), index_col=0, header=None)
tpl_2_shapes = pd.read_csv(os.path.join(behav_dir, 'Triplet_to_shapes.csv'), index_col=0)
stim_list = ['A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','D3']

## Main =========================================================================================
print "\n## ===================================================================="
print "## Data modeling version:", afni_desc
print '-->', lss+estm

for included, g_list_fn, g_sufx in [(['', '_slow'], 'subjList.txt',   ''), 
                                    ([''],          'subjList_1.txt', '_rapid'), 
                                    (['_slow'],     'subjList_2.txt', '_slow')]:
    
    print {''      : "\n--> Includes all datas...", 
           '_rapid': "\n--> Includes only 'rapid' datas...", 
           '_slow' : "\n--> Includes only 'slow' datas..."}[g_sufx]

    subjList_all = list(pd.read_csv(g_list_fn, header=None)[0])

    for run_list, run_type in zip(run_stage, ["Pre/Post", "Exposure"]):
        print "\n--> For {:} runs:".format(run_type)

        DS_union, n_union, remove_4_union = {}, {}, []

        for run in run_list:
            out_dir = os.path.join(out_top, 'run-{:}'.format(run), lss+estm)
            if not os.path.exists(out_dir): 
                os.makedirs(out_dir)

            n_subj, DS, missing_data = 0, [], {}

            for g_type in included:
                nif_dir = os.path.join(top_dir, 'Nifti{:}'.format(g_type))
                grp_dir = os.path.join(top_dir, 'Combined_group')
                prep_dir = os.path.join(nif_dir, 'derivatives', 'fmriprep_fmap_RL')
                afni_dir = os.path.join(nif_dir, 'derivatives', 'afni_out')

                ## Setup mask infos:
                mask_indexs, mask_dirs, mask_fns = [], [], []

                for roi, m_type, m_name in zip(roi_list, mask_types, m_name_list):
                    m_name, m_d_re, m_f_re = get_the_mask(space, m_type, roi, 'sub-*', prep_dir, afni_dir, grp_dir)
                    mask_indexs.append(m_name)
                    mask_dirs.append(m_d_re)
                    mask_fns.append(m_f_re)

                mask_indexs.append("whole_brain")
                mask_dirs.append(get_the_mask(space, "w", None, 'sub-*', prep_dir, afni_dir, grp_dir)[1])
                mask_fns.append(get_the_mask(space, "w", None, 'sub-*', prep_dir, afni_dir, grp_dir)[2])

                ## Get subjcet's ID lists from directories:
                dt_d_re = os.path.join(afni_dir, 'SS_results_{:}'.format(afni_ver), 'sub-*_r{:}.results'.format(run))
                if args.no_im:
                    data_fn = 'all{:}.nii'.format(estm) # no -IM option
                    attr_fn = 'Attrs.txt'
                else:
                    data_fn = '{:}all-stim_all{:}.nii'.format(lss, estm) # trial-wise estimated (with -IM option)
                    attr_fn = '{:}all-stim_attrs.txt'.format(lss)
                subjList = subj_file_exist(dt_d_re, data_fn)
                subjList = sorted(list(subjList), key=lambda x: x.replace('sub-', ''))

                for subj in subjList:
                    data_dir = dt_d_re.replace('sub-*', subj)
                    DS.append(rawDataSet(subj, data_dir, data_fn, attr_fn))
                    DS[n_subj].add_familarity_score(behav_data, sorted_tpl, sorted_tpl_scores)
                    DS[n_subj].to_orig_shapes(stim_list, tpl_2_shapes)

                    ## Load mask file paths:
                    for x, m_name in enumerate(mask_indexs):
                        mask_dir = os.path.join(mask_dirs[x].replace('sub-*', subj), 
                                                mask_fns[x].replace('sub-*', subj))
                        DS[n_subj].save_mask_paths(m_name, mask_dir) 

                    ## Save subjs who have missing data(s) into a dict: ({sid: [stim-A, B...]}):
                    if (lss == 'LSS.') & (args.ap_idx != 5):
                        for stim in stim_list:
                            stim_beta = os.path.join(data_dir, 'LSS.stim-{:}.nii'.format(stim))
                            if os.path.exists(stim_beta) is not True: 
                                try:
                                    missing_data[n_subj].append(stim)
                                except KeyError:
                                    missing_data[n_subj] = [stim]

                    n_subj += 1

            DS_union[run] = list(DS) # save a copy for dataset #3# 

    #1# DS_raw_paths(_slow).pkl 
            print ">> A total of {:} subject's data is loaded in run-{:}".format(n_subj, run)
            fn = 'DS_raw_paths{:}.pkl'.format(g_sufx) 
            save_object(DS, os.path.join(out_dir, fn))

            ## Store subjs whose trial-wise estimation is entirely failed into list:
            subjs_no_data = [ sid for sid in subjList_all if sid not in [ds.sid for ds in DS] ]
            if len(subjs_no_data) > 0 :
                print " ** Subjects don't have trial-wise estimations: {:}".format(subjs_no_data)
            for subj in subjs_no_data:
                remove_4_union.append(subj)
                
    #2# DS_raw_paths_no_missing(_slow).pkl 
            if (lss == 'LSS.') & (args.ap_idx != 5):
                remove_list = sorted(list(missing_data.keys()))[::-1] # only have missing data(s) for some stimuli
                if len(remove_list) > 0 :
                    for sidx in remove_list:
                        subj = DS[sidx].sid
                        print " [{0}]\t{1}\tdont't have LSS estimated beta for stim {2}".format(sidx, subj, missing_data[sidx])

                        remove_4_union.append(subj) #3#                      
                        del DS[sidx]
                        n_subj -= 1

                    print ">> Remain", n_subj, "subjects with no missing data\n"                    
                fn2 = 'DS_raw_paths_no_missing{:}.pkl'.format(g_sufx)
                save_object(DS, os.path.join(out_dir, fn2))

    #3# Save dataset: DS_raw_paths_union(_slow).pkl 
        remove_4_union = sorted(set(remove_4_union))
        for run in run_list:
            loaded_all = [ (x, ds.sid) for x, ds in enumerate(DS_union[run]) ]
            remove_list = [ x for x, sid in loaded_all if sid in remove_4_union ]
            for x in remove_list[::-1]:
                print " ** {:}\thave missing data throughout the stage, remove in run-{:}".format(DS_union[run][x].sid, run)
                del DS_union[run][x]

            out_dir = os.path.join(out_top, 'run-{:}'.format(run), lss+estm)
            fn3 = 'DS_raw_paths_union{:}.pkl'.format(g_sufx)
            save_object(DS_union[run], os.path.join(out_dir, fn3))

            n_union[run] = len(DS_union[run]) # see below
            print ">> 'run-{:}/{:}' is saved, N = {:}".format(run, fn3, n_union[run])

        ## Check if "union" data is REALLY union (across runs):          
        real_union = True
        for x, run in enumerate(run_list[:-1]):
            next_run = run_list[x+1]
            if n_union[run] != n_union[next_run]:
                print '\n!!! ERROR: "union" data goes wrong, BUT saved !!!'
                real_union = False          

print "## =============================== Done =============================== \n"