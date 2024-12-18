#!/usr/bin/tcsh -xef

# tcsh Count_ROImasks_voxels.sh

set mni = MNI152NLin2009cAsym
set prep = fmriprep_fmap_RL

set grp_top = /media/data2/pinwei/SL_hippocampus/Combined_group

set outfile_group = ROI_sizes_resam_group.csv
echo 'ROI, Voxels' > $outfile_group 
set outfile_mni = ROI_sizes_resam_mni.csv
echo 'Subj, ROI, Voxels' > $outfile_mni
set outfile_T1w = ROI_sizes_resam_T1w.csv
echo 'Subj, ROI, Voxels' > $outfile_T1w

foreach roi ( `cat roiList.txt` )
	## group merged:
	set roimask_dir = $grp_top/derivatives/group_ROImasks
	
	# set in_file = $roimask_dir/group-roimask_${roi}_resam+tlrc
	set in_file = $roimask_dir/group-roimask_${roi}_resam.nii.gz
	
	echo $roi', '`3dBrickStat -count -positive $in_file` >> $outfile_group 

	# each persion:
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
			
			foreach space ( T1w $mni )
				switch ( $space )
					case T1w:
						set suffix = '+orig'
						set OUTFILE = $outfile_T1w
						breaksw
					case $mni:
						set suffix = '+tlrc'
						set OUTFILE = $outfile_mni
						breaksw
				endsw
				
				# set in_file = $roimask_dir/roimask_space-${space}_${roi}_resam${suffix}
				set in_file = $roimask_dir/roimask_space-${space}_${roi}_resam.nii.gz
				
				echo $subj', '$roi', '`3dBrickStat -count -positive $in_file` >> $OUTFILE 
			end
		end
	end
end
