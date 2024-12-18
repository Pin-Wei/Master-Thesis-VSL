#!/usr/bin/bash

orig_dir=`pwd`
cond_list=( first second third A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

read -p ">> Which dataset, [a] rapid, [b] slow, or [c] both? " ver
case $ver in
	a ) todo_list=( vsl ) ;;
	b ) todo_list=( slowVSL ) ;;
	c ) todo_list=( vsl slowVSL ) ;;
esac

for task in ${todo_list[*]}; do
	cd $orig_dir
	
	case $task in
		vsl ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti' 
			subj_list=`cat subjList_1.txt`
			;;
		slowVSL ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti_slow' 
			subj_list=`cat subjList_2.txt`
			;;
	esac
	prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
	event_dir=$top_dir/derivatives/event.AM
	
	for subj in ${subj_list[*]} ; do
	
		timing_dir=$prep_dir/$subj/func/Timings+AM
		if [ ! -d $timing_dir ]; then mkdir $timing_dir ; fi
		cd $timing_dir

		## extract stimuli onset times for each condition and save them into separate files for each run	
		for run in `seq -f "%02g" 1 10`; do
			event_file=$event_dir/${subj}_task-${task}_run-${run}_events.v2.tsv
		
			cat $event_file | awk '{if (substr($4,3,1)=="1") {print $1, $2, $3}}' > first_run-${run}.txt
			cat $event_file | awk '{if (substr($4,3,1)=="2") {print $1, $2, $3}}' > second_run-${run}.txt
			cat $event_file | awk '{if (substr($4,3,1)=="3") {print $1, $2, $3}}' > third_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="A-1") {print $1, $2, $3}}' > A1_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="A-2") {print $1, $2, $3}}' > A2_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="A-3") {print $1, $2, $3}}' > A3_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="B-1") {print $1, $2, $3}}' > B1_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="B-2") {print $1, $2, $3}}' > B2_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="B-3") {print $1, $2, $3}}' > B3_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="C-1") {print $1, $2, $3}}' > C1_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="C-2") {print $1, $2, $3}}' > C2_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="C-3") {print $1, $2, $3}}' > C3_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="D-1") {print $1, $2, $3}}' > D1_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="D-2") {print $1, $2, $3}}' > D2_run-${run}.txt
			cat $event_file | awk '{if (substr($4,1,3)=="D-3") {print $1, $2, $3}}' > D3_run-${run}.txt
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
		
		## all kinds of event
		for run in `seq -f "%02g" 1 10`; do
			cat $event_dir/${subj}_task-${task}_run-${run}_events.v2.tsv | awk 'NR>1 {print $1, $2, $3}' > all-stim_run-${run}.txt
			timing_tool.py -fsl_timing_files all-stim_run-${run}.txt -write_timing All_run-${run}.1D
		done	
	done
done

