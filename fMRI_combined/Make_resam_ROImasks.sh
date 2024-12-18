#!/usr/bin/tcsh -xef

# tcsh Make_resam_ROImasks.sh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL

foreach roi ( `cat roiList.txt` )	
# foreach roisname ( \
	# 'PHC' 'PRC' 'ERC' 'Hipp-CA1' 'Hipp-Sub' )	

	foreach task ( 'vsl' 'slowVSL' )
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
			set roimask_dir = $top_dir/derivatives/$prep/$subj/anat/ROImasks
			set funcmask_dir = $top_dir/derivatives/$prep/$subj/func/Masks
			
			foreach space ( T1w $mni )
				switch ( $space )
					case T1w:
						set suffix = '+orig'
						breaksw
					case $mni:
						set suffix = '+tlrc'
						breaksw
				endsw
				
				# foreach hemi ( '' 'lh-' 'rh-' ) 
					# set FILEPATH = $roimask_dir/roimask_space-${space}_${hemi}${roisname}
					set FILEPATH = $roimask_dir/roimask_space-${space}_${roi}

					if ( ! -f ${FILEPATH}_resam.nii.gz ) then
						3dcopy -overwrite ${FILEPATH}.nii.gz ${FILEPATH}${suffix}
										
						3dresample -overwrite -rmode NN \
							-input ${FILEPATH}${suffix} \
							-master $funcmask_dir/${subj}_all-runs_space-${space}_mask${suffix} \
							-prefix ${FILEPATH}_resam${suffix}
											
						3dcopy -overwrite ${FILEPATH}_resam${suffix} ${FILEPATH}_resam.nii.gz
					endif
				# end
			end
		end
	end
end
