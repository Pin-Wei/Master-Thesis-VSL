#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
set desc = aparcaseg_dseg  # desc: description
	# aparc: automatic cortical parcellation  # aseg: automatic subcortical segmentation
	# dseg: discrete segmentation  # probseg: probabilistic segmentation
set mni = $3
set prep = $4

## 'Hippocampus' 'Cerebellum' 'Inferior-parietal' 'lateral-occipital' 'Superior-parietal'
# set rois = ( HPC CBM Cuneus Fusiform Inf_Pari Lat_Occi Lingual Sup_Pari ) 
# set indexs = ( 17 53 8 47 1005 2005 1007 2007 1008 2008 1011 2011 1013 2013 1029 2029 ) # lh +1000; h +2000

## 'parahippocampal cortex'
# set rois = ( PHC ) 	
# set indexs = ( 1016 2016 )

## 'Insula' 'Transverse-Temporal' 'Superior-Temporal' 'Middle-Temporal' 'Inferior-Temporal'
# set rois = ( Insula Trans_Temp Sup_Temp Mid_Temp Inf_Temp ) 	
# set indexs = ( 1035 2035 1034 2034 1030 2030 1015 2015 1009 2009 ) 

# set rois = ( Caudate Putamen )
# set indexs = ( 11 50 12 51 )

## 'Precentral' 'Postcentral' 'Posterior-Cingulate' 'Isthmus Cingulate'
# set rois = ( Pre_Central Post_Central Post_Cingulate Isth_Cingulate )
# set indexs = ( 1024 2024 1022 2022 1023 2023 1010 2010 )

## 'precuneus' 'paracentral'
set rois = ( 'Pre_Cuneus' 'Para_Central' )
set indexs = ( 1025 2025 1017 2017 )

foreach subj ( `eval "$1 $2"` )
	set anat_dir = $top_dir/derivatives/$prep/${subj}/anat
	if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks

	set c = 1  # count
	foreach x ( `seq 1 1 ${#rois}` )
		foreach hemi ( lh rh )
			## T1-space
			mri_binarize \
				--i $anat_dir/${subj}_desc-${desc}.nii.gz \
				--match ${indexs[$c]} \
				--o $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz

			## MNI-space				
			antsApplyTransforms \
				-d 3 \
				-n nearestNeighbor \
				-i $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz \
				-r $anat_dir/${subj}_space-${mni}_desc-preproc_T1w.nii.gz \
				-t $anat_dir/${subj}_from-T1w_to-${mni}_mode-image_xfm.h5 \
				-o $anat_dir/ROImasks/roimask_space-${mni}_$hemi-${rois[$x]}.nii.gz
		
			@ c = $c + 1
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

# ---------------------------------------------------------------------------------
# labels see: https://mindboggle.readthedocs.io/en/latest/labels.html
# 31 DKT cortical labels + Neuromorphometrics BrainCOLOR subcortex labels 