#!/usr/bin/env tcsh

# tcsh Merge_group_ROImasks.sh

set mni = MNI152NLin2009cAsym
set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_ana_dir = $top_dir/Combined_group/derivatives/WholeBrain
set grp_roi_dir = $top_dir/Combined_group/derivatives/group_ROImasks
if ( ! -d $grp_roi_dir ) mkdir $grp_roi_dir

set voxelsize_file = $grp_roi_dir/roiList_voxelsize.tsv
echo 'ROI\tN_voxel' > $voxelsize_file # update everytime

# update roiList.txt everytime: -----------------------------------------------------------------
set current_dir = `pwd`

set roilist_txt = $current_dir/roiList.txt
if ( -f $roilist_txt ) rm $roilist_txt

set inspect_dir = $top_dir'/Nifti/derivatives/fmriprep_fmap_RL/sub-12/anat/ROImasks'
cd $inspect_dir
ls roimask_space-${mni}_*_resam.nii.gz | \
	sed "s|roimask_space-${mni}_||g"   | \
	sed "s|_resam.nii.gz||g"           | \
	sed "s|\*||g" > $roilist_txt
	
# main: =========================================================================================
cd $current_dir

foreach roi ( `cat roiList.txt` )

	## directly use resampled:
	set PREFIX = $grp_roi_dir/group-roimask_${roi}_resam
	set SUBJ_ROIMASK = roimask_space-${mni}_${roi}_resam.nii.gz
	
	if ( -f ${PREFIX}.nii.gz ) then # backup
		set BACKUP_DIR = $grp_roi_dir/Old_group_ROImasks
		if ! ( -d $BACKUP_DIR ) mkdir $BACKUP_DIR
		
		mv ${PREFIX}.nii.gz $BACKUP_DIR
	endif
	
	if ! ( -f ${PREFIX}.nii.gz ) then
		set input_list = ( \
			$top_dir'/Nif*/derivatives/fmriprep_fmap_RL/sub-*/anat/ROImasks/'$SUBJ_ROIMASK )
		
		3dmask_tool -overwrite       \
			-union -fill_holes -NN3  \
			-prefix ${PREFIX}.nii.gz \
			-inputs ${input_list[*]}
			
		3dcopy -overwrite ${PREFIX}.nii.gz ${PREFIX}+tlrc
	endif
	
	## save voxel-size for each ROI: 
	set voxel_n = `3dBrickStat -count -positive ${PREFIX}+tlrc`
	echo $roi'\t'$voxel_n >> $voxelsize_file

	# # -------------------------------------------------------------------------------------------
	# foreach hemi ( 'lh-' 'rh-' ) 

		# ## original resolution: 
		# set PREFIX = $grp_roi_dir/group-roimask_${hemi}${roi}
		# set SUBJ_ROIMASK = roimask_space-${mni}_${hemi}${roi}.nii.gz 
		
		# set input_list = ( \
			# $top_dir'/Nif*/derivatives/fmriprep_fmap_RL/sub-*/anat/ROImasks/'$SUBJ_ROIMASK )
			
		# 3dmask_tool -overwrite 			\
			# -union -fill_holes -NN3 	\
			# -prefix ${PREFIX}.nii.gz 	\
			# -inputs ${input_list[*]}
			
		# 3dcopy -overwrite ${PREFIX}.nii.gz ${PREFIX}+tlrc
		
		# ## resampled: 
		# 3dresample -overwrite 		\
			# -rmode NN 				\
			# -master $grp_ana_dir/group_func_mask+tlrc \
			# -input ${PREFIX}+tlrc 	\
			# -prefix ${PREFIX}_resam
			
		# 3dcopy -overwrite ${PREFIX}_resam+tlrc ${PREFIX}_resam.nii.gz
		
	# end 
	# # -------------------------------------------------------------------------------------------
end
		