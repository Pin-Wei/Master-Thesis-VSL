#!/usr/bin/env tcsh

set subj  = $1
set run = $2
set gname = $3
set top_dir = $4

set prefix = proc.240316.r$run

set scripts_dir = scripts.runs_v7
if ( ! -d $scripts_dir ) mkdir 

set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
set anat_dir = $prep_dir/$subj/anat
set mask_dir = $prep_dir/$subj/func/Masks
set epi_dir  = $prep_dir/$subj/func/T1_space
set stim_dir = $prep_dir/$subj/func/Timings_v4.5 # jiggle targets ARE excluded
set ortv_dir = $prep_dir/$subj/func/Timings_2
set conf_dir = $prep_dir/$subj/func/Confounds

set space = T1w
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

## Note: T1w analysis must input data with +orig suffix
set input_anat = $anat_dir/${subj}_desc-preproc_T1w
set input_func = $epi_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-preproc_bold
set input_mask = $mask_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-brain_mask
foreach input_file ( $input_anat $input_func $input_mask )
	if ( ! -f ${input_file}+orig.HEAD ) then
		3dcopy ${input_file}.nii.gz ${input_file}+orig
	endif
end

## Note: not blurred
afni_proc.py -subj_id $subj										\
	-script $scripts_dir/$prefix.$subj.sh -scr_overwrite		\
	-blocks mask scale regress									\
	-copy_anat ${input_anat}+orig								\
	-anat_has_skull yes                                         \
	-dsets ${input_func}+orig 									\
	-tcat_remove_first_trs 0                                	\
	-mask_import fMRIPrep_epi_mask ${input_mask}+orig 			\
	-mask_apply fMRIPrep_epi_mask                               \
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
	-regress_stim_labels A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 	\
	-regress_stim_times_offset $TR_correct						\
	-regress_stim_types IM										\
	-regress_basis_multi $model									\
	-regress_extra_ortvec 										\
		$conf_dir/csf+wm_run-${run}.1D							\
		$ortv_dir/ideal_jigg-Onset_OK_run-${run}.1D             \
		$ortv_dir/ideal_jigg-Hit_run-${run}.1D                  \
		$ortv_dir/ideal_jigg-miss_run-${run}.1D                 \
		$ortv_dir/ideal_jigg-FA_run-${run}.1D                   \
	-regress_extra_ortvec_labels                                \
		CSF_WM jigg_onset_OK jigg_Hit jigg_onset_miss jigg_FA   \
	-regress_motion_file $conf_dir/head-motion_run-${run}.1D	\
	-regress_apply_mot_types basic								\
	-regress_censor_motion 0.3									\
	-regress_censor_outliers 0.05								\
	-regress_opts_3dD -allzero_OK -GOFORIT 999                  \
	-regress_opts_reml -GOFORIT                                 \
	-regress_make_ideal_sum ideal_run-${run}.1D					\
	-regress_make_cbucket yes 									\
	-regress_compute_tsnr no                                    \	
	-regress_run_clustsim no 									\
	-regress_reml_exec											\
	-html_review_style pythonic									\
	-execute
