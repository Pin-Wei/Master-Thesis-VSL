#!/bin/bash

bids_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$bids_dir/derivatives/fmriprep_fmap_RL
task=slowVSL
	
for subj in `cat subjList.txt`; do

	event_dir=$bids_dir/derivatives/event.v2
	cd $prep_dir/$subj/func/Timings
	
	for cond in A B C D ; do
		c_name=tpl_${cond}
		
		for run in `seq -f "%02g" 1 10`; do
			cat $event_dir/${subj}_task-${task}_run-${run}_events.v2.tsv | \
				awk -v c=$cond '{if (substr($3,1,1)==c) {print $1, $2, 1}}' > ${c_name}_run-${run}.txt
				
	## single run:		
			timing_tool.py -fsl_timing_files ${c_name}_run-${run}.txt -write_timing ${c_name}_run-${run}.1D
		done
		
	## only include exposure runs:
		timing_tool.py -fsl_timing_files \
			${c_name}_run-02.txt ${c_name}_run-03.txt ${c_name}_run-04.txt ${c_name}_run-05.txt \
			${c_name}_run-06.txt ${c_name}_run-07.txt ${c_name}_run-08.txt ${c_name}_run-09.txt \
			-write_timing ${c_name}_exposure-runs.1D		
	done

	## for each run:	
	for c_name in tpl_A tpl_B tpl_C tpl_D ; do
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 1 0 0 0 0 0 0 0 0 0 -write_timing ${c_name}_r1.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 2 0 0 0 0 0 0 0 0 -write_timing ${c_name}_r2.1D 
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 3 0 0 0 0 0 0 0 -write_timing ${c_name}_r3.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 4 0 0 0 0 0 0 -write_timing ${c_name}_r4.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 5 0 0 0 0 0 -write_timing ${c_name}_r5.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 6 0 0 0 0 -write_timing ${c_name}_r6.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 0 7 0 0 0 -write_timing ${c_name}_r7.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 0 0 8 0 0 -write_timing ${c_name}_r8.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 0 0 0 9 0 -write_timing ${c_name}_r9.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 0 0 0 0 10 -write_timing ${c_name}_r10.1D
		
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 2 3 0 0 0 0 0 0 0 -write_timing ${c_name}_R2-3.1D 
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 4 5 0 0 0 0 0 -write_timing ${c_name}_R4-5.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 6 7 0 0 0 -write_timing ${c_name}_R6-7.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 0 0 8 9 0 -write_timing ${c_name}_R8-9.1D
		
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 2 3 4 5 0 0 0 0 0 -write_timing ${c_name}_R2-5.1D
		timing_tool.py -fsl_timing_files ${c_name}*.txt -select_runs 0 0 0 0 0 6 7 8 9 0 -write_timing ${c_name}_R6-9.1D
		
		timing_tool.py -fsl_timing_files ${c_name}*.txt -write_timing ${c_name}.1D
	done
	
	for cond in A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ; do	
		## only include exposure runs
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-write_timing ${cond}_exposure-runs.1D
	done
done

