#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
setenv SUBJECTS_DIR $top_dir/derivatives/FreeSurfer
set mni = $3
set prep = $4

# set rois = ( V1.ex V2.ex MT )
# set indexs = ( 10 11 12 )
set rois = ( PRC ERC ) # perirhinal cortex # entorhinal cortex
set indexs = ( 13 14 )

foreach subj ( `eval "$1 $2"` )
	set anat_dir = $top_dir/derivatives/$prep/${subj}/anat
	if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks
	set fs_dir = $SUBJECTS_DIR/${subj}
	
	mri_aparc2aseg --s ${subj} \
		--o $fs_dir/mri/aparc.BA_exvivo.mgz \
		--volmask \
		--annot BA_exvivo \
		--annot-table $fs_dir/label/BA_exvivo.ctab
	
	foreach x ( `seq 1 1 ${#rois}` )
		foreach hemi ( lh rh )
			switch ( $hemi )
				case lh:
					set idx = `expr ${indexs[$x]} + 1000`
					breaksw
				case rh:
					set idx = `expr ${indexs[$x]} + 2000`
					breaksw
			endsw

			## T1-space 		
			mri_binarize \
				--i $fs_dir/mri/aparc.BA_exvivo.mgz \
				--match $idx \
				--o $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz

			## MNI-space 		
			antsApplyTransforms \
				-d 3 \
				-n nearestNeighbor \
				-i $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz \
				-r $anat_dir/${subj}_space-${mni}_desc-preproc_T1w.nii.gz \
				-t $anat_dir/${subj}_from-T1w_to-${mni}_mode-image_xfm.h5 \
				-o $anat_dir/ROImasks/roimask_space-${mni}_$hemi-${rois[$x]}.nii.gz
		end
		
		## T1-space 
		3dcalc -overwrite \
			-a $anat_dir/ROImasks/roimask_space-T1w_lh-${rois[$x]}.nii.gz \
			-b $anat_dir/ROImasks/roimask_space-T1w_rh-${rois[$x]}.nii.gz \
			-expr 'a + b' \
			-prefix $anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz
		
		3dcopy -overwrite \
			$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz \
			$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}+orig
		
		## MNI-space 	
		3dcalc -overwrite \
			-a $anat_dir/ROImasks/roimask_space-${mni}_lh-${rois[$x]}.nii.gz \
			-b $anat_dir/ROImasks/roimask_space-${mni}_rh-${rois[$x]}.nii.gz \
			-expr 'a + b' \
			-prefix $anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz		
		
		3dcopy -overwrite \
			$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz \
			$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}+tlrc

	end
end
