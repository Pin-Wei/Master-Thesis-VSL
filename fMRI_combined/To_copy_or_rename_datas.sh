#!/usr/bin/env tcsh

set mni = MNI152NLin2009cAsym

set top_top = /media/data2/pinwei/SL_hippocampus
set grp_deri = $top_top/Combined_group/derivatives
set grp_stat_out = $grp_deri/Group_analysis/ap.1207
set ss_mask_cp = $grp_deri/single-subj_masks
set ss_bold_cp = $grp_deri/single-subj_BOLD
set grp_roi_dir = $grp_deri/group_ROImasks

set afni_ver = 'runs'
# set afni_ver = '1225'
# set afni_ver = '0215.01'
# set afni_ver = '0215.10'

foreach task ( vsl slowVSL )
	switch ( $task )
		case vsl:
			set top_dir = $top_top/Nifti
			set subj_list = `cat subjList_1.txt`
			breaksw
		case slowVSL:
			set top_dir = $top_top/Nifti_slow
			set subj_list = `cat subjList_2.txt`
			breaksw
	endsw
	set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
	set afni_dir = $top_dir/derivatives/afni_out/SS_results_${afni_ver}

	foreach subj ( $subj_list )
		set func_dir = $prep_dir/$subj/func
		set anat_dir = $prep_dir/$subj/anat
		set roimask_dir = $anat_dir/ROImasks
		
		# cp $anat_dir/${subj}_desc-preproc_T1w.nii.gz $ss_mask_cp
		
		# set copy_2 = $grp_deri/T1w_all-runs+anat/$subj
		# mkdir copy_2
		# cp -r $func_dir/Masks/${subj}_all-runs_space-T1w_mask.nii.gz $copy_2
		# cp -r $anat_dir/${subj}_desc-brain_mask.nii.gz $copy_2
		# cp -r $anat_dir/mask_space-T1w_resam.nii.gz $copy_2		
		
		# cd $roimask_dir
		# # rename 's/FS/T2w/' *_space-FS_*
		# # rename 's/V1/V1.ex/' *_V1*
		# # rename 's/V2/V2.ex/' *_V2*
		# rename 's/v1/V1/' *_v1*
		# rename 's/v2/V2/' *_v2*
		# rename 's/Hipp-darkband/Hipp-SRLM/' *_Hipp-darkband*
		# cd $top_top/Combined_group/code
		
		# set roimask_dir_2 = $ss_mask_cp/ROImasks/${subj}/ROImasks
		# foreach roi ( hV4 VO1 VO2 LO1 LO2 TO1 TO2 V3b V3a )
			# cp $roimask_dir_2/roimask_space-*_${roi}* $roimask_dir
		# end
		
		# set stats_dir = $afni_dir/${subj}.results
		# 3dcopy $stats_dir/all_runs.${subj}+orig $stats_dir/all_runs.${subj}.nii.gz
		# cp $stats_dir/all_runs.${subj}.nii.gz $ss_bold_cp
		
		# foreach run ( `seq -f "%02g" 01 1 10` )
			# set stats_dir = $afni_dir/${subj}_r${run}.results
			# cd $stats_dir
			# rename 's/mean./v+/' mean.*
			# cd $top_top/Combined_group/code	
		# end
		
		# foreach fd2 ( 'ap-runs' 'ap-runs+behav' 'ap-runs_v+' 'ap-runs_v2' )
			# foreach run ( `seq -f "run-%02g" 01 1 10` )
				# foreach fd3 ( 'Betas' 'Betas_REML' 'Tstats' 'Tstats_REML' )
					# set ta_dir = $grp_deri/PyRSA/masked_data/$fd2/$run/$fd3
					# if ( -d $ta_dir ) then
						# cd $ta_dir
						# rename 's/V1/V1.ex/' *_V1*
						# rename 's/V2/V2.ex/' *_V2*
						# rename 's/v1/V1/' *_v1*
						# rename 's/v2/V2/' *_v2*
						# cd $top_top/Combined_group/code
					# endif
				# end
			# end
		# end
		
		# foreach fd1 ( 'shape_png' 'similarity_change_values' 'tpl_sorted' )
			# foreach fd2 ( 'ap-runs' 'ap-runs+behav' 'ap-runs_v+' 'ap-runs_v2' )
				# foreach fd3 ( 'Betas' 'Tstats_REML' )
					# foreach fd4 ( 'Euclidean_dist' 'Pearson_r_z' 'Spearman_r_z' )
						# foreach run ( `seq -f "run-%02g" 01 1 10` )
							# set ta_dir = $grp_deri/PyRSA/similarity_matrices/$fd1/$fd2/$fd3/$fd4/$run
							# if ( -d $ta_dir ) then
								# cd $ta_dir
								# rename 's/V1/V1.ex/' V1_*
								# rename 's/V2/V2.ex/' V2_*
								# rename 's/v1/V1/' v1_*
								# rename 's/v2/V2/' v2_*
								
								# cd $top_top/Combined_group/code
							# endif
						# end
					# end
				# end
			# end
		# end

	end	
end

