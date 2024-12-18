#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

ss_ver=runs
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for subj in `cat subjList.txt` ; do
	for run in `seq -f "%02g" 1 10` ; do
		stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}_r${run}.results
		stim_dir=$stats_dir/stimuli
		
		attr_file=$stats_dir/Attrs.txt
		if [ -f $attr_file ]; then rm $attr_file ; fi
		for cond in ${cond_list[*]} ; do
			echo $cond $run >> $attr_file
		done
		
		for reml in '' '_REML'; do
			3dTcat -overwrite \
				-prefix $stats_dir/allBetas${reml}.nii \
				$stats_dir/v+stats.${subj}${reml}+orig'[1-35(3)]'
				
			3dTcat -overwrite \
				-prefix $stats_dir/allTstats${reml}.nii \
				$stats_dir/v+stats.${subj}${reml}+orig'[2-35(3)]'
		done
	done
done
