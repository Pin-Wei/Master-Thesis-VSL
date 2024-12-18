#!/usr/bin/env tcsh

# tcsh Extract_ROIstats_anat+gf.sh

set RE_DO = 0 # [0:False, 1:True]

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_out = $top_dir/Combined_group/derivatives
set mni = MNI152NLin2009cAsym

set output_types = ( 'maskave' 'maskave_tstats' ) # 'sigma'

set run_list = `seq -f "%02g" 2 9`
# set run_list = `seq -f "%02g" 1 10`

## ----------------------------------------------------------------------------------------------

echo "\n>> What version? (runs_MNI_3ord_v?) "
set ver = $<
set afni_ver = 'runs_MNI_3ord_v'$ver

set reml_options = ( '_REML' '' ) 
echo "\n>> REML? [1] Yes, [2] No "
set reml = ${reml_options[$<]}

set glt = ''
if ( $reml != '_REML' ) set glt = '_GLT'

if (( $afni_ver == 'runs_MNI_3ord_v6' ) || ( $afni_ver == 'runs_MNI_3ord_v7' )) then 
	set cond_list = ( 'Fst' 'Snd' 'Trd' \
		'ANY_stim'$glt 'Fst_and_Snd'$glt 'Snd_and_Trd'$glt \
		'Fst_vs_Snd'$glt 'Trd_vs_Snd'$glt 'Fst_vs_Trd'$glt \
		'Predicting'$glt 'Predicted'$glt 'Tpt_start'$glt 'Tpl_end'$glt )
		
	set c_names = ( '_Fst' '_Snd' '_Trd' \
		'_any.stim' '_1.and.2' '_2.and.3' '_1.vs.2' '_3.vs.2' '_1.vs.3' \
		'_1.2.vs.3' '_2.3.vs.1' '_1.vs.2.3' '_3.vs.1.2' )
		
else if ( $afni_ver == 'runs_MNI_3ord_v5' ) then 
	set cond_list = ( 'Fst' 'Snd' 'Trd' \
		'Any_stim'$glt 'Fst_and_Snd'$glt 'Snd_and_Trd'$glt \
		'Fst_vs_Snd'$glt 'Trd_vs_Snd'$glt 'Fst_vs_Trd'$glt )
		
	set c_names = ( '_Fst' '_Snd' '_Trd' \
		'_1+2+3' '_1+2' '_2+3' '_1-2' '_3-2' '_1-3' )
	
else
	echo "\n## ERROR: Condition list didn't setup, exit ...\n"
	exit
	
endif

## ----------------------------------------------------------------------------------------------

set roi_versions = ( 'anat' 'gfunc' )
echo "\n>> ROI version? [1] anat, [2] gfunc "
set roi_ver = ${roi_versions[$<]}

switch ( $roi_ver )

	case 'anat':
		set out_dir = $grp_out/ROIstats/${afni_ver}${reml} # <---- output directory
		
		set current_dir = `pwd`
		set roilist_txt = $current_dir/roiList.txt
		if ( -f $roilist_txt ) rm $roilist_txt # update everytime
		
		set inspect_dir = $top_dir'/Nifti/derivatives/fmriprep_fmap_RL/sub-12/anat/ROImasks'
		cd $inspect_dir
		ls roimask_space-${mni}_*_resam.nii.gz | \
			sed "s/roimask_space-${mni}_//g"   | \
			sed "s/_resam.nii.gz//g"           | \
			sed "s/\*//g" | sed "s/CBM_ex//g" > $roilist_txt
			
		cd $current_dir		
		set roi_list = ( `cat $roilist_txt` )

		breaksw
		
	case 'gfunc':
		set out_dir = $grp_out/ROIstats_gfunc/${afni_ver}${reml} # <---- output directory
		
		set SIDE = '1pos'
		set FPR = '05perc'
		set roimask_dir = $grp_out/group_func_ROImasks/ap.${afni_ver}${reml}/ETAC_$SIDE.$FPR
		if ( ! -d $roimask_dir ) mkdir -p $roimask_dir
		
		## save voxel size to file (update everytime):
		echo 'ROI\tN_voxel' > $roimask_dir/roiList_gfunc.tsv 
		
		set gstats_dir = $grp_out/WholeBrain/ap.$afni_ver/ClustSim+ETAC/Together
		
		set clust_mask_pfx = 'collapseAll'
		set clust_mask = $gstats_dir/${clust_mask_pfx}${reml}_${SIDE}.${FPR}+tlrc
		
		if ( ! -f ${clust_mask}.HEAD ) then
			echo "\n## ERROR: ${clust_mask_pfx} mask didn't made yet, exit ...\n"
			exit
			
		else
			echo 'CLUST_MASK\t'`3dBrickStat -count -positive ${clust_mask}` \
				>> $roimask_dir/roiList_gfunc.tsv
			
			set roi_list = ()
			set roi_list_specified = ( \
				'Pre_Central' 'Para_Central' 'Post_Central' 'Supra_Marginal' \
				'Sup_Pari' 'Inf_Pari' 'Pre_Cuneus' 'Lingual' 'Peri_Calcarine' 'Cuneus' \
				'V1' 'V2' 'V3' 'High-Vis' 'Sup_Temp' 'Mid_Temp' 'Inf_Temp' 'Trans_Temp' 'Fusiform' \
				'Hipp-CA1' 'Hipp-CA2+3' 'Hipp-DG+CA4' 'Hipp-Sub' 'Hippocampus' \
				'HPC-head' 'HPC-body' 'HPC-tail' 'HPC' 'PHC' 'PRC' 'ERC' 'MTL' \
				'Insula' 'Post_Cingulate' 'Isth_Cingulate' 'Caudate' 'Putamen' 'Striatal' 'CBM' \
				'lh-Hipp-CA1' 'lh-Hipp-CA2+3' 'lh-Hipp-DG+CA4' 'lh-Hipp-Sub' 'lh-Hippocampus' \
				'rh-Hipp-CA1' 'rh-Hipp-CA2+3' 'rh-Hipp-DG+CA4' 'rh-Hipp-Sub' 'rh-Hippocampus' \
				'lh-PHC' 'lh-PRC' 'lh-ERC' 'lh-Caudate' 'lh-Putamen' \
				'rh-PHC' 'rh-PRC' 'rh-ERC' 'rh-Caudate' 'rh-Putamen' \
				'V1+2' 'V1+2+3' 'LOC-V12' 'hLOC+Fus+IT' )
			
			foreach roi ( ${roi_list_specified[*]} )
			
				set roimask = $roimask_dir/${clust_mask_pfx}__${roi}
			
				if ( ! -f ${roimask}+tlrc.HEAD ) then
					set group_roimask = $grp_out/group_ROImasks/group-roimask_${roi}_resam+tlrc
					
					3dmask_tool -input $clust_mask $group_roimask -inter -fill_holes \
						-prefix $roimask
				endif

				set voxel_n = `3dBrickStat -count -positive ${roimask}+tlrc`
				
				if ( $voxel_n == 0 ) then
					rm $roimask+tlrc.*
					
				else
					set roi_list = ( ${roi_list[*]} $roi )
					
					echo $roi'\t'$voxel_n >> $roimask_dir/roiList_gfunc.tsv
				endif
				
			end # roi
		endif
		
		breaksw
endsw

if ( ! -d $out_dir ) mkdir -p $out_dir

set missing_txt = $out_dir/${afni_ver}${reml}_missing_${roi_ver}.txt # <--- record
if ( -f $missing_txt ) rm $missing_txt

## Main =========================================================================================

foreach roi ( ${roi_list[*]} )

	foreach x ( `seq 1 1 ${#cond_list}` )
	
		foreach run ( ${run_list[*]} )
		
			set PREFIX = run-${run}_MNI_${roi}${c_names[$x]} # <----------- output prefix
			
			foreach out_type ( ${output_types[*]} )
			
				switch ( $out_type ) 
					case 'maskave':
						set backup_dir = $out_dir/old_maskave
						set out_fn = ${PREFIX}_maskave
						breaksw
						
					case 'maskave_tstats':
						set backup_dir = $out_dir/old_maskave_t-val
						set out_fn = ${PREFIX}_maskave_t-val
						breaksw
						
					case 'sigma':
						set backup_dir = $out_dir/old_sigma
						set out_fn = ${PREFIX}_sigma
						breaksw
				endsw
				
				if ( -f $out_dir/${out_fn}.txt )  then
					set subj_n = `awk '{print NR}' $out_dir/${out_fn}.txt | tail -n 1`
				else
					set subj_n = 0
				endif
				
				if (( -f $out_dir/${out_fn}.txt ) && ( $subj_n == 37 ) && ( $RE_DO == 0 )) then
					echo $out_fn' exist, do not overwrite the file, skip it!'
					
				else
					set INIT = 1 # before subj ==================================================

					foreach task ( 'vsl' 'slowVSL' )
					
						switch ( $task )
							case vsl:
								set out_top = $top_dir/Nifti/derivatives
								set subj_list = `cat subjList_1.txt`
								breaksw
								
							case slowVSL:
								set out_top = $top_dir/Nifti_slow/derivatives
								set subj_list = `cat subjList_2.txt`
								breaksw
						endsw

						foreach subj ( ${subj_list[*]} )
						
							set stats_dir = $out_top/afni_out/SS_results_$afni_ver/${subj}_r${run}.results
							set stats_fn = stats.${subj}${reml}+tlrc
							
							set func_mask_dir = $out_top/fmriprep_fmap_RL/$subj/func/Masks
							
							switch ( $roi_ver )
								case 'anat':
									set roimask_dir = $out_top/fmriprep_fmap_RL/$subj/anat/ROImasks
									set roimask = $roimask_dir/roimask_space-${mni}_${roi}_resam.nii.gz
									breaksw
									
								case 'gfunc':
									set roimask = $roimask_dir/${clust_mask_pfx}__${roi}+tlrc.HEAD
									breaksw
							endsw							
							
							## backup: 
							if (( -f $out_dir/${out_fn}.txt ) && ( $INIT == 1 )) then
							
								if ( -d $backup_dir ) then # If backup folder already exist
									rm -R $backup_dir      # remove older one
									echo '-- WARNING: older version of '$out_fn' exists, remove it --'
								endif

								if ( ! -d $backup_dir ) mkdir $backup_dir
								mv $out_dir/$out_fn* $backup_dir
								echo '.. WARNING: '$out_fn' exists, move it to folder "old"'
								
							endif
							
							## check if stats exist:
							if ( -f $stats_dir/$stats_fn.HEAD ) then
							
								## if roimask do not exist (but data exist): 
								if ( ! -f $roimask ) then
								
									set func_mask = ${subj}_all-runs_space-${mni}_mask+tlrc
									set roimask_prefix = `echo $roimask | sed "s/_resam.nii.gz//g"`
									
									3dcopy ${roimask_prefix}.nii.gz ${roimask_prefix}+tlrc
									
									3dresample -overwrite -rmode NN       \
										-input ${roimask_prefix}+tlrc     \
										-master $func_mask_dir/$func_mask \
										-prefix ${roimask_prefix}_resam+tlrc
										
									3dcopy ${roimask_prefix}_resam+tlrc ${roimask_prefix}_resam.nii.gz
								
								endif ## ok, go ahead!
								
								switch ( $out_type ) 
									case 'maskave': # beta coefficients
										3dmaskave -q -mask $roimask \
											$stats_dir/${stats_fn}'['${cond_list[$x]}'#0_Coef]' \
												>> $out_dir/$out_fn.txt
										breaksw
										
									case 'maskave_tstats': # t-statistic
										3dmaskave -q -mask $roimask \
											$stats_dir/${stats_fn}'['${cond_list[$x]}'#0_Tstat]' \
												>> $out_dir/$out_fn.txt
										breaksw
										
									case 'sigma': # standard deviations
										3dROIstats -quiet -nomeanout -nzsigma -mask $roimask \
											$stats_dir/${stats_fn}'['${cond_list[$x]}'#0_Coef]' \
												>> $out_dir/$out_fn.txt
										breaksw
								endsw
								
								echo $subj',' `tail -n 1 $out_dir/$out_fn.txt` \
									>> $out_dir/$out_fn.csv
							
							## somehow, subj's parameter estimates failed...
							else 
								echo $subj >> $out_dir/$out_fn.csv
								
								if ( ! -f $missing_txt ) touch $missing_txt
								echo 'run-'$run'\t'$subj'\t'$roi >> $missing_txt
								
							endif 
							
							set INIT = 0 # one subj finished
						end 
					end # =======================================================================
					
					## all subj finished :)
				endif
			end	
		end				
	end					
end

echo ''
echo '++ Done ++'
echo '\n+ Version: runs_MNI_3ord_v'${ver}${reml}
echo '\n+ ROI mask type: '$roi_ver
echo '\n+ ROI list:\n'$roi_list
echo ''
