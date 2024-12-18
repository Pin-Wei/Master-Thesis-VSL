#!/usr/bin/env tcsh

# for RSA: T1w, One regressor per run
# Do smoothing, no IM, add extra_ortvec

set subj  = $1
set run = $2
set gname = $3
set top_dir = $4
set prefix = proc.230816.r$run

set scripts_dir = single-subj_scripts
set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
set anat_dir = $prep_dir/$subj/anat
set epi_dir  = $prep_dir/$subj/func/T1_space
set stim_dir = $prep_dir/$subj/func/Timings
set conf_dir = $prep_dir/$subj/func/Confounds
set space = T1w

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
	-blocks mask blur regress									\
	-copy_anat													\
		$anat_dir/${subj}_desc-preproc_T1w+orig					\
	-anat_has_skull yes                                       	\
	-dsets                                                  	\
		$epi_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-preproc_bold+orig.HEAD \
	-tcat_remove_first_trs 0                                	\
	-blur_size 4.0												\
	-blur_in_mask yes											\
	-regress_polort 3											\
	-regress_stim_times                                     	\
		$stim_dir/A1_run-${run}.1D								\
		$stim_dir/A2_run-${run}.1D								\
		$stim_dir/A3_run-${run}.1D								\
		$stim_dir/B1_run-${run}.1D								\
		$stim_dir/B2_run-${run}.1D								\
		$stim_dir/B3_run-${run}.1D								\
		$stim_dir/C1_run-${run}.1D								\
		$stim_dir/C2_run-${run}.1D								\
		$stim_dir/C3_run-${run}.1D								\
		$stim_dir/D1_run-${run}.1D								\
		$stim_dir/D2_run-${run}.1D								\
		$stim_dir/D3_run-${run}.1D								\
	-regress_stim_labels                                    	\
		A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3				 		\
	-regress_stim_times_offset 1								\
	-regress_basis_multi $model									\
	-regress_censor_outliers 0.15								\
	-regress_extra_ortvec $conf_dir/csf+wm_run-${run}.1D		\
	-regress_extra_ortvec_labels CSF_WM							\
	-regress_motion_file $conf_dir/head-motion_run-${run}.1D	\
	-regress_apply_mot_types basic								\
	-regress_censor_motion 0.3									\
	-regress_reml_exec											\
	-regress_compute_fitts                                  	\
	-regress_make_ideal_sum ideal_run-${run}.1D					\
	-regress_est_blur_epits                                 	\
	-regress_est_blur_errts                                  	\
	-html_review_style pythonic									\
	-execute


