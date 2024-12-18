#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
set mni = $3
set prep = $4

# set rois = ( V3 )
# set indexs = ( 3 )
# set rois = ( hV4 VO1 VO2 LO1 LO2 TO1 TO2 V3b V3a )
# set indexs = ( 4 5 6 7 8 9 10 11 12 )
set rois = ( V1 V2 )
set indexs = ( 1 2 )

foreach subj ( `eval "$1 $2"` )
	set anat_dir = $top_dir/derivatives/$prep/${subj}/anat
	if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks
	# set fs_dir = $SUBJECTS_DIR/${subj}
	set fs_dir = $top_dir/derivatives/FreeSurfer/${subj}
	
	foreach x ( `seq 1 1 ${#rois}` )
		## T1-space 
		mri_binarize \
			--i $fs_dir/mri/benson14_varea.mgz \
			--match ${indexs[$x]} \
			--o $anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz

		## MNI-space		
		antsApplyTransforms \
			-d 3 \
			-n nearestNeighbor \
			-i $anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz \
			-r $anat_dir/${subj}_space-${mni}_desc-preproc_T1w.nii.gz \
			-t $anat_dir/${subj}_from-T1w_to-${mni}_mode-image_xfm.h5 \
			-o $anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz
			
		## T1-space 
		3dcopy -overwrite \
			$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz \
			$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}+orig
		
		## MNI-space 	
		3dcopy -overwrite \
			$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz \
			$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}+tlrc 
			
	end
end

# ---------------------------------------------------------------------------------
# see https://osf.io/knb5g/wiki/Usage/ for more informations.
# Labels 
# 0		No visual area
# 1		V1
# 2		V2
# 3		V3
# 4		hV4
# 5		VO1
# 6		VO2
# 7		LO1
# 8		LO2
# 9		TO1
# 10	TO2
# 11	V3b
# 12	V3a