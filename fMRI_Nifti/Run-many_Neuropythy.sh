#!/bin/bash

for id in `seq -f "%02g" $1 $2`; do
	docker run --rm -it -v /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/FreeSurfer:/subjects \
		nben/neuropythy:latest benson14_retinotopy \
		--verbose --surf-format=mgz sub-${id}

done

    
