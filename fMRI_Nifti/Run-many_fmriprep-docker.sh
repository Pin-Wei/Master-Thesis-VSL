#!/usr/bin/tcsh -xef

echo "\n>> fmap direction: \n\t(a.) dir=LR \n\t(b.) dir=RL"
switch ( ${<} )
	case a:
		set dir = LR
		breaksw
	case b:
		set dir = RL
		breaksw
endsw

python HIDDEN_scripts/to-UNapply_fmap-${dir}.py
python HIDDEN_scripts/to-apply_fmap-${dir}.py

set TEMPLATEFLOW_HOME = /var/local/templateflow

foreach sid ( `count -digit 2 $1 $2` )
	fmriprep-docker					\
	   ../ ../derivatives/fmriprep_fmap_${dir} participant	\
	   --participant-label $sid				\
	   --skip_bids_validation				\
	   --output-spaces T1w MNI152NLin2009cAsym $TEMPLATEFLOW_HOME/tpl-MNI152NLin2009cSym \
	   --fs-license-file freesurfer_license.txt		\
	   --fs-subjects-dir ../derivatives/FreeSurfer	\
	   --force-syn						\
	   --nthreads 10					\
	   --omp-nthreads 10					\
	   --stop-on-first-crash				\
	   --mem_mb 64						\
	   -w ../../work/					\
	   -v

end
