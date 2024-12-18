#!/usr/bin/tcsh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set mni = MNI152NLin2009cAsym

# echo "\n>> fMRIPrep output directory: \n\t(a.) no fmap \n\t(b.) fmap=RL"
# switch ( ${<} )
	# case a:
		# set prep = fmriprep
		# breaksw
	# case b:
		# set prep = fmriprep_fmap_RL
		# breaksw
# endsw
set prep = fmriprep_fmap_RL

if ( $#argv > 0 ) then
	set fun = "echo"
    set subjs = sub-$1
else
    set fun = "cat"
	set subjs = subjList.txt
endif

# tcsh HIDDEN_scripts/make_roimasks_aparc.sh $fun $subjs $mni $prep  
# tcsh HIDDEN_scripts/make_roimasks_BAexvivo.sh $fun $subjs $mni $prep  
# tcsh HIDDEN_scripts/make_roimasks_segHA.sh $fun $subjs $mni $prep  
# tcsh HIDDEN_scripts/make_roimasks_benson14.sh $fun $subjs $mni $prep  

tcsh HIDDEN_scripts/make_boldmask_resam_roimasks.sh $fun $subjs $mni $prep