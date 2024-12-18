#!/usr/bin/tcsh

# tcsh run_afni-proc_runs_T1w_3ord_v6+cbucket.sh

foreach task ( vsl slowVSL )
# foreach task ( vsl )
	switch ( $task )
		case vsl:
			set subj_list = `cat subjList_1.txt`
			set afni_out = /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out
			breaksw
			
		case slowVSL:
			set subj_list = `cat subjList_2.txt`
			set afni_out = /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out
			breaksw
	endsw

	foreach subj ( ${subj_list[*]} )
	# foreach subj ( sub-02 )
		foreach run ( `seq -f "%02g" 2 9` )
		# foreach run ( 02 )
			set stats_dir = $afni_out/SS_results_runs_T1w_3ord_v6/${subj}_r${run}.results

			3dDeconvolve -input $stats_dir/pb02.$subj.r01.scale+orig.HEAD                  \
				-mask $stats_dir/mask_import_fMRIPrep_epi_mask+orig                        \
				-censor $stats_dir/censor_${subj}_combined_2.1D                            \
				-ortvec $stats_dir/stimuli/csf+wm_run-${run}.1D CSF_WM                     \
				-ortvec $stats_dir/stimuli/ideal_jigg-Onset_OK_run-${run}.1D jigg_onset_OK \
				-ortvec $stats_dir/stimuli/ideal_jigg-Hit_run-${run}.1D jigg_Hit           \
				-ortvec $stats_dir/stimuli/ideal_jigg-miss_run-${run}.1D jigg_onset_miss   \
				-ortvec $stats_dir/stimuli/ideal_jigg-FA_run-${run}.1D jigg_FA             \
				-ortvec $stats_dir/head-motion_run-${run}.1D mot_basic                     \
				-polort 3 -float                                                           \
				-num_stimts 3                                                              \
				-stim_times 1 $stats_dir/stimuli/offset_first_run-${run}.1D 'GAM'          \
				-stim_label 1 Fst                                                          \
				-stim_times 2 $stats_dir/stimuli/offset_second_run-${run}.1D 'GAM'         \
				-stim_label 2 Snd                                                          \
				-stim_times 3 $stats_dir/stimuli/offset_third_run-${run}.1D 'GAM'          \
				-stim_label 3 Trd                                                          \
				-jobs 12                                                                   \
				-allzero_OK                                                                \
				-GOFORIT 999                                                               \
				-cbucket $stats_dir/all_betas.$subj
 
			3dREMLfit -matrix $stats_dir/X.xmat.1D                  \
				-input $stats_dir/pb02.$subj.r01.scale+orig.HEAD    \
				-mask $stats_dir/mask_import_fMRIPrep_epi_mask+orig \
				-Rbeta $stats_dir/all_betas.${subj}_REML            \
				-GOFORIT -verb $*
				
		end
	end
end