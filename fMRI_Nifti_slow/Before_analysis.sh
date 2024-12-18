#!/usr/bin/env tcsh
echo "### Reminder: Require input argument vector." 
echo ""

set bids_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
echo "BIDS directory:" $bids_dir

# echo "\n>> fMRIPrep output directory: \n\t(a.) orig \n\t(b.) fmap=RL"
# set pp_ver = $<
# switch ( $pp_ver )
	# case a:
		# set prep = fmriprep
	# case b:
		# set prep = fmriprep_fmap_RL
# endsw
set prep = fmriprep_fmap_RL
set prep_dir = $bids_dir/derivatives/$prep

# sudo chmod 777 -R $prep_dir

cd $prep_dir
rm subjList.txt
( ls -d sub-??? ) | sed "s|\/||g" > subjList.txt
cp ./subjList.txt $bids_dir/code

cd $bids_dir/code
# bash HIDDEN_scripts/bf.ana_blt+sort_folder.sh $1 $2 $prep_dir
# bash HIDDEN_scripts/bf.ana_make_timings.sh $1 $2 $prep_dir
# bash HIDDEN_scripts/bf.ana_make_timings.v3.sh $1 $2 $prep_dir
bash HIDDEN_scripts/bf.ana_make_stimfiles.sh $1 $2 $prep_dir
# bash HIDDEN_scripts/bf.ana_make_expo_timings.sh $1 $2 $prep_dir
# bash HIDDEN_scripts/bf.ana_modify_confounds.sh $1 $2 $prep_dir
