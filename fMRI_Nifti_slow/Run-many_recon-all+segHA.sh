#!/usr/bin/env tcsh

set fn = Nifti_slow
set top_dir = /media/data2/pinwei/SL_hippocampus
set bids_dir = $top_dir/$fn
if ( ! -d $bids_dir/derivatives/FreeSurfer ) mkdir $bids_dir/derivatives/FreeSurfer
set subjs_dir = $bids_dir/derivatives/FreeSurfer

foreach sid ( `count -digits 3 $1 $2` )
	recon-all -s sub-$sid					\
		-i $bids_dir/sub-$sid/anat/*T1w.nii.gz	\
		-T2 $bids_dir/sub-$sid/anat/*T2w.nii.gz	\
		-sd $subjs_dir					\
		-all

	# segmentHA_T1.sh sub-$sid $subjs_dir
	# segmentHA_T2.sh sub-$sid $subjs_dir/sub-$sid/mri/T2.norm.mgz T2 0 $subjs_dir
	segmentHA_T2.sh sub-$sid $subjs_dir/sub-$sid/mri/T2.norm.mgz T2+T1 1 $subjs_dir
	
end
