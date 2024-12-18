#!/usr/bin/tcsh -xef

docker run -it --rm \
	-v /media/data2/pinwei/SL_hippocampus/Nifti_slow:/bids \
	-v /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/HippUnfold:/output \
	khanlab/hippunfold:v1.3.3 /bids /output participant \
	--modality T2w --t1-reg-template \
	--output-spaces native T1w \
	--cores all -p
