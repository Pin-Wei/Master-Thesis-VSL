#!/bin/bash

fs_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/FreeSurfer

for id in `seq -f "%03g" $1 $2`; do
	docker run --rm -it -v $fs_dir:/subjects		\
		nben/neuropythy:latest benson14_retinotopy	\
		--verbose --surf-format=mgz sub-${id}

done

#docker run -it --rm -v /$fs_dir:/subjects				\
#	nben/neuropythy:latest						\
#	register_retinotopy sub-${id}					\
#	--verbose							\
#	--surf-outdir=/subjects/sub-${id}/prfs			\
#	--surf-format="mgz"						\
#	--vol-outdir=/subjects/sub-${id}/prfs				\
#	--vol-format="mgz"						\
#	--lh-angle=/subjects/sub-${id}/prfs/lh.meas_angle.mgz	\
#	--lh-eccen=/subjects/sub-${id}/prfs/lh.meas_eccen.mgz	\
#	--lh-radius=/subjects/sub-${id}/prfs/lh.meas_sigma.mgz	\
#	--lh-weight=/subjects/sub-${id}/prfs/lh.meas_vexpl.mgz	\
#	--rh-angle=/subjects/sub-${id}/prfs/rh.meas_angle.mgz	\
#	--rh-eccen=/subjects/sub-${id}/prfs/rh.meas_eccen.mgz	\
#	--rh-radius=/subjects/sub-${id}/prfs/rh.meas_sigma.mgz	\
#	--rh-weight=/subjects/sub-${id}/prfs/rh.meas_vexpl.mgz
