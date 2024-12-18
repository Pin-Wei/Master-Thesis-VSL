#!/usr/bin/bash

# bash Extract_runs_estimates.sh

ss_ver='runs_v7'

echo -e "\n>> AFNI version: "$ss_ver
read -p ">> Individual Modulation (IM)? [y/n] " im

read -p ">> Which dataset, [a] rapid, [b] slow, or [c] both? " ver
case $ver in
	a ) todo_list=( vsl ) ;;
	b ) todo_list=( slowVSL ) ;;
	c ) todo_list=( vsl slowVSL ) ;;
esac

for gname in ${todo_list[*]}; do
	case $gname in
		vsl ) top_dir='/media/data2/pinwei/SL_hippocampus/Nifti' ;;
		slowVSL ) top_dir='/media/data2/pinwei/SL_hippocampus/Nifti_slow' ;;
	esac
	prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
	afni_dir=$top_dir/derivatives/afni_out/SS_results_${ss_ver}
	script_dir=$top_dir/code/HIDDEN_scripts
	
	case $im in
		y ) 
			bash HIDDEN_scripts/'get_estm_runs-IM.sh' $gname $afni_dir $script_dir
			;;
		n ) 
			bash HIDDEN_scripts/'get_estm_runs.sh' $gname $afni_dir
			;;
	esac
done