#!/usr/bin/env tcsh

set subj  = $1
set run = $2
set gname = $3
set top_dir = $4
set prefix = proc.240222.r$run

set scripts_dir = single-subj_scripts
set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
set anat_dir = $prep_dir/$subj/anat
set mask_dir  = $prep_dir/$subj/func/Masks
set epi_dir  = $prep_dir/$subj/func/MNI_space
set stim_dir = $prep_dir/$subj/func/Timings_2 # 
set conf_dir = $prep_dir/$subj/func/Confounds
set space = MNI152NLin2009cAsym

set N_TR = 115

switch ( $gname )
	case vsl:
		set model = 'GAM'
		if (( $run == '01' || $run == '10' )) set N_TR = 59
		breaksw
		
	case slowVSL:
		if (( $run == '01' || $run == '10' )) then
			set N_TR = 217
			set model = 'GAM(8.6,.547,3)'
		else
			set model = 'GAM'
		endif
		breaksw
endsw

# foreach stim ( 'first' 'second' 'third' )
	# set ideal_stim_reg = ideal_stim-${stim}_run-${run}.1D
	
	# if ( ! -f $stim_dir/$ideal_stim_reg ) then
		# 3dDeconvolve -polort -1 -nodata $N_TR 2.0 -num_stimts 1  \
			# -stim_times 1 $stim_dir/${stim}_run-${run}.1D $model \
			# -stim_times_subtract 0.962                           \
			# -x1D $stim_dir/$ideal_stim_reg -x1D_stop 	
	# endif
# end

foreach reg ( 'Onset_OK' 'Hit' 'miss' 'FA' )
	set ideal_jigg_reg = ideal_jigg-${reg}_run-${run}.1D
	
	if ( ! -f $stim_dir/$ideal_jigg_reg ) then
		3dDeconvolve -polort -1 -nodata $N_TR 2.0 -num_stimts 1 \
			-stim_times 1 $stim_dir/${reg}_run-${run}.1D 'GAM'  \
			-stim_times_subtract 0.962 -allzero_OK              \
			-x1D $stim_dir/$ideal_jigg_reg -x1D_stop 	
	endif
end

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
	-regress_stim_labels                                        \
		Fst Snd Trd                                             \
	-regress_stim_times_offset -0.962						    \
	-regress_basis_multi $model									\
	-regress_extra_ortvec 										\
		$conf_dir/csf+wm_run-${run}.1D							\
		$stim_dir/ideal_jigg-Onset_OK_run-${run}.1D             \
		$stim_dir/ideal_jigg-Hit_run-${run}.1D                  \
		$stim_dir/ideal_jigg-miss_run-${run}.1D                 \
		$stim_dir/ideal_jigg-FA_run-${run}.1D                   \
	-regress_extra_ortvec_labels                                \
		CSF_WM jigg_onset_OK jigg_Hit jigg_onset_miss jigg_FA   \
	-regress_motion_file $conf_dir/head-motion_run-${run}.1D	\
	-regress_apply_mot_types basic								\
	-regress_censor_motion 0.3									\
	-regress_censor_outliers 0.05								\
	-regress_opts_3dD                                       	\
		-jobs 12                                              	\
		-gltsym 'SYM: Fst | +Snd | +Trd' -glt_label 1 ANY_stim  \
		-gltsym 'SYM: Fst | +Snd' -glt_label 2 Fst_and_Snd      \
		-gltsym 'SYM: Snd | +Trd' -glt_label 3 Snd_and_Trd      \
		-gltsym 'SYM: Fst -Snd' -glt_label 4 Fst_vs_Snd      	\
		-gltsym 'SYM: Trd -Snd' -glt_label 5 Trd_vs_Snd      	\
		-gltsym 'SYM: Fst -Trd' -glt_label 6 Fst_vs_Trd      	\
		-gltsym 'SYM: Fst +Snd -2*Trd' -glt_label 7 Predicting  \
		-gltsym 'SYM: Snd +Trd -2*Fst' -glt_label 8 Predicted   \
		-gltsym 'SYM: 2*Fst -Snd -Trd' -glt_label 9 Tpt_start   \
		-gltsym 'SYM: 2*Trd -Fst -Snd' -glt_label 10 Tpl_end    \
		-allzero_OK -GOFORIT 999                                \
	-regress_opts_reml -GOFORIT                                 \
	-regress_make_ideal_sum ideal_run-${run}.1D					\
	-regress_make_cbucket yes 									\
	-regress_compute_fitts                                  	\
	-regress_est_blur_epits                                 	\
	-regress_est_blur_errts                                  	\
	-regress_reml_exec											\
	-html_review_style pythonic									\
	-execute

# =======================================================================
	
	# -regress_use_stim_files                                     \
	# -regress_stim_files                                     	\
		# $stim_dir/ideal_stim-first_run-${run}.1D				\
		# $stim_dir/ideal_stim-second_run-${run}.1D				\
		# $stim_dir/ideal_stim-third_run-${run}.1D				\