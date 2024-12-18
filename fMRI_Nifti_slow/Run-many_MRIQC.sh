#!/usr/bin/tcsh -xef
# tcsh Run-many_MRIQC.sh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set out_dir = $top_dir/derivatives/MRIQC

# foreach sid ( 101 102 `seq -f "%03g" 104 127` )
foreach sid ( `seq -f "%03g" 118 127` )
	docker run -it --rm 		\
		-v ${top_dir}:/data:ro 	\
		-v ${out_dir}:/out 		\
		nipreps/mriqc:22.0.1 /data /out participant \
		--participant-label $sid
end

docker run -it --rm 		\
	-v ${top_dir}:/data:ro 	\
	-v ${out_dir}:/out 		\
	nipreps/mriqc:22.0.1 /data /out group
	
# docker run -it --rm 		\
	# -v ${top_dir}:/data:ro 	\
	# -v ${out_dir}:/out 		\
	# nipreps/mriqc:22.0.1 /data /out participant 
	
# # If the argument --participant_label is not provided, then all subjects 
# # will be processed and the group level analysis will automatically be executed 
# # without need of running the command in item 3.
	
