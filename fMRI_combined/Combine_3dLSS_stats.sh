#!/bin/bash

# bash Combine_3dLSS_stats.sh

ss_ver='runs_v7.7'
echo -e "\n>> AFNI version: "$ss_ver

run_list=`seq -f "%02g" 1 10`
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

out_fn='LSS.all-stim_allBetas.nii'
attr_fn='LSS.all-stim_attrs.txt'
tpl_attr_fn='LSS.all-stim_Triplets_attrs.txt'

read -p ">> Which dataset, [a] rapid, [b] slow, or [c] both? " ver
case $ver in
	a ) todo_list=( vsl ) ;;
	b ) todo_list=( slowVSL ) ;;
	c ) todo_list=( vsl slowVSL ) ;;
esac

for gname in ${todo_list[*]}; do
	case $gname in
		vsl ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti' 
			subj_list=`cat subjList_1.txt`
			;;
		slowVSL ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti_slow' 
			subj_list=`cat subjList_2.txt`
			;;
	esac
	afni_dir=$top_dir/derivatives/afni_out/SS_results_${ss_ver}
	
	for subj in ${subj_list[*]} ; do
		for run in `seq -f "%02g" 1 10` ; do
		
			stats_dir=$afni_dir/${subj}_r${run}.results
			
			## Combine statistic files:
			for cond in ${cond_list[*]} ; do
				3dcopy -overwrite $stats_dir/LSS.stim-${cond}+orig \
					$stats_dir/LSS.stim-${cond}.nii
			done
			
			3dTcat -overwrite -prefix $stats_dir/$out_fn \
				$stats_dir/LSS.stim-A?.nii \
				$stats_dir/LSS.stim-B?.nii \
				$stats_dir/LSS.stim-C?.nii \
				$stats_dir/LSS.stim-D?.nii
				
			## Save attribute file of 12 shapes:
			echo `3dinfo -label -sb_delim "," $stats_dir/$out_fn` | \
				tr "," "\n"    | \
				cut -d "#" -f1 | \
				awk -v run=$run '{ printf "%s\t%02d\n", $1, run }' \
					> $stats_dir/$attr_fn
					
			## Save attribute file of 4 triplets: -
			attr_file=$stats_dir/$attr_fn
			echo `3dinfo -label -sb_delim "," $stats_dir/$out_fn` | \
				tr "," "\n"      | \
				cut -d "#" -f1   | \
				sed 's/[0-9]//g' | \
				awk -v run=$run '{ printf "%s\t%02d\n", $1, run }' \
					> $stats_dir/$tpl_attr_fn
		done
	done
done
