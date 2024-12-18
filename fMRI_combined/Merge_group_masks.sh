#!/usr/bin/env tcsh

set space = MNI152NLin2009cAsym
set ss_masks_dir = ../derivatives/single-subj_masks
set grp_ana_dir = ../derivatives/Group_analysis

# Use NEW single-subject mask folder every time:
set tmp = 1
while ( -d $ss_masks_dir ) 
	@ tmp = $tmp + 1
	set ss_masks_dir = ${ss_masks_dir}_${tmp}
end
if ( ! -d $ss_masks_dir ) mkdir $ss_masks_dir

foreach task ( vsl slowVSL )
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
	set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
	
	foreach subj ( $subj_list )
		## copy func mask to the single-subject mask folder:
		set func_dir = $prep_dir/${subj}/func
		set bold_mask = $func_dir/Masks/${subj}_all-runs_space-${space}_mask.nii.gz
		
		if ( ! -f $bold_mask ) then
			3dmask_tool -overwrite \
				-input $func_dir/Masks/${subj}_task-${task}_run-??_space-${space}_desc-brain_mask.nii.gz \
				-prefix $bold_mask \
				-fill_holes -frac 0.9
		endif
		cp $bold_mask $ss_masks_dir
		
		## copy anat mask:
		cp $prep_dir/${subj}/anat/${subj}_space-${space}_desc-brain_mask.nii.gz $ss_masks_dir
	end
end

3dmask_tool -overwrite -quiet \
	-inputs $ss_masks_dir/sub-*_all-runs_space-${space}_mask.nii.gz \
	-prefix $grp_ana_dir/group_func_mask \
	-union -fill_holes -NN3
	
3dmask_tool -overwrite -quiet \
	-inputs $ss_masks_dir/sub-*_space-${space}_desc-brain_mask.nii.gz \
	-prefix $grp_ana_dir/group_anat_mask \
	-union -fill_holes -NN3
	
3dresample -overwrite \
	-master $grp_ana_dir/group_func_mask+tlrc \
	-input $grp_ana_dir/group_anat_mask+tlrc \
	-prefix $grp_ana_dir/group_anat_mask_resam \
	-rmode NN
	
3dmask_tool -overwrite -quiet \
	-inputs $grp_ana_dir/group_func_mask+tlrc* $grp_ana_dir/group_anat_mask_resam+tlrc* \
	-prefix $grp_ana_dir/group_mask \
	-inter -fill_holes

