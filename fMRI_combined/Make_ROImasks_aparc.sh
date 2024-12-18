#!/usr/bin/tcsh -xef
setenv FREESURFER_HOME /usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL
set desc = aparcaseg_dseg

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

set indexs = ( 
	1024 2024  1017 2017												\
	1022 2022  1031 2031  1029 2029  1008 2008  1025 2025				\
	1013 2013  1021 2021  1005 2005  1011 2011							\
	1030 2030  1015 2015  1009 2009  1034 2034  1007 2007				\
	1016 2016    17   53    10   49    11   50    12   51    13   52	\
	1035 2035  1023 2023  1010 2010     6   45     7   46				\
)

set rois = ( 
	Pre_Central   Para_Central													\
	Post_Central  Supra_Marginal  Sup_Pari        Inf_Pari    Pre_Cuneus		\
	Lingual       Peri_Calcarine  Cuneus          Lat_Occi						\
	Sup_Temp      Mid_Temp        Inf_Temp        Trans_Temp  Fusiform			\
	PHC           HPC             Thalamus        Caudate     Putamen     GP	\
	Insula        Post_Cingulate  Isth_Cingulate  CBM_ex      CBM_wm			\
)

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
		set anat_dir = $top_dir/derivatives/$prep/${subj}/anat
		if ( ! -d $anat_dir/ROImasks ) mkdir $anat_dir/ROImasks

		set count = 1
		foreach x ( `seq 1 1 ${#rois}` )
			foreach hemi ( lh rh )
				# T1-space:
				mri_binarize \
					--i $anat_dir/${subj}_desc-${desc}.nii.gz \
					--match ${indexs[$count]} \
					--o $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz

				# MNI-space:				
				antsApplyTransforms \
					-d 3 \
					-n nearestNeighbor \
					-i $anat_dir/ROImasks/roimask_space-T1w_$hemi-${rois[$x]}.nii.gz \
					-r $anat_dir/${subj}_space-${mni}_desc-preproc_T1w.nii.gz \
					-t $anat_dir/${subj}_from-T1w_to-${mni}_mode-image_xfm.h5 \
					-o $anat_dir/ROImasks/roimask_space-${mni}_$hemi-${rois[$x]}.nii.gz
			
				@ count = $count + 1
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

# -----------------------------------------------------------------------------------------
## About labels: https://mindboggle.readthedocs.io/en/latest/labels.html

# Frontal lobe: 
	# precentral gyrus, paracentral lobule 
# Parietal lobe: 
	# postcentral gyrus, supramarginal gyrus, superior parietal lobule, inferior parietal lobule, precuneus
# Occipital lobe: 
	# lingual gyrus, pericalcarine cortex, cuneus cortex, lateral occipital cortex
# Temporal lobe: 
	# superior temporal gyrus, middle temporal gyrus, inferior temporal gyrus, transverse temporal gyrus, fusiform gyrus
# Limbic System:
	# MTL cortices: 
		# parahippocampal cortex (PHC), perirhinal cortex (PRC), entorhinal cortex (ERC)
	# Hippocampal (HPC) subregions: 
		# dentate gyrus (DG), cornu ammonies (CA1 & CA3)
	# Striatal structures: 
		# thalamus proper, caudate nucleus, putamen, globus pallidus
	# Insular cortex
# Cingulate cortex:  
	# posterior cingulate, isthmus cingulate
# Cerebellum: 
	# cerebellum exterior, cerebellum white matter
