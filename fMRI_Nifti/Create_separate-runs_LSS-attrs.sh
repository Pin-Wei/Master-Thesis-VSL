#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

# ss_ver=runs
# ss_ver=runs_v2
ss_ver=runs+behav

cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for subj in `cat subjList.txt`; do
	for run in `seq -f "%02g" 1 10` ; do
		stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}_r${run}.results
		stim_dir=$stats_dir/stimuli
		
		attr_file=$stats_dir/LSS.all-stim_attrs.txt
		if [ -f $attr_file ]; then rm $attr_file ; fi
		attr_file_2=$stats_dir/LSS.all-stim_Triplets_attrs.txt ###
		if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi
		
		for cond in ${cond_list[*]} ; do
			run_n=`awk 'NR==1 {print NF}' $stim_dir/offset_${cond}_run-${run}.1D`
			
			if [ -f $stats_dir/LSS.stim-${cond}+orig.HEAD ]; then 
				for ((i=0; i<$run_n; i++)); do
					echo $cond $run >> $attr_file
					
					Tpl_ID=`echo ${cond} | sed 's/[0-9]//g'`
					echo $Tpl_ID $run >> $attr_file_2
				done
			fi
		done
	done
done
