#!/usr/bin/env tcsh

# tcsh Execute_MVM.sh $mask_type

set ss_ver = 'runs_MNI_3ord_v6'
set reml = '_REML' # ''

set add_name = '_score2' # ''
set script_fn = ./HIDDEN_scripts/'do_MVM_3way'${add_name}'.sh'

set grp_out = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain
set etac_dir = $grp_out/ap.$ss_ver/ClustSim+ETAC
set out_dir = $grp_out/ap.$ss_ver/MVM

set data_table = $out_dir/'dataTable_3ord_Score'${reml}'.tsv'
# set data_table = $out_dir/'dataTable_3ord_LearnOrNot'${reml}'.tsv'
	# If not made --> python Make_MVM_table.py
	
switch ( $1 ) # mask_type
	case 0: 
		set desc = 'wholebrain_3way'${reml}
		set mask = $grp_out/group_mask+tlrc 
			# with wholebrain mask
		breaksw
	case 1:
		set desc = 'masked_3way'${reml}
		set mask = $etac_dir/Together/'collapseAll'${reml}'_1pos.05perc+tlrc'
			# If not made --> tcsh Make_ttest+ETAC_collapsed_mask.sh
		breaksw
	case 2:	
		set desc = 'masked.2sid_3way'${reml}
		set mask = $etac_dir/Together/'collapseAll'${reml}'_2sid.05perc+tlrc'
			# If not made --> tcsh Make_ttest+ETAC_collapsed_mask.sh
		breaksw
endsw

set desc = ${desc}${add_name}
	
## Main ----------------------------------------------------------------

tcsh $script_fn $ss_ver $mask $data_table $out_dir/$desc

echo `3dinfo -label -sb_delim "," $out_dir/${desc}+tlrc` | tr "," "\n" \
	> $out_dir/${desc}.subbrick_labels.1D

cp $script_fn $out_dir
if ( ! -f $out_dir/MNI152NLin2009cAsym_T1.nii ) cp $grp_out/MNI152NLin2009cAsym_T1.nii $out_dir

tcsh ./HIDDEN_scripts/do_ClustSim.sh $out_dir $desc 
	# generate corresponding cluster-size threshold tables
	
## To generate cluster report table --> tcsh ClustExp_MVM.sh
	
## Notes ===============================================================
# *** Three way:
#     - 2 levels for factor Group : Learn No 
#     - 8 levels for factor Run : r02 r03 r04 r05 r06 r07 r08 r09 
#     - 3 levels for factor Order : Fst Snd Trd 
# *** 888 response values: 37 subjects x 8 runs x 3 conditions
