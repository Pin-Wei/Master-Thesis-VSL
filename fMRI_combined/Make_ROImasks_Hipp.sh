#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL
set desc = subfields_atlas-histologyReference2023

echo "\n>> Which dataset, [a] rapid, [b] slow, or [c] both?"
switch ( ${<} )
	case a:
		set todo_list = ( vsl )
		breaksw
	case b:
		set todo_list = ( slowVSL )
		breaksw
	case c:
		set todo_list = ( vsl slowVSL )
		breaksw
endsw

set rois = ( \
	'Hipp-Sub' 		\
	'Hipp-CA1' 		\
	'Hipp-CA2' 		\
	'Hipp-CA3' 		\
	'Hipp-CA4' 		\
	'Hipp-DG'  		\
	'Hipp-SRLM'		\
	'Hipp-cysts'	\
)
set hemi1 = ( L R )
set hemi2 = ( lh rh )

foreach task ( ${todo_list[*]} )
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
		set hipu_dir = $top_dir/derivatives/HippUnfold/hippunfold/$subj/anat
		set anat_dir = $top_dir/derivatives/$prep/$subj/anat
		if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks		

		foreach x ( `seq 1 1 ${#rois}` )
			foreach y ( `seq 1 2` )
				# T1-space:
				mri_binarize \
					--i $hipu_dir/${subj}_hemi-${hemi1[$y]}_space-T1w_desc-${desc}_dseg.nii.gz \
					--match $x \
					--o $anat_dir/ROImasks/roimask_space-T1w_${hemi2[$y]}-${rois[$x]}.nii.gz
					
				# MNI-space:				
				antsApplyTransforms \
					-d 3 \
					-n nearestNeighbor \
					-i $anat_dir/ROImasks/roimask_space-T1w_${hemi2[$y]}-${rois[$x]}.nii.gz \
					-r $anat_dir/${subj}_space-${mni}_desc-preproc_T1w.nii.gz \
					-t $anat_dir/${subj}_from-T1w_to-${mni}_mode-image_xfm.h5 \
					-o $anat_dir/ROImasks/roimask_space-${mni}_${hemi2[$y]}-${rois[$x]}.nii.gz				
			end
		
			# T1-space:
			3dcalc -overwrite \
				-a $anat_dir/ROImasks/roimask_space-T1w_lh-${rois[$x]}.nii.gz \
				-b $anat_dir/ROImasks/roimask_space-T1w_rh-${rois[$x]}.nii.gz \
				-expr 'a + b' \
				-prefix $anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz
			
			3dcopy -overwrite \
				$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}.nii.gz \
				$anat_dir/ROImasks/roimask_space-T1w_${rois[$x]}+orig
			
			# MNI-space:
			3dcalc -overwrite \
				-a $anat_dir/ROImasks/roimask_space-${mni}_lh-${rois[$x]}.nii.gz \
				-b $anat_dir/ROImasks/roimask_space-${mni}_rh-${rois[$x]}.nii.gz \
				-expr 'a + b' \
				-prefix $anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz		
			
			3dcopy -overwrite \
				$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}.nii.gz \
				$anat_dir/ROImasks/roimask_space-${mni}_${rois[$x]}+tlrc
			
			tcsh HIDDEN_scripts/resample_roimasks.sh $task $subj ${rois[$x]}			 
			 
		end # roi
	end # subj
end # task
		