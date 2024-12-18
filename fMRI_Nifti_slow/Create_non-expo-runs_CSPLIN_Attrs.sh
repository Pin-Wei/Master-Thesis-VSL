#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for run in '01' '10'; do
	case $run in
		01 ) pfx=pre ;;
		10 ) pfx=post ;;
	esac
	ss_ver=0205.$run.CSPLIN
	
	for subj in `cat subjList.txt`; do
	
		stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
		stim_dir=$stats_dir/stimuli
		
		attr_file=$stats_dir/all-stim_attrs.txt
		if [ -f $attr_file ]; then rm $attr_file ; fi
		attr_file_2=$stats_dir/all-stim_Triplets_attrs.txt ###
		if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi
				
		for cond in ${cond_list[*]} ; do
		
			run_n=`awk 'NR==1 {print NF}' $stim_dir/offset_${cond}_${pfx}_expo.1D`
			for ((i=0; i<$run_n; i++)); do
				for ((j=0; j<7; j++)); do # CSPLIN have 7 parameters
					echo $cond $run >> $attr_file
				done
			done
		done
	done
done

