!/bin/bash

task=vsl
orig_dir=`pwd`
prep_dir=$3
prep_dir=/media/data2/pinwei/SL_hippocampus/Nifti/derivatives/fmriprep_fmap_RL
event_dir=$prep_dir/../event.v2
cond_list=( first second third  A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
	
for sid in `seq -f "%02g" $1 $2`; do
	subj=sub-$sid
for subj in `cat subjList.txt`; do
	cd $prep_dir/$subj/func/Timings
	
	# only include exposure runs
	for cond in ${cond_list[*]}; do
	
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 1 0 0 0 0 0 0 0 -write_timing ${cond}_r2_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 2 0 0 0 0 0 0 -write_timing ${cond}_r3_ex.1D 
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 3 0 0 0 0 0 -write_timing ${cond}_r4_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 4 0 0 0 0 -write_timing ${cond}_r5_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 5 0 0 0 -write_timing ${cond}_r6_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 0 6 0 0 -write_timing ${cond}_r7_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 0 0 7 0 -write_timing ${cond}_r8_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 0 0 0 8 -write_timing ${cond}_r9_ex.1D
			
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 1 2 0 0 0 0 0 0 -write_timing ${cond}_R2-3_ex.1D 
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 3 4 0 0 0 0 -write_timing ${cond}_R4-5_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 5 6 0 0 -write_timing ${cond}_R6-7_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 0 0 7 8 -write_timing ${cond}_R8-9_ex.1D
			
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 1 2 3 4 0 0 0 0 -write_timing ${cond}_R2-5_ex.1D
		timing_tool.py -fsl_timing_files \
			${cond}_run-02.txt ${cond}_run-03.txt ${cond}_run-04.txt ${cond}_run-05.txt \
			${cond}_run-06.txt ${cond}_run-07.txt ${cond}_run-08.txt ${cond}_run-09.txt \
			-select_runs 0 0 0 0 5 6 7 8 -write_timing ${cond}_R6-9_ex.1D
	done
done

