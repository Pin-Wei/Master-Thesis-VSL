#!/usr/bin/tcsh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL

set task = $1
switch ( $task )
	case vsl:
		set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
		breaksw
	case slowVSL:
		set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
		breaksw
endsw

set subj = $2
set func_dir = $top_dir/derivatives/$prep/$subj/func
set roimask_dir = $top_dir/derivatives/$prep/$subj/anat/ROImasks

set roi = $3
foreach space ( T1w $mni )
	switch ( $space )
		case T1w:
			set fn = T1_space
			set sufx = orig
			breaksw
		case ${mni}:
			set fn = MNI_space
			set sufx = tlrc
			breaksw
	endsw
	
	set bold_mask = $func_dir/Masks/${subj}_all-runs_space-${space}_mask
	if ( ! -f ${bold_mask}.nii.gz ) then
		3dmask_tool -overwrite \
			-input $func_dir/Masks/${subj}_task-${task}_run-??_space-${space}_desc-brain_mask.nii.gz \
			-prefix $bold_mask \
			-fill_holes -frac 0.9
	endif
	if ( ! -f ${bold_mask}+${sufx}.HEAD ) then
		3dcopy ${bold_mask}.nii.gz ${bold_mask}+${sufx}
	endif
	
	3dresample -overwrite \
		-master $bold_mask+${sufx} \
		-prefix $roimask_dir/roimask_space-${space}_${roi}_resam+${sufx} \
		-input $roimask_dir/roimask_space-${space}_${roi}+${sufx} \
		-rmode NN
		
	3dcopy -overwrite \
		$roimask_dir/roimask_space-${space}_${roi}_resam+${sufx} \
		$roimask_dir/roimask_space-${space}_${roi}_resam.nii.gz
end