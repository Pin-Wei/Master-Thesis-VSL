#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out
ss_ver=1115
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for subj in `cat subjList.txt`; do
	stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
	stim_dir=$stats_dir/stimuli
	
	for bind in 2 3 4 ; do
		# run_list=( 2 3 4 5 6 7 8 9 )
		run_list=( 3 4 5 6 7 8 9 )
		until [[ "${#run_list[@]}" -eq `expr $bind - 1` ]]; do 
			case $bind in 
				2 ) pfx=r${run_list[0]}${run_list[1]}
					runs=( ${run_list[0]} ${run_list[1]} ) ;;
				3 ) pfx=r${run_list[0]}${run_list[1]}${run_list[2]}
					runs=( ${run_list[0]} ${run_list[1]} ${run_list[2]} ) ;;
				4 ) pfx=r${run_list[0]}${run_list[1]}${run_list[2]}${run_list[3]}
					runs=( ${run_list[0]} ${run_list[1]} ${run_list[2]} ${run_list[3]} ) ;; 
			esac
		
			attr_file=$stats_dir/${pfx}-trials_attrs.txt
			if [ -f $attr_file ]; then rm $attr_file ; fi			
			attr_file_2=$stats_dir/${pfx}-Triplets_attrs.txt
			if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi	
			
			stim_files=()
			for cond in ${cond_list[*]} ; do
				for run in ${runs[*]} ; do
					nr=`expr ${run} - 1` # current row number
					run_n=`awk -v nr=$nr 'NR==nr {print NF}' $stim_dir/offset_${cond}_exposure-runs.1D` # sum of column number
					
					for ((i=0; i<$run_n; i++)); do
						Tpl_ID=`echo ${cond} | sed 's/[0-9]//g'`
						echo $cond $run >> $attr_file
						echo $Tpl_ID $run >> $attr_file_2
					done
					
					stim_files=( ${stim_files[*]} $stats_dir/LSS.stim-${cond}_run-${run}_Betas.nii )
				done
			done
			
			eval '3dTcat -overwrite -prefix '$stats_dir'/LSS.'${pfx}'-trials_betas.nii '${stim_files[*]}
				
			run_list=( ${run_list[@]:1} )
		done
	done
done
