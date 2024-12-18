#!/usr/bin/bash

# bash Make_timings_add.sh

logs_top='/media/data2/pinwei/SL_hippocampus/behavioral_data/logs'

timing_folder='Timings_v4.5'
event_ver='v4.5' 

event_folder='event.v4'

# is_cond='No' 
# desc_list=( 'All' \
		    # 'targets' 'Onset_OK' 'miss' 'Hit' 'FA' )

is_cond='Yes'
desc_list=( 'first' 'second' 'third' \
		    'A1' 'A2' 'A3' 'B1' 'B2' 'B3' 'C1' 'C2' 'C3' 'D1' 'D2' 'D3' )

read -p ">> Which dataset, [a] rapid, [b] slow, or [c] both? " ver
case $ver in
	a ) todo_list=( vsl ) ;;
	b ) todo_list=( slowVSL ) ;;
	c ) todo_list=( vsl slowVSL ) ;;
esac

for task in ${todo_list[*]}; do
	# cd '/media/data2/pinwei/SL_hippocampus/Combined_group/code'
	
	case $task in
		vsl ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti' 
			subj_list=`cat subjList_1.txt`
			subj_pfx='PW0'
			;;
		slowVSL ) 
			top_dir='/media/data2/pinwei/SL_hippocampus/Nifti_slow' 
			subj_list=`cat subjList_2.txt`
			subj_pfx='Slow'
			;;
	esac
	
	prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
	event_dir=$top_dir/derivatives/$event_folder
	
	for subj in ${subj_list[*]} ; do
		subj_folder=`echo $subj | sed "s/sub-/${subj_pfx}/g"`
		
		timing_dir=$prep_dir/$subj/func/$timing_folder
		if [ ! -d $timing_dir ]; then mkdir $timing_dir ; fi
		
		for desc in ${desc_list[*]} ; do
			
			## local ============================================================================
			
			## every single runs:
			for run in `seq -f "%02g" 1 10`; do 
			
				if [ $desc == 'All' ]; then
					event_tsv=${subj}_task-${task}_run-${run}_events.${event_ver}.tsv
					timing_file=all-stim_run-${run}.txt
				elif [ $is_cond == 'Yes' ]; then
				# elif [[ $desc == 'first' || $desc == 'second' || $desc == 'third' ]]; then				
					event_tsv=${subj}_task-${task}_run-${run}_events.${event_ver}.tsv
					timing_file=${desc}_run-${run}.txt
				else
					event_tsv=${subj}_task-${task}_run-${run}_${desc}.tsv
					timing_file=${desc}_run-${run}.txt				
				fi

				if [ ! -d $event_dir ]; then mkdir -p $event_dir ; fi
				if [ ! -f $event_dir/$event_tsv ]; then cp $logs_top/$subj_folder/$event_tsv $event_dir ; fi
						
				if [ ! -f $timing_dir/$timing_file ]; then
					if [ $is_cond == 'Yes' ]; then
						case $desc in
							'first' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,3,1)=="1") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'second' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,3,1)=="2") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'third' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,3,1)=="3") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'A1' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="A-1") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'A2' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="A-2") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'A3' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="A-3") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'B1' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="B-1") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'B2' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="B-2") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'B3' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="B-3") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'C1' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="C-1") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'C2' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="C-2") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'C3' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="C-3") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'D1' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="D-1") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'D2' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="D-2") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
							'D3' )
								cat $event_dir/$event_tsv | awk '{if (substr($3,1,3)=="D-3") {print $1, $2, "1"}}' > $timing_dir/$timing_file
								;;
						esac
					else
						cat $event_dir/$event_tsv | awk 'NR>1 {print $1, $2, "1"}' > $timing_dir/$timing_file
					fi
				fi
				
				out_file=$timing_dir/${desc}_run-${run}.1D ###
				
				if [ ! -f $out_file ]; then
					timing_tool.py -fsl_timing_files $timing_dir/$timing_file -write_timing $out_file
				fi
			done
			
			## binded exposure runs:
			for r1 in 2 4 6 8 ; do
				r2=`expr $r1 + 1`

				if [ $desc == 'All' ]; then
					timing_files=( `seq -f "$timing_dir/all-stim_run-%02g.txt" $r1 $r2` )
				else
					timing_files=( `seq -f "$timing_dir/${desc}_run-%02g.txt" $r1 $r2` )
				fi
				
				out_file=$timing_dir/${desc}_run-${r1}+${r2}.1D ###
				
				if [ ! -f $out_file ]; then
					timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` -write_timing $out_file
				fi
			done
			
			## global ===========================================================================
			
			if [ $desc == 'All' ]; then
				timing_files=( `seq -f "$timing_dir/all-stim_run-%02g.txt" 2 9` )
			else
				timing_files=( `seq -f "$timing_dir/${desc}_run-%02g.txt" 2 9` )
			fi
						
			## all exposure runs:
			out_file=$timing_dir/${desc}_expo-runs.1D ###
			
			if [ ! -f $out_file ]; then
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-write_timing $out_file
			fi
			
			## half-splited exposure runs:
			out_file_1=$timing_dir/${desc}_R2-5_ex.1D ###
			out_file_2=$timing_dir/${desc}_R6-9_ex.1D ###
			
			if [ ! -f $out_file_1 ]; then
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 1 2 3 4 0 0 0 0 -write_timing $out_file_1
				
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 0 0 0 0 5 6 7 8 -write_timing $out_file_2
			fi
			
			## pair-wise exposure runs:
			out_file_1=$timing_dir/${desc}_R2+3_ex.1D ###
			out_file_2=$timing_dir/${desc}_R4+5_ex.1D ###
			out_file_3=$timing_dir/${desc}_R6+7_ex.1D ###
			out_file_4=$timing_dir/${desc}_R8+9_ex.1D ###
			
			if [ ! -f $out_file_1 ]; then
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 1 2 0 0 0 0 0 0 -write_timing $out_file_1
				
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 0 0 3 4 0 0 0 0 -write_timing $out_file_2
					
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 0 0 0 0 5 6 0 0 -write_timing $out_file_3
				
				timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
					-select_runs 0 0 0 0 0 0 7 8 -write_timing $out_file_4
			fi
			
			## single exposure runs:
			for run in `seq 1 1 8` ; do
				
				select_list=()
				for count in `seq 1 1 8` ; do
					if [ $count == $run ]; then
						select_list=( ${select_list[*]} $run )
					else
						select_list=( ${select_list[*]} 0 )
					fi
				done
				
				run_id=`expr $run + 1`
				out_file=$timing_dir/${desc}_r${run_id}_ex.1D ###
				
				if [ ! -f $out_file ]; then
					timing_tool.py -fsl_timing_files `echo ${timing_files[*]}` \
						-select_runs `echo ${select_list[*]}` -write_timing $out_file
				fi
			done
			
			## ----------------------------------------------------------------------------------
		done
	done
done