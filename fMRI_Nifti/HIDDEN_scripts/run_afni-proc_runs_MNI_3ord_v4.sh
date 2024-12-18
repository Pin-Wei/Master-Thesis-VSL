#!/usr/bin/env tcsh

# SPECIAL: regress_polort 2

set subj  = $1
set run = $2
set gname = $3
set top_dir = $4
set prefix = proc.231020.r$run

set scripts_dir = single-subj_scripts
set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
set anat_dir = $prep_dir/$subj/anat
set epi_dir  = $prep_dir/$subj/func/MNI_space
set stim_dir = $prep_dir/$subj/func/Timings
set conf_dir = $prep_dir/$subj/func/Confounds
set space = MNI152NLin2009cAsym

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
	-dsets                                                  	\
		$epi_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-preproc_bold.nii.gz \
	-tcat_remove_first_trs 0                                	\
	-blur_size 4.0												\
	-blur_in_mask yes											\
	-regress_polort 2											\
	-regress_stim_times                                     	\
		$stim_dir/first_run-${run}.1D							\
		$stim_dir/second_run-${run}.1D							\
		$stim_dir/third_run-${run}.1D							\
	-regress_stim_labels Fst Snd Trd                            \
	-regress_stim_times_offset 1								\
	-regress_extra_ortvec 										\
		$conf_dir/csf+wm_run-${run}.1D							\
		${stim_dir}_2/stim-targets_run-${run}.1D				\
	-regress_extra_ortvec_labels CSF_WM	task_targ				\
	-regress_basis_multi $model									\
	-regress_opts_3dD                                       	\
		-jobs 12                                              	\
		-gltsym 'SYM: Fst +Snd' -glt_label 1 comb_1+2           \
		-gltsym 'SYM: Snd +Trd' -glt_label 2 comb_2+3           \
		-gltsym 'SYM: Fst -Snd' -glt_label 3 comp_1-2      	    \
		-gltsym 'SYM: Snd -Trd' -glt_label 4 comp_2-3      	    \
		-gltsym 'SYM: Fst -Trd' -glt_label 5 comp_1-3      	    \
		-gltsym 'SYM: Fst +Snd +Trd' -glt_label 6 any_stim      \
	-regress_motion_file $conf_dir/head-motion_run-${run}.1D	\
	-regress_apply_mot_types basic								\
	-regress_censor_motion 0.3									\
	-regress_censor_outliers 0.15								\
	-regress_make_cbucket yes 									\
	-regress_make_ideal_sum ideal_run-${run}.1D					\
	-regress_compute_fitts                                  	\
	-regress_est_blur_epits                                 	\
	-regress_est_blur_errts                                  	\
	-regress_reml_exec											\
	-html_review_style pythonic									\
	-execute
