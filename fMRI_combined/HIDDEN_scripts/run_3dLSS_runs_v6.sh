#!/usr/bin/tcsh

set sfx = 'runs_v6'
set subj  = $1
set run = $2
set gname = $3

set top_dir = $4
set current_dir = `pwd`
set mask_dir = $top_dir/derivatives/fmriprep_fmap_RL/$subj/func/Masks
set stats_dir = $5
# set stats_dir = $top_dir/derivatives/afni_out/SS_results_${sfx}/${subj}_r${run}.results
							
set input_fn = pb01.$subj.r01.scale+orig.HEAD
set mask_fn = $mask_dir/${subj}_task-${gname}_run-${run}_space-T1w_desc-brain_mask.nii.gz

set stims = ( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
set model = 'GAM'

cd $stats_dir
foreach i ( `count -digit 1 1 12` )
	3dDeconvolve -verb -overwrite											\
		-input $input_fn									                \
		-censor censor_${subj}_combined_2.1D								\
		-ortvec head-motion_run-${run}.1D mot_basic							\
		-ortvec stimuli/csf+wm_run-${run}.1D CSF_WM							\
		-ortvec stimuli/ideal_jigg_onset.1D jigg_onset 						\
		-ortvec stimuli/ideal_jigg_press.1D jigg_press             			\
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
		-input $input_fn 					\
		-mask $mask_fn  					\
		-prefix LSS.stim-${stims[1]}		\
		-save1D LSS.stim-${stims[1]}.1D
	
	set tmp = ${stims[1]}
	shift stims
	set stims = ( $stims $tmp )
	
end	
cd $current_dir