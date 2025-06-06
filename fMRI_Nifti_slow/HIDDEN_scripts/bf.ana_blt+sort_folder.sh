#!/bin/bash

orig_dir=`pwd`
cd $3

for sid in `seq -f "%03g" $1 $2`; do

	cd sub-$sid/func;
	
	if [ ! -d Masks ]; then mkdir Masks; mv *desc-brain_mask* Masks; fi
	if [ ! -d MNI_space ]; then mkdir MNI_space; mv *space-MNI* MNI_space; fi
	if [ ! -d T1_space ]; then mkdir T1_space; mv *space-T1* T1_space; fi
	if [ ! -d Confounds ]; then mkdir Confounds; mv *desc-confounds_timeseries* Confounds; fi
	if [ ! -d Transforms ]; then mkdir Transforms; mv *from* Transforms; fi
	if [ ! -d Timings ]; then mkdir Timings; fi
	
	cd ../..
done

cd $orig_dir
