#!/usr/bin/tcsh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set task = slowVSL
set mni = $3
set prep = $4

foreach subj ( `eval "$1 $2"` )
	set func_dir = $top_dir/derivatives/$prep/${subj}/func
	set roimask_dir = $top_dir/derivatives/$prep/${subj}/anat/ROImasks

	# rm $roimask_dir/roimask_space-T1w_*+tlrc*
	# rm $roimask_dir/roimask_space-${mni}*+orig*

	# foreach roi ( `cat roiList.txt` )
	# foreach roi ( PHC PRC ERC )
	# foreach roi ( HPC-body HPC-tail )
	# foreach roi ( Insula Trans_Temp Sup_Temp Mid_Temp Inf_Temp )
	# foreach roi ( Caudate Putamen )
	# foreach roi ( Pre_Central Post_Central Post_Cingulate Isth_Cingulate )
	# foreach roi ( Pre_Cuneus Para_Central )
	foreach roi ( v1 v2 hV4 VO1 VO2 LO1 LO2 TO1 TO2 V3b V3a )
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
	end				
end