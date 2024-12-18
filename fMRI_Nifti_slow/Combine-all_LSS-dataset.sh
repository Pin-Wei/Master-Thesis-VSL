#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

# ss_ver=1115
# ss_vers=( 0205.01.CSPLIN 0205.10.CSPLIN )
# ss_vers=( runs )
# ss_vers=( runs_v2 )
ss_vers=( runs+behav )

cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

for ss_ver in ${ss_vers[*]} ; do
	for subj in `cat subjList.txt` ; do
	
		if echo $ss_ver | grep -q "runs"; then   # [CASE-1]: multi output files per subj 
			for run in `seq -f "%02g" 1 10` ; do # (i.e., separately modeling for each run)
				stats_dir=$afni_dir/SS_results_$ss_ver/${subj}_r${run}.results
				stim_dir=$stats_dir/stimuli
				
				for cond in ${cond_list[*]} ; do
					if [ -f $stats_dir/LSS.stim-${cond}.nii ] ; then rm $stats_dir/LSS.stim-${cond}.nii ; fi
					3dcopy $stats_dir/LSS.stim-${cond}+orig $stats_dir/LSS.stim-${cond}.nii
				done
				
				3dTcat -overwrite -prefix $stats_dir/LSS.all-stim_allBetas.nii \
					$stats_dir/LSS.stim-A?.nii \
					$stats_dir/LSS.stim-B?.nii \
					$stats_dir/LSS.stim-C?.nii \
					$stats_dir/LSS.stim-D?.nii
			done
		
		else # [CASE-2]: one output file per subj:
			stats_dir=$afni_dir/SS_results_$ss_ver/${subj}.results
			stim_dir=$stats_dir/stimuli
			
			if [ -f $stats_dir/LSS.stim-A1.nii ] ; then rm $stats_dir/LSS.stim-??.nii ; fi
			
			# if [ ! -f $stats_dir/LSS.stim-D3.nii ] ; then
				for cond in ${cond_list[*]} ; do
					3dcopy $stats_dir/LSS.stim-${cond}+orig $stats_dir/LSS.stim-${cond}.nii
				done
			# fi
			
			3dTcat -overwrite -prefix $stats_dir/LSS.all-stim_allBetas.nii \
				$stats_dir/LSS.stim-A?.nii \
				$stats_dir/LSS.stim-B?.nii \
				$stats_dir/LSS.stim-C?.nii \
				$stats_dir/LSS.stim-D?.nii
		fi
	done
done
