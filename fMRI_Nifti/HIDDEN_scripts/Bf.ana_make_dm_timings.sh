#!/bin/bash

bids_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$bids_dir/derivatives/fmriprep_fmap_RL
task=vsl
	
for subj in `cat subjList.txt`; do

	event_dir=$bids_dir/$subj/func
	cd $prep_dir/$subj/func/Timings
#	rm dm_*
	
	for run in `seq -f "%02g" 1 10`; do
		for cond in first second third ; do
			case ${cond} in
				first ) class=1 ;;
				second ) class=2 ;;
				third ) class=3 ;;
			esac
			cat $event_dir/${subj}_task-${task}_run-${run}_events.tsv | \
				awk -v c=$class '{if (substr($3,3,1)==c) {print $1, $2, 1}}' > dm_${cond}_run-${run}.txt
		done
		
		for cond in A-1 A-2 A-3 B-1 B-2 B-3 C-1 C-2 C-3 D-1 D-2 D-3 ; do
			stim=`echo $cond | sed "s|-||g"`
			cat $event_dir/${subj}_task-${task}_run-${run}_events.tsv | \
				awk -v c=$cond '{if (substr($3,1,3)==c) {print $1, $2, 1}}' > dm_${stim}_run-${run}.txt
		done
		
		cat $event_dir/${subj}_task-${task}_run-${run}_events.tsv | awk 'NR>1 {print $1, $2, 1}' > dm_all-stim_run-${run}.txt
		timing_tool.py 					\
			-fsl_timing_files dm_all-stim_run-${run}.txt	\
			-write_timing dm_All_run-${run}.1D
	done
		
	for cond in first second third A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ; do
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 1 0 0 0 0 0 0 0 0 0 -write_timing dm_${cond}_r1.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 2 0 0 0 0 0 0 0 0 -write_timing dm_${cond}_r2.1D 
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 3 0 0 0 0 0 0 0 -write_timing dm_${cond}_r3.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 4 0 0 0 0 0 0 -write_timing dm_${cond}_r4.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 5 0 0 0 0 0 -write_timing dm_${cond}_r5.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 6 0 0 0 0 -write_timing dm_${cond}_r6.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 0 7 0 0 0 -write_timing dm_${cond}_r7.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 0 0 8 0 0 -write_timing dm_${cond}_r8.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 0 0 0 9 0 -write_timing dm_${cond}_r9.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 0 0 0 0 10 -write_timing dm_${cond}_r10.1D
		
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 2 3 0 0 0 0 0 0 0 -write_timing dm_${cond}_R2-3.1D 
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 4 5 0 0 0 0 0 -write_timing dm_${cond}_R4-5.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 6 7 0 0 0 -write_timing dm_${cond}_R6-7.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 0 0 8 9 0 -write_timing dm_${cond}_R8-9.1D
		
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 2 3 4 5 0 0 0 0 0 -write_timing dm_${cond}_R2-5.1D
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -select_runs 0 0 0 0 0 6 7 8 9 0 -write_timing dm_${cond}_R6-9.1D
		
		timing_tool.py -fsl_timing_files dm_${cond}*.txt -write_timing dm_${cond}.1D
	done
	
	for cond in first second third; do	
		## only include one run
		for run in `seq -f "%02g" 1 10`; do
			timing_tool.py -fsl_timing_files dm_${cond}_run-${run}.txt -write_timing dm_${cond}_run-${run}.1D
		done
		
		## only include exposure runs
		timing_tool.py -fsl_timing_files \
			dm_${cond}_run-02.txt dm_${cond}_run-03.txt dm_${cond}_run-04.txt dm_${cond}_run-05.txt \
			dm_${cond}_run-06.txt dm_${cond}_run-07.txt dm_${cond}_run-08.txt dm_${cond}_run-09.txt \
			-write_timing dm_${cond}_exposure-runs.1D
	done

	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 1 0 0 0 0 0 0 0 0 0 -write_timing dm_All_r1.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 2 0 0 0 0 0 0 0 0 -write_timing dm_All_r2.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 3 0 0 0 0 0 0 0 -write_timing dm_All_r3.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 4 0 0 0 0 0 0 -write_timing dm_All_r4.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 5 0 0 0 0 0 -write_timing dm_All_r5.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 0 6 0 0 0 0 -write_timing dm_All_r6.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 0 0 7 0 0 0 -write_timing dm_All_r7.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 0 0 0 8 0 0 -write_timing dm_All_r8.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 0 0 0 0 9 0 -write_timing dm_All_r9.1D
	# timing_tool.py -fsl_timing_files dm_all-stim_run-??.txt -select_runs 0 0 0 0 0 0 0 0 0 10 -write_timing dm_All_r10.1D
done

