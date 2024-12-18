#!/bin/bash

taskname=slowVSL

orig_dir=`pwd`
cd $3

# confound_list=( trans_x trans_y trans_z rot_x rot_y rot_z )
# confounds_name=head-motion
# confound_list=( csf white_matter global_signal )
# confounds_name=G-signals
confound_list=( csf white_matter )
confounds_name=csf+wm

### Output files:
# runVolumes.txt --> volume of each run, one number per line
# ${c_name}_R${run}.txt --> one regessor, one run
# ${c_name}_run-${run}.txt --> one regessor, one run, with zero padding
# ${c_name}_R-all.1D --> one regessor, all runs
# ${confounds_name}_run-${run}.1D --> all regessors, one run
# ${confounds_name}_exposure-runs.1D --> all regessors, exposure runs
# ${confounds_name}_confound.1D --> all regessors, all runs
if [ -f global-signals_confound.1D ]; then rm global-signals_confound.1D; fi
if [ -f global-signals_exposure-runs.1D ]; then rm global-signals_exposure-runs.1D; fi
if [ -f global-signals_run-??.1D ]; then rm global-signals_run-??.1D; fi

for sid in `seq -f "%02g" $1 $2`; do

	subj=sub-$sid
	cd ${subj}/func/Confounds	
	
	## Extract the target confound regessors and condense them into one ".1D" file:
	if [ -f ${confounds_name}_confound.1D ]; then rm ${confounds_name}_confound.1D; fi
	
	for conf in ${confound_list[*]}; do
		c_name=${conf/_/-} # replace '_' to '-'		
		if [ -f ${c_name}_R-all.1D ]; then rm ${c_name}_R-all.1D; fi

		for run in `seq -f "%02g" 1 10`; do
		
			# print the column whose header (first row) equal to $conf:
			awk -v col=$conf 'NR==1 {for (i=1; i<=NF; i++) {if ($i==col) {c=i;break}} print $c} NR>1 {print $c}' \
				${subj}_task-${taskname}_run-${run}_desc-confounds_timeseries.tsv > ${c_name}_run-${run}_tmp.txt;
			sed '1d' ${c_name}_run-${run}_tmp.txt > ${c_name}_R${run}.txt; # remove the first line
			
			# row-bind runs, one file per confound:
			cat ${c_name}_R${run}.txt >> ${c_name}_R-all.1D
			
			# column-bind confounds, one file per run:
			if [ ! -f ${confounds_name}_run-${run}.1D ]; then 
				cat ${c_name}_R${run}.txt > ${confounds_name}_run-${run}.1D
			else
				paste ${confounds_name}_run-${run}.1D ${c_name}_R${run}.txt > C_tmp.1D
				mv C_tmp.1D ${confounds_name}_run-${run}.1D
			fi
		done
		
		if [ ! -f ${confounds_name}_confound.1D ]; then 
			cat ${c_name}_R-all.1D > ${confounds_name}_confound.1D
		else
			paste ${confounds_name}_confound.1D ${c_name}_R-all.1D > C_tmp2.1D
			mv C_tmp2.1D ${confounds_name}_confound.1D ###
		fi
	done

	## Concat the files of exposure runs:
	for run in `seq -f "%02g" 2 9`; do
		cat ${confounds_name}_run-${run}.1D >> ${confounds_name}_exposure-runs.1D
	done
	
	## Create a string of zeros equal to the number of volumes in the previous runs:
	if [ -f runVolumes.txt ]; then rm runVolumes.txt; fi
	
	for run in `seq -f "%02g" 1 10`; do
		echo `cat ${c_name}_R${run}.txt | wc -l` >> runVolumes.txt # print the volume of current run on a new line
		
		for NT in `cat runVolumes.txt`; do # number of timepoint
			for ((i=0; i<$NT; i++)); do
				printf -v next_run "%02d" `expr ${run} + 1`;
				echo 0 >> zeros_run-${next_run}_tmp.txt 
			done
		done
	done
		
	## Concat the two files:
	for conf in ${confound_list[*]}; do
		c_name=${conf/_/-} # replace '_' to '-'		
		
		for run in `seq -f "%02g" 1 10`; do
			if [ $run -eq 1 ]; then
				cat ${c_name}_R${run}.txt > ${c_name}_run-${run}.txt
			else 
				cat zeros_run-${run}_tmp.txt ${c_name}_R${run}.txt > ${c_name}_run-${run}.txt
			fi
		done
	done
	
	rm *tmp*
	cd ../../..
done

cd $orig_dir
