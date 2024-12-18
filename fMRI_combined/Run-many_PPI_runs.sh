#!/usr/bin/env tcsh

# tcsh Run-many_PPI_runs.sh

# https://afni.nimh.nih.gov/CD-CorrAna
# https://afni.nimh.nih.gov/pub/dist/edu/data/CD.expanded/AFNI_data6/FT_analysis/PPI/

set ap_t1w_ver = '3ord_v6'
set ap_mni_ver = '3ord_v7'

echo "\n>> Which dataset, [a] rapid, [b] slow, or [c] both?"
set ver = $<
if ( $ver == a ) set todo_list = ( vsl )
if ( $ver == b ) set todo_list = ( slowVSL )
if ( $ver == c ) set todo_list = ( vsl slowVSL )

set top_dir = /media/data2/pinwei/SL_hippocampus
set group_func_top = $top_dir/Combined_group/derivatives/group_func_ROImasks

set SIDE = '1pos'
set FPR = '05perc'
set group_func_dir = $group_func_top/ap.runs_MNI_3ord_v6_REML/ETAC_${SIDE}.${FPR}

set roi_list = ( Hippocampus ) # ( 'HPC-head' 'HPC-body' 'HPC-tail' )
set cond_list = ( 'Fst' 'Snd' 'Trd' )
set run_list = ( `seq -f "%02g" 2 9` )

set TR = 2.0
set N_TR = 115
set model = 'GAM'
set mni = 'MNI152NLin2009cAsym'

#################################################################################################

foreach task ( ${todo_list[*]} )
	switch ( $task )
		case vsl:
			set sub_dir = $top_dir/Nifti
			set subj_list = `cat $top_dir/Combined_group/code/subjList_1.txt`
			breaksw
		case slowVSL:
			set sub_dir = $top_dir/Nifti_slow
			set subj_list = `cat $top_dir/Combined_group/code/subjList_2.txt`
			breaksw
	endsw
	
	set prep_dir = $sub_dir/derivatives/fmriprep_fmap_RL
	set afni_t1w_dir = $sub_dir/derivatives/afni_out/'SS_results_runs_T1w_'$ap_t1w_ver
	set afni_mni_dir = $sub_dir/derivatives/afni_out/'SS_results_runs_MNI_'$ap_mni_ver
	
	foreach subj ( ${subj_list[*]} ) 
	# foreach subj ( sub-02 ) 
	
		set anat_dir = $prep_dir/$subj/anat
		set func_dir = $prep_dir/$subj/func
		
		foreach run ( ${run_list[*]} ) 
		# foreach run ( 02 )
		
			## Make PPI regressors: =============================================================
			
			cd $afni_t1w_dir/${subj}_r${run}.results 
			
			set bold_file = all_runs.$subj+orig
			set stat_file = stats.${subj}_REML+orig
			set coef_file = all_betas.${subj}_REML+orig
			
			## Extract the drift effect (baseline part): ----------------------------------------
			# 	to see and select columns: grep ColumnLabels X.xmat.1D
			if ( ! -f trends+orig.HEAD ) then
				3dSynthesize \
					-matrix X.xmat.1D             \
					-cbucket all_betas.$subj+orig \
					-select 0 1 2 3               \
					-prefix trends 
			endif 

			## Remove the trend from the original BOLD series: ----------------------------------
			if ( ! -f bold_detrend+orig.HEAD ) then
				3dcalc \
					-a $bold_file    \
					-b trends+orig   \
					-expr "a-b"      \
					-prefix bold_detrend
			endif
			
			foreach roi ( ${roi_list[*]} ) 
			
				set group_func_mask = $group_func_dir/collapseAll__${roi}
			
				## Generate T1W functional ROI mask: --------------------------------------------
				set t1w_func_mask = gfunc_${roi}_T1w_mask
				
				if ( ! -f ${group_func_mask}.nii.gz ) then
					3dcopy ${group_func_mask}+tlrc ${group_func_mask}.nii.gz
				endif
				
				if ( ! -f ${t1w_func_mask}+orig.HEAD ) then
					antsApplyTransforms            \
						-d 3 -n nearestNeighbor    \
						-i ${group_func_mask}.nii.gz \
						-r $func_dir/Masks/${subj}_all-runs_space-T1w_mask.nii.gz \
						-t $anat_dir/${subj}_from-${mni}_to-T1w_mode-image_xfm.h5 \
						-o ${t1w_func_mask}.nii.gz
						
					3dcopy ${t1w_func_mask}.nii.gz ${t1w_func_mask}+orig
				endif
				
				## Extract seed time series (averaged BOLD signal): -----------------------------
				set seed_time_series = gfunc_${roi}_maskave.1D
				
				if ( ! -f $seed_time_series ) then
					3dmaskave -quiet \
						-mask ${t1w_func_mask}+orig \
						bold_detrend+orig > $seed_time_series
				endif
				
				## Generate HRF basis: ----------------------------------------------------------
				if ( ! -f GammaHR.1D ) then 
					waver -dt $TR -GAM -peak 1 -inline 1@1 > GammaHR.1D
				endif
				
				## Run deconvolution on the seed time series: -----------------------------------
				set neuro_seed_reg = stimuli/gfunc_${roi}_decon.1D
				
				if ( ! -f $neuro_seed_reg ) then
					3dTfitter \
						-RHS $seed_time_series \
						-FALTUNG GammaHR.1D $neuro_seed_reg 012 0
				endif
				
				## Obtain the interaction regressor: --------------------------------------------
				foreach cond ( ${cond_list[*]} )
					set neuro_stim_reg = stimuli/gfunc_${roi}_${cond}.1D
					
					set ideal_stim_reg = ideal_${cond}.1D
					if ( ! -f stimuli/$ideal_stim_reg ) mv $ideal_stim_reg stimuli
					
					if ( ! -f $neuro_stim_reg ) then
						1deval \
							-a ${neuro_seed_reg}\'     \
							-b stimuli/$ideal_stim_reg \
							-expr 'a*b' > $neuro_stim_reg
					endif
					
					## Plot and check: ----------------------------------------------------------
					set fig_name = PPI_gfunc_${roi}_${cond}.png
					
					if ( ! -f $fig_name ) then
						1dplot \
							-sepscl -ps -png $fig_name      \
							-ynames 'Inter' 'Neur' 'Stim' - \
							$neuro_stim_reg $neuro_seed_reg stimuli/$ideal_stim_reg
					endif
				end
			end
			
			## Regression analysis: =============================================================
			
			cd $afni_mni_dir/${subj}_r${run}.results
			cp $afni_t1w_dir/${subj}_r${run}.results/stimuli/gfunc_* stimuli
			
			foreach roi ( ${roi_list[*]} )
			
				set ppi_prefix = PPI.gfunc_${roi}
				
				if ( ! -f ${ppi_prefix}.stats+tlrc.HEAD ) then
				
					3dDeconvolve -input pb02.$subj.r01.scale+tlrc.HEAD                  \
						-mask mask_import_fMRIPrep_epi_mask+tlrc                        \
						-censor censor_${subj}_combined_2.1D                            \
						-ortvec stimuli/csf+wm_run-${run}.1D CSF_WM                     \
						-ortvec stimuli/ideal_jigg-Onset_OK_run-${run}.1D jigg_onset_OK \
						-ortvec stimuli/ideal_jigg-Hit_run-${run}.1D jigg_Hit           \
						-ortvec stimuli/ideal_jigg-miss_run-${run}.1D jigg_onset_miss   \
						-ortvec stimuli/ideal_jigg-FA_run-${run}.1D jigg_FA             \
						-ortvec head-motion_run-${run}.1D mot_basic                     \
						-polort 3 -float                                                \
						-num_stimts 7                                                   \
						-stim_times 1 stimuli/offset_first_run-${run}.1D $model         \
						-stim_label 1 Fst                                               \
						-stim_times 2 stimuli/offset_second_run-${run}.1D $model        \
						-stim_label 2 Snd                                               \
						-stim_times 3 stimuli/offset_third_run-${run}.1D $model         \
						-stim_label 3 Trd                                               \
						-stim_file  4 $neuro_seed_reg -stim_label 4 PPI.seed            \
						-stim_file  5 stimuli/gfunc_${roi}_Fst.1D -stim_label 5 PPI.Fst \
						-stim_file  6 stimuli/gfunc_${roi}_Snd.1D -stim_label 6 PPI.Snd \
						-stim_file  7 stimuli/gfunc_${roi}_Trd.1D -stim_label 7 PPI.Trd \
						-jobs 12                                                        \
						-gltsym 'SYM: PPI.Fst | PPI.Snd | PPI.Trd' -glt_label 1 PPI.ANY_stim    \
						-gltsym 'SYM: PPI.Fst | PPI.Snd'           -glt_label 2 PPI.Fst_and_Snd \
						-gltsym 'SYM: PPI.Snd | PPI.Trd'           -glt_label 3 PPI.Snd_and_Trd \
						-gltsym 'SYM: PPI.Fst -PPI.Snd'            -glt_label 4 PPI.Fst_vs_Snd  \
						-gltsym 'SYM: PPI.Trd -PPI.Snd'            -glt_label 5 PPI.Trd_vs_Snd  \
						-gltsym 'SYM: PPI.Fst -PPI.Trd'            -glt_label 6 PPI.Fst_vs_Trd  \
						-gltsym 'SYM: PPI.Fst +PPI.Snd -2*PPI.Trd' -glt_label 7 PPI.Predicting  \
						-gltsym 'SYM: PPI.Snd +PPI.Trd -2*PPI.Fst' -glt_label 8 PPI.Predicted   \
						-gltsym 'SYM: 2*PPI.Fst -PPI.Snd -PPI.Trd' -glt_label 9 PPI.Tpt_start   \
						-gltsym 'SYM: 2*PPI.Trd -PPI.Fst -PPI.Snd' -glt_label 10 PPI.Tpl_end    \
						-allzero_OK -GOFORIT 999    \
						-fout -tout                 \
                        -errts  ${ppi_prefix}.errts \
						-bucket ${ppi_prefix}.stats
				endif
				
				if ( ! -f ${ppi_prefix}.stats_REML+tlrc.HEAD ) then
					tcsh PPI.REML_cmd -GOFORIT
				endif
			end
		end
	end
end

cd $top_dir/Combined_group/code

