#!/usr/bin/tcsh

# tcsh HIDDEN_scripts/Run-many_3dLSS_runs_v7.6.sh

set current_dir = `pwd`
set sfx = 'runs_v7.6'

set space = T1w
set stims = ( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )

echo "\n>> Which dataset, [a] rapid, [b] slow, or [c] both?"
set ver = $<
if ( $ver == a ) set todo_list = ( vsl )
if ( $ver == b ) set todo_list = ( slowVSL )
if ( $ver == c ) set todo_list = ( vsl slowVSL )

foreach gname ( ${todo_list[*]} )
	cd $current_dir
	switch ( $gname )
		case vsl:
			set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
			set subj_list = `cat subjList_1.txt`
			breaksw
		case slowVSL:
			set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
			set subj_list = `cat subjList_2.txt`
			breaksw
	endsw

	foreach subj ( $subj_list )
		set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
		set mask_dir = $prep_dir/$subj/func/Masks
		set epi_dir  = $prep_dir/$subj/func/T1_space
		set stim_dir = $prep_dir/$subj/func/Timings_v4 # jiggle targets are NOT excluded
	
		foreach run ( `seq -f "%02g" 01 1 10` )
			if ((($gname == 'slowVSL') && ( $run == '01' || $run == '10' ))) then
				set model = 'GAM(8.6,.547,3)'
			else
				set model = 'GAM'
			endif
			
			set func_file = $epi_dir/${subj}_task-${gname}_run-${run}_space-T1w_desc-preproc_bold+orig
			set mask_file = $mask_dir/${subj}_task-${gname}_run-${run}_space-T1w_desc-brain_mask+orig
			
			set stats_dir = $top_dir/derivatives/afni_out/SS_results_${sfx}/${subj}_r${run}.results
			if ( ! -d $stats_dir ) mkdir -p $stats_dir
			cd $stats_dir
			
			set prev_data_dir = $top_dir/derivatives/afni_out/'SS_results_runs_v7.5'/${subj}_r${run}.results
			set input_file = pb02.$subj.r01.scale+orig # blur + scale
			cp $prev_data_dir/$input_file.* .
			
			cp $prev_data_dir/censor_${subj}_combined_2.1D .
			cp $prev_data_dir/head-motion_run-${run}.1D .
			
			mkdir stimuli
			cp $prev_data_dir/stimuli/csf+wm_run-${run}.1D ./stimuli
			cp $prev_data_dir/stimuli/ideal_jigg-Onset_OK_run-${run}.1D ./stimuli
			cp $prev_data_dir/stimuli/ideal_jigg-Hit_run-${run}.1D ./stimuli
			cp $prev_data_dir/stimuli/ideal_jigg-miss_run-${run}.1D ./stimuli
			cp $prev_data_dir/stimuli/ideal_jigg-FA_run-${run}.1D ./stimuli
			
			foreach stim ( ${stims[*]} )
				timing_tool.py -add_offset -0.962           \
					-timing $stim_dir/${stim}_run-${run}.1D \
					-write_timing ./stimuli/offset_${stim}_run-${run}.1D
			end
			
			foreach i ( `count -digit 1 1 12` )
				3dDeconvolve -verb -overwrite											\
					-input $input_file									                \
					-censor censor_${subj}_combined_2.1D								\
					-ortvec head-motion_run-${run}.1D mot_basic							\
					-ortvec stimuli/csf+wm_run-${run}.1D CSF_WM							\
					-ortvec stimuli/ideal_jigg-Onset_OK_run-${run}.1D jigg_onset_OK     \
					-ortvec stimuli/ideal_jigg-Hit_run-${run}.1D jigg_Hit               \
					-ortvec stimuli/ideal_jigg-miss_run-${run}.1D jigg_onset_miss       \
					-ortvec stimuli/ideal_jigg-FA_run-${run}.1D jigg_FA                 \
					-polort 3 -float													\
					-num_stimts 12														\
					-stim_times_IM 1 stimuli/offset_${stims[1]}_run-${run}.1D $model	\
					-stim_label 1 ${stims[1]}											\
						-stim_times 2 stimuli/offset_${stims[2]}_run-${run}.1D $model	\
						-stim_label 2 ${stims[2]}										\
						-stim_times 3 stimuli/offset_${stims[3]}_run-${run}.1D $model	\
						-stim_label 3 ${stims[3]}										\
						-stim_times 4 stimuli/offset_${stims[4]}_run-${run}.1D $model	\
						-stim_label 4 ${stims[4]}										\
						-stim_times 5 stimuli/offset_${stims[5]}_run-${run}.1D $model	\
						-stim_label 5 ${stims[5]}										\
						-stim_times 6 stimuli/offset_${stims[6]}_run-${run}.1D $model	\
						-stim_label 6 ${stims[6]}										\
						-stim_times 7 stimuli/offset_${stims[7]}_run-${run}.1D $model	\
						-stim_label 7 ${stims[7]}										\
						-stim_times 8 stimuli/offset_${stims[8]}_run-${run}.1D $model	\
						-stim_label 8 ${stims[8]}										\
						-stim_times 9 stimuli/offset_${stims[9]}_run-${run}.1D $model	\
						-stim_label 9 ${stims[9]}										\
						-stim_times 10 stimuli/offset_${stims[10]}_run-${run}.1D $model	\
						-stim_label 10 ${stims[10]}										\
						-stim_times 11 stimuli/offset_${stims[11]}_run-${run}.1D $model	\
						-stim_label 11 ${stims[11]}										\
						-stim_times 12 stimuli/offset_${stims[12]}_run-${run}.1D $model	\
						-stim_label 12 ${stims[12]}										\
					-x1D xmat.stim-${stims[1]}.1D										\
					-xjpeg X.stim-${stims[1]}.jpg										\
					-x1D_stop # just using 3dDeconvolve to set up the matrix file
				
				3dLSS -verb -overwrite					\
					-matrix xmat.stim-${stims[1]}.1D	\
					-input $input_file 					\
					-mask $mask_file  					\
					-prefix LSS.stim-${stims[1]}		\
					-save1D LSS.stim-${stims[1]}.1D
				
				set tmp = ${stims[1]}
				shift stims
				set stims = ( $stims $tmp )
				
			end	
			
			cd $current_dir
		end	
	end
end