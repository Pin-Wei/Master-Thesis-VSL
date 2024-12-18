#!/usr/bin/env tcsh

## ~ Major Updates ~
## *** Previously, to model out jiggle task related brain activity, 
##     we use *timing_tool* to create "stim-target_*.D" file and pass it to -regress_extra_ortvec option 
##     Which is improper! onsets didn't convolved with HRF! --> should use *3dDeconvolve, 1dBport or waver* instead!
##  ** To fix this error, we simply don't use -regress_extra_ortvec this time, 
##     but directly model it by adding "target_*.1D" to -regress_stim_times option
##   * and incluse "Hit_*.1D" (i.e., key response time) into model as well
## *** Also, previous model add positive (+1) offset to stimulus times
##     but it seems that offset should be subtracted instead of add (recap: https://afni.nimh.nih.gov/afni/community/board/read.php?1,167758,167765#msg-167765)
##  ** So the -regress_stim_times_offset is reset to -0.962,
##     which value is referred from fMRIPrep sub-*.html method description (slice-time correction notes)
## *** Apply a mask (the EPI mask output from fMRIPrep) during regression
## *** Change outlier threshold from 0.15 to 0.05 

set subj  = $1
set run = $2
set gname = $3
set top_dir = $4
set prefix = proc.240218.r$run

set scripts_dir = single-subj_scripts
set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
set anat_dir = $prep_dir/$subj/anat
set mask_dir  = $prep_dir/$subj/func/Masks
set epi_dir  = $prep_dir/$subj/func/MNI_space
set stim_dir = $prep_dir/$subj/func/Timings_2
set conf_dir = $prep_dir/$subj/func/Confounds
set space = MNI152NLin2009cAsym
set TR_correct = -0.962 # close to (TR/2 * (nslices-1)/nslices)  

switch ( $gname )
	case vsl:
		set model = 'GAM'
		breaksw
	case slowVSL:
		if (( $run == '01' || $run == '10' )) then
			set model = 'GAM(8.6,.547,3)'
		else
			set model = 'GAM'
		endif
		breaksw
endsw

afni_proc.py -subj_id $subj										\
	-script $scripts_dir/$prefix.$subj.sh -scr_overwrite		\
	-blocks blur mask scale regress								\
	-radial_correlate yes 										\
	-copy_anat													\
		$anat_dir/${subj}_space-${space}_desc-preproc_T1w.nii.gz \
	-anat_has_skull no                                          \
	-dsets                                                  	\
		$epi_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-preproc_bold.nii.gz \
	-tcat_remove_first_trs 0                                	\
	-mask_import fMRIPrep_epi_mask								\
		$mask_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-brain_mask.nii.gz \
	-mask_apply fMRIPrep_epi_mask                               \
	-mask_epi_anat yes                                          \
	-blur_size 4.0												\
	-blur_in_mask yes											\
	-regress_polort 3											\
	-regress_stim_times                                     	\
		$stim_dir/first_run-${run}.1D							\
		$stim_dir/second_run-${run}.1D							\
		$stim_dir/third_run-${run}.1D							\
		$stim_dir/targets_run-${run}.1D							\
		$stim_dir/Hit_run-${run}.1D								\
	-regress_stim_labels Fst Snd Trd jigg_onset jigg_press      \
	-regress_stim_times_offset $TR_correct						\
	-regress_extra_ortvec 										\
		$conf_dir/csf+wm_run-${run}.1D							\
	-regress_extra_ortvec_labels CSF_WM							\
	-regress_basis_multi $model									\
	-regress_opts_3dD                                       	\
		-jobs 12                                              	\
		-gltsym 'SYM: Fst +Snd +Trd' -glt_label 1 Any_stim      \
		-gltsym 'SYM: Fst +Snd' -glt_label 2 Fst_and_Snd        \
		-gltsym 'SYM: Snd +Trd' -glt_label 3 Snd_and_Trd        \
		-gltsym 'SYM: Fst -Snd' -glt_label 4 Fst_vs_Snd      	\
		-gltsym 'SYM: Trd -Snd' -glt_label 5 Trd_vs_Snd      	\
		-gltsym 'SYM: Fst -Trd' -glt_label 6 Fst_vs_Trd      	\
	-regress_motion_file $conf_dir/head-motion_run-${run}.1D	\
	-regress_apply_mot_types basic								\
	-regress_censor_motion 0.3									\
	-regress_censor_outliers 0.05								\
	-regress_make_cbucket yes 									\
	-regress_make_ideal_sum ideal_run-${run}.1D					\
	-regress_compute_fitts                                  	\
	-regress_est_blur_epits                                 	\
	-regress_est_blur_errts                                  	\
	-regress_reml_exec											\
	-html_review_style pythonic									\
	-execute
