#!/usr/bin/tcsh -xef

# tcsh Merge_ROImasks.sh

# setenv FREESURFER_HOME /usr/local/freesurfer
# source $FREESURFER_HOME/SetUpFreeSurfer.csh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL

foreach roi_hemi_sep ( 'Yes' 'No' )

	switch ( $roi_hemi_sep )
		case 'Yes':
			set rois_list = ( \
				'Hipp-CA2+3'  \
				'Hipp-DG+CA4' \
				'Hippocampus' \
				'MTL'         \
				'Hipp+MTL'    \
				'Striatal' )
			breaksw
			
		case 'No':
			set rois_list = ( \
				'hLOC+Fus+IT' \
				'High-Vis'    \
				'Visual'      \
				'V1+2'        \
				'V1+2+3'      \
				'LOC-V12' )
			breaksw
	endsw
		
	foreach roisname ( ${rois_list[*]} )

		echo '============================ '$roisname' ============================'
		
		switch ( $roisname )
			case 'Hipp-CA2+3':
				set rois = ( 'Hipp-CA2' 'Hipp-CA3' )
				breaksw
			case 'Hipp-DG+CA4':
				set rois = ( 'Hipp-DG' 'Hipp-CA4' )
				breaksw
			case 'Hippocampus':
				set rois = ( 'Hipp-CA1' 'Hipp-CA2' 'Hipp-CA3' 'Hipp-CA4' 'Hipp-DG' 'Hipp-Sub' 'Hipp-SRLM' 'Hipp-cysts' )
				breaksw
			case 'MTL':
				set rois = ( 'PHC' 'PRC' 'ERC' )
				breaksw
			case 'Hipp+MTL':
				set rois = ( 'Hippocampus' 'MTL' )
				breaksw
			case 'Striatal':
				set rois = ( 'Caudate' 'Putamen' )
				breaksw
			case 'V1+2':
				set rois = ( 'V1' 'V2' )
				breaksw	
			case 'V1+2+3':
				set rois = ( 'V1' 'V2' 'V3' )
				breaksw
			case 'LOC-V12':
				set rois = ( '' )
				breaksw
			case 'High-Vis':
				set rois = ( '' )
				breaksw	
			case 'Visual':
				set rois = ( 'V1' 'V2' 'V3' 'High-Vis' )
				breaksw	
			case 'hLOC+Fus+IT':
				set rois = ( 'LOC-V12' 'Fusiform' 'Inf_Temp' )
				breaksw	
		endsw

		foreach task ( 'vsl' 'slowVSL' )
		
			switch ( $task )
				case vsl:
					set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
					set subj_list = `cat subjList_1.txt`
					breaksw
				case slowVSL:
					set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
					set subj_list = `cat subjList_2.txt`
					breaksw
			endsw
		
			foreach subj ( ${subj_list[*]} )
			
				set roimask_dir = $top_dir/derivatives/$prep/$subj/anat/ROImasks
				set funcmask_dir = $top_dir/derivatives/$prep/$subj/func/Masks
				
				foreach space ( T1w $mni )
				
					switch ( $space )
						case T1w:
							set suffix = '+orig'
							breaksw
						case $mni:
							set suffix = '+tlrc'
							breaksw
					endsw
					
					switch ( $roi_hemi_sep )
						case 'Yes': # -----------------------------------------------------------
							
							foreach hemi ( '' 'lh-' 'rh-' ) 
							
								set FILEPATH = $roimask_dir/roimask_space-${space}_${hemi}${roisname}
									# do separate into L/R hemisphere
								
								# backup:
								if ( -f ${FILEPATH}.nii.gz ) then
									set BACKUP_DIR = $roimask_dir/Old_ROImasks
									if ! ( -d $BACKUP_DIR ) mkdir $BACKUP_DIR
									
									mv ${FILEPATH}* $BACKUP_DIR
								endif
								
								# main:
								set roimask_list = ()
								foreach roi ( ${rois[*]} )
									set roimask_list = ( ${roimask_list[*]} \
										$roimask_dir/roimask_space-${space}_${hemi}${roi}.nii.gz )
								end

								3dmask_tool -overwrite         \
									-union -fill_holes -NN3    \
									-prefix ${FILEPATH}.nii.gz \
									-input $roimask_list						
								
								# remove if weird:
								if ( `3dBrickStat -count -positive ${FILEPATH}.nii.gz` == 0 ) then
									rm ${FILEPATH}*
								
								# resample:
								else 
									3dcopy -overwrite ${FILEPATH}.nii.gz ${FILEPATH}${suffix}
									
									3dresample -overwrite -rmode NN \
										-input ${FILEPATH}${suffix} \
										-master $funcmask_dir/${subj}_all-runs_space-${space}_mask${suffix} \
										-prefix ${FILEPATH}_resam${suffix}
										
									3dcopy -overwrite ${FILEPATH}_resam${suffix} ${FILEPATH}_resam.nii.gz
								endif
								
							end # hemi
							breaksw
							
						case 'No': # ------------------------------------------------------------
							# NOTE: directly use resampled, otherwise error will occur for native space images
							
							set FILEPATH = $roimask_dir/roimask_space-${space}_${roisname}_resam 
								# do not separate into L/R hemisphere
							
							# backup:
							if ( -f ${FILEPATH}.nii.gz ) then
								set BACKUP_DIR = $roimask_dir/Old_ROImasks
								if ! ( -d $BACKUP_DIR ) mkdir $BACKUP_DIR
								
								mv ${FILEPATH}* $BACKUP_DIR
							endif
							
							# main: 
							if ( $roisname == 'High-Vis' ) then # manual
								3dcalc -overwrite \
									-a $roimask_dir/roimask_space-${space}_Lat_Occi_resam.nii.gz \
									-b $roimask_dir/roimask_space-${space}_V1_resam.nii.gz 	  \
									-c $roimask_dir/roimask_space-${space}_V2_resam.nii.gz 	  \
									-d $roimask_dir/roimask_space-${space}_V3_resam.nii.gz 	  \
									-expr 'step(a - b - c - d)' \
									-prefix ${FILEPATH}.nii.gz
									
							else if ( $roisname == 'LOC-V12' ) then 	
								3dcalc -overwrite \
									-a $roimask_dir/roimask_space-${space}_Lat_Occi_resam.nii.gz \
									-b $roimask_dir/roimask_space-${space}_V1_resam.nii.gz 	  \
									-c $roimask_dir/roimask_space-${space}_V2_resam.nii.gz 	  \
									-expr 'step(a - b - c)' \
									-prefix ${FILEPATH}.nii.gz
							else
								set roimask_list = ()
								foreach roi ( ${rois[*]} )
									set roimask_list = ( ${roimask_list[*]} \
										$roimask_dir/roimask_space-${space}_${roi}_resam.nii.gz )
								end
								
								3dmask_tool -overwrite         \
									-union -fill_holes -NN3    \
									-prefix ${FILEPATH}.nii.gz \
									-input $roimask_list	
							endif							
							breaksw
					endsw
					
					# ---------------------------------------------------------------------------
					echo ''
					
				end # space
			end # subj
		end
	end # roisname
end

## ==============================================================================================
# kill -9 $(ps -aux | grep 'Merge_ROImasks.sh' | awk '{print $2}')

## ARCHIVE:
				# ## make sure roimask for each hemisphere exist: 
				# foreach roi ( ${rois[*]} 'Lat_Occi' 'V1' 'V2' 'V3' ) 
				
					# set roimask_prefix = $roimask_dir/roimask_space-${space}
					# if ( ! -f $roimask_prefix'_lh-'$roi.nii.gz ) then
					
						# set LR_atlas_file = $roimask_dir/atlas_MNI_LR_resampled
						# if ( ! -f ${LR_atlas_file}+tlrc.HEAD ) then
						
							# 3dresample \
								# -input '/usr/local/abin/MNI_caez_lr_18+tlrc' \
								# -master $funcmask_dir/${subj}_all-runs_space-${space}_mask+tlrc \
								# -prefix $LR_atlas_file
						# endif
					
						# ## left:
						# 3dcalc -a ${roimask_prefix}_${roi}.nii.gz \
							# -b ${LR_atlas_file}+tlrc \
							# -expr 'a * iszero(b-2)'  \
							# -prefix $roimask_prefix'_lh-'$roi
						
						# 3dcopy $roimask_prefix'_lh-'$roi+tlrc $roimask_prefix'_lh-'$roi.nii.gz
						
						# ## right:
						# 3dcalc -a ${roimask_prefix}_${roi}.nii.gz \
							# -b ${LR_atlas_file}+tlrc \
							# -expr 'a * iszero(b-1)'  \
							# -prefix $roimask_prefix'_rh-'$roi
							
						# 3dcopy $roimask_prefix'_rh-'$roi+tlrc $roimask_prefix'_rh-'$roi.nii.gz
						
					# endif
				# end 
			
				## main: ========================================================================
				