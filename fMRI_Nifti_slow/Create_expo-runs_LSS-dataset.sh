#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

ss_ver=1115
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for subj in `cat subjList.txt`; do
	stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
	stim_dir=$stats_dir/stimuli
	
	for run in 2 3 4 5 6 7 8 9 ; do
		attr_file=$stats_dir/run-${run}-trials_attrs.txt
		if [ -f $attr_file ]; then rm $attr_file ; fi		
		attr_file_2=$stats_dir/run-${run}-Triplets_attrs.txt ###
		if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi
		
		nr=`expr ${run} - 1` # current row number
		
		for cond in ${cond_list[*]} ; do
			run_n=`awk -v nr=$nr 'NR==nr {print NF}' $stim_dir/offset_${cond}_exposure-runs.1D` # sum of column number
			for ((i=0; i<$run_n; i++)); do
				echo $cond $run >> $attr_file
			done
		done
		
		3dTcat -overwrite -prefix $stats_dir/LSS.run-${run}-trials_betas.nii \
			$stats_dir/LSS.stim-A?_run-${run}_Betas.nii \
			$stats_dir/LSS.stim-B?_run-${run}_Betas.nii \
			$stats_dir/LSS.stim-C?_run-${run}_Betas.nii \
			$stats_dir/LSS.stim-D?_run-${run}_Betas.nii 
	done
	
done

