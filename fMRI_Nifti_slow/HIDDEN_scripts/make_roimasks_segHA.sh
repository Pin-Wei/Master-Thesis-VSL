#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set fs = FreeSurfer
set mni = $3
set prep = $4

set identifier = T2+T1
set segHBT = hippoAmygLabels-T1-${identifier}.v22.HBT
set segCA = hippoAmygLabels-T1-${identifier}.v22.CA

set rois = ( HPC-head HPC-body HPC-tail CA1 CA3 DG Sub )
set segs = ( $segHBT $segHBT $segHBT $segCA $segCA $segCA $segCA )
set indexs = ( 232 231 226 206 208 209 205 )
	
foreach subj ( `eval "$1 $2"` )
	set anat_dir = $top_dir/derivatives/$prep/${subj}/anat
	if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks
	set fs_dir = $top_dir/derivatives/$fs/${subj}/mri
	
	foreach x ( `seq 1 1 ${#rois}` )
		foreach hemi ( lh rh )
			## T1-space
			mri_binarize \
				--i $fs_dir/$hemi.${segs[$x]}.mgz \
				--match ${indexs[$x]} \
				--o $anat_dir/ROImasks/roimask_space-T2w_$hemi-${rois[$x]}.nii.gz
											
			mri_convert \
				--apply_transform $fs_dir/transforms/T1_to_${identifier}.v22.lta \
				$anat_dir/ROImasks/roimask_space-T2w_$hemi-${rois[$x]}.nii.gz \
				$anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz
				
			## MNI-space 	
			antsApplyTransforms	\
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
			-b $anat_dir/ROImasks/roimask_space-T1w_rh-${rois[$x]}.nii.gz\
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

# -----------------------------------------------------------------------------------------
## About labels:
# https://surfer.nmr.mgh.harvard.edu/fswiki/HippocampalSubfieldsAndNucleiOfAmygdala

# freeview -v mri/rh.hippoAmygLabels-T1-T2+T1.v22.CA.mgz:colormap=lut
	# 203 presubiculum (head & body)
	# 204 parasubiculum
	# 205 subiculum (head & body)
	# 206 CA1 (head & body)
	# 208 CA3 (head & body)
	# 209 CA4 (head & body) + GC-ML-DG (head & body)
	# 211 HATA 
	# 212 fimbria
	# 215 hippocampal-fissure
	# 226 Hippocampal_tail 
	
# freeview -v mri/rh.hippoAmygLabels-T1-T2+T1.v22.HBT.mgz:colormap=lut