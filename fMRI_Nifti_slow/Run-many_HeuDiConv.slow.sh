#!/bin/bash

# modify the “heuristic.py” file based on the ”dicominfo.tsv” file first:

for id in `seq -f "%03g" $1 $2`; do
	docker run --rm -it -v /media/data2/pinwei/SL_hippocampus:/base	\
		nipy/heudiconv:latest 						\
		-d /base/Dicom_slow/PW{subject}/*/*.IMA 			\
		-o /base/Nifti_slow/ 						\
		-f /base/Nifti_slow/code/heuristic.py				\
		-s ${id} 							\
		-c dcm2niix							\
		-b --overwrite;

done
