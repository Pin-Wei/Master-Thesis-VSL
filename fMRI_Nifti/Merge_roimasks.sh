#!/usr/bin/env tcsh

set task = vsl
set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
# set task = slowVSL
# set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
# set space = T1w
set space = MNI152NLin2009cAsym

set rois = ( 'DG' 'CA1' 'CA3' 'Sub' 'HPC' 'PHC' 'PRC' 'ERC' )
set roisname = 'HPC+MTL'
# set rois = ( 'PHC' 'PRC' 'ERC' )
# set roisname = 'MTL'

foreach subj ( `cat subjList.txt` )
	set roimask_dir = $prep_dir/${subj}/anat/ROImasks
	set funcmask_dir = $prep_dir/${subj}/func/Masks
	
	foreach suffix ( '_resam' )
		set roimask_list = ()
		foreach roi ( ${rois[*]} )
			set roimask_list = ( ${roimask_list[*]} $roimask_dir/roimask_space-${space}_${roi}${suffix}.nii.gz )
		end
		
		3dmask_tool -overwrite -NN3 \
			-prefix $roimask_dir/roimask_space-${space}_${roisname}${suffix}.nii.gz \
			-union -fill_holes -dilate_result 1 \
			-input $roimask_list
	end
end