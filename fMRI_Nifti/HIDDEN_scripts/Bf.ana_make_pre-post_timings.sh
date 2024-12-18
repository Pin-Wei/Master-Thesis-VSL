#!/bin/bash

task=vsl
orig_dir=`pwd`
# prep_dir=$3
prep_dir=/media/data2/pinwei/SL_hippocampus/Nifti/derivatives/fmriprep_fmap_RL
event_dir=$prep_dir/../event.v2
cond_list=( first second third A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
	
# for sid in `seq -f "%02g" $1 $2`; do
	# subj=sub-$sid
for subj in `cat subjList.txt`; do
	cd $prep_dir/$subj/func/Timings
	
	## only include single runs
	for cond in ${cond_list[*]}; do
	
		timing_tool.py -fsl_timing_files \
			${cond}_run-01.txt -write_timing ${cond}_pre_expo.1D
			
		timing_tool.py -fsl_timing_files \
			${cond}_run-10.txt -write_timing ${cond}_post_expo.1D 
	done
done

