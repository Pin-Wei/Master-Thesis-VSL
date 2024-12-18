#!/bin/bash

# Note: from events.v3, where jiggle targets are NOT excluded.

task=vsl
orig_dir=`pwd`
prep_dir=$3
event_dir=$prep_dir/../event.v3
cond_list=( first second third A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
	
for sid in `seq -f "%02g" $1 $2`; do

	subj=sub-$sid
	out_dir=$prep_dir/$subj/func/Timings_2
	if [ ! -d $out_dir ]; then mkdir $out_dir; fi
	cd $out_dir

	## extract stimuli onset times for each condition and save them into separate files for each run	
	for run in `seq -f "%02g" 1 10`; do
		event_file=$event_dir/${subj}_task-${task}_run-${run}_events.v3.tsv
	
		cat $event_file | awk '{if (substr($3,3,1)=="1") {print $1, $2, "1"}}' > first_run-${run}.txt
		cat $event_file | awk '{if (substr($3,3,1)=="2") {print $1, $2, "1"}}' > second_run-${run}.txt
		cat $event_file | awk '{if (substr($3,3,1)=="3") {print $1, $2, "1"}}' > third_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="A-1") {print $1, $2, "1"}}' > A1_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="A-2") {print $1, $2, "1"}}' > A2_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="A-3") {print $1, $2, "1"}}' > A3_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="B-1") {print $1, $2, "1"}}' > B1_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="B-2") {print $1, $2, "1"}}' > B2_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="B-3") {print $1, $2, "1"}}' > B3_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="C-1") {print $1, $2, "1"}}' > C1_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="C-2") {print $1, $2, "1"}}' > C2_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="C-3") {print $1, $2, "1"}}' > C3_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="D-1") {print $1, $2, "1"}}' > D1_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="D-2") {print $1, $2, "1"}}' > D2_run-${run}.txt
		cat $event_file | awk '{if (substr($3,1,3)=="D-3") {print $1, $2, "1"}}' > D3_run-${run}.txt
	done	
	
	## convert the FSL-formatted timing files into one ".1D" file per condition
	for cond in ${cond_list[*]}; do
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 1 0 0 0 0 0 0 0 0 0 -write_timing ${cond}_r1.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 2 0 0 0 0 0 0 0 0 -write_timing ${cond}_r2.1D 
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 3 0 0 0 0 0 0 0 -write_timing ${cond}_r3.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 4 0 0 0 0 0 0 -write_timing ${cond}_r4.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 5 0 0 0 0 0 -write_timing ${cond}_r5.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 6 0 0 0 0 -write_timing ${cond}_r6.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 0 7 0 0 0 -write_timing ${cond}_r7.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 0 0 8 0 0 -write_timing ${cond}_r8.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 0 0 0 9 0 -write_timing ${cond}_r9.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 0 0 0 0 10 -write_timing ${cond}_r10.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 2 3 0 0 0 0 0 0 0 -write_timing ${cond}_R2-3.1D 
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 4 5 0 0 0 0 0 -write_timing ${cond}_R4-5.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 6 7 0 0 0 -write_timing ${cond}_R6-7.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 0 0 8 9 0 -write_timing ${cond}_R8-9.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 2 3 4 5 0 0 0 0 0 -write_timing ${cond}_R2-5.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -select_runs 0 0 0 0 0 6 7 8 9 0 -write_timing ${cond}_R6-9.1D
		timing_tool.py -fsl_timing_files ${cond}*.txt -write_timing ${cond}.1D
	done
	
	for cond in ${cond_list[*]}; do	
	## only include one run
		for run in `seq -f "%02g" 1 10`; do
			timing_tool.py -fsl_timing_files ${cond}_run-${run}.txt -write_timing ${cond}_run-${run}.1D
		done
		
	## only include exposure runs
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-write_timing ${cond}_exposure-runs.1D
	done
	
	###
	for desc in 'targets' 'Hit' 'miss' 'FA' ; do
		for run in `seq -f "%02g" 1 10`; do
			cat $event_dir/${subj}_task-${task}_run-${run}_${desc}.tsv | awk 'NR>1 {print $1, $2, "1"}' > ${desc}_run-${run}.txt
			timing_tool.py -fsl_timing_files ${desc}_run-${run}.txt -write_timing ${desc}_run-${run}.1D
		done
	
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 1 0 0 0 0 0 0 0 0 0 -write_timing ${desc}_r1.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 2 0 0 0 0 0 0 0 0 -write_timing ${desc}_r2.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 3 0 0 0 0 0 0 0 -write_timing ${desc}_r3.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 4 0 0 0 0 0 0 -write_timing ${desc}_r4.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 5 0 0 0 0 0 -write_timing ${desc}_r5.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 0 6 0 0 0 0 -write_timing ${desc}_r6.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 0 0 7 0 0 0 -write_timing ${desc}_r7.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 0 0 0 8 0 0 -write_timing ${desc}_r8.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 0 0 0 0 9 0 -write_timing ${desc}_r9.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -select_runs 0 0 0 0 0 0 0 0 0 10 -write_timing ${desc}_r10.1D
		timing_tool.py -fsl_timing_files ${desc}_run-??.txt -write_timing ${desc}_all-runs.1D
	done
done

