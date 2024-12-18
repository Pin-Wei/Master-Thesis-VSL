#!/usr/bin/tcsh

set current_dir = `pwd`
set sfx = 'runs_v5'
set space = T1w
set stims = ( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
set model = 'GAM'

echo "\n>> Which dataset, [a] rapid, [b] slow, or [c] both?"
set ver = $<
if ( $ver == a ) set todo_list = ( vsl )
if ( $ver == b ) set todo_list = ( slowVSL )
if ( $ver == c ) set todo_list = ( vsl slowVSL )

foreach gname ( ${todo_list[*]} )
	cd $current_dir
	switch ( $gname )
		case vsl:
			set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
			set subj_list = `cat subjList_1.txt`
			breaksw
		case slowVSL:
			set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
			set subj_list = `cat subjList_2.txt`
			breaksw
	endsw

	foreach subj ( $subj_list )
		foreach run ( `seq -f "%02g" 01 1 10` )
			if ( ( ($gname == 'slowVSL') && ( $run == '01' || $run == '10' ) ) ) set model = 'GAM(8.6,.547,3)'

			set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
			set anat_dir = $prep_dir/$subj/anat
			set mask_dir = $prep_dir/$subj/func/Masks
			set epi_dir  = $prep_dir/$subj/func/T1_space
			set stim_dir = $prep_dir/$subj/func/Timings
			set conf_dir = $prep_dir/$subj/func/Confounds
			
			set afni_dir = $top_dir/derivatives/afni_out
			set stats_dir = $afni_dir/SS_results_${sfx}/${subj}_r${run}.results
			if ( ! -d $stats_dir ) mkdir -p $stats_dir
			
			cd $stats_dir
			mkdir stimuli
			# copy stim files into stimulus directory (times offset by 1 s)
			foreach stim ( ${stims[*]} )
				timing_tool.py -add_offset 1 -timing \
					$stim_dir/${stim}_run-${run}.1D  \
					-write_timing stimuli/offset_${stim}_run-${run}.1D
			end
			# copy external ortvec files into stimuli dir
			cp $conf_dir/csf+wm_run-${run}.1D           \
			   ${stim_dir}_2/stim-targets_run-${run}.1D \
			   stimuli
			   
			# copy anatomy to results dir
			3dcopy $anat_dir/${subj}_desc-preproc_T1w+orig .

			# copy external motion file into results dir
			cp $conf_dir/head-motion_run-${run}.1D .
			
			# censoring motion 
			1d_tool.py -infile head-motion_run-${run}.1D -set_nruns 1 \
				-show_censor_count -censor_prev_TR                    \
				-censor_motion 0.3 motion_${subj}
				
			# copy any -mask_import datasets as mask_import_LABEL
			3dcopy $mask_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-brain_mask.nii.gz \
				./mask_import_BRAIN_MASK
			
			# apply 3dTcat to copy input dsets to results dir, while removing the first 0 TRs	
			3dTcat -prefix pb00.$subj.r01.tcat \
				$epi_dir/${subj}_task-${gname}_run-${run}_space-${space}_desc-preproc_bold+orig.HEAD
			 
			# censor outlier TRs
			3dToutcount -automask -fraction -polort 3 -legendre \
                pb00.$subj.r01.tcat+orig > outcount.r01.1D
			1deval -a outcount.r01.1D \
				-expr "1-step(a-0.15)" > outcount_${subj}_censor.1D
				
			# scale each voxel time series to have a mean of 100
			3dTstat -prefix rm.mean_r01 pb00.$subj.r01.tcat+orig
			3dcalc -a pb00.$subj.r01.tcat+orig -b rm.mean_r01+orig \
				   -expr 'min(200, a/b*100)*step(a)*step(b)'       \
				   -prefix pb01.$subj.r01.scale			

			# blur + scale:
			# 3dBlurInMask -preserve -FWHM 4.0 \
                 # -prefix pb01.$subj.r01.blur \
                 # pb00.$subj.r01.tcat+orig
			# 3dTstat -prefix rm.mean_r01 pb01.$subj.r01.blur+orig
			# 3dcalc -a pb01.$subj.r01.blur+orig -b rm.mean_r01+orig \
				   # -expr 'min(200, a/b*100)*step(a)*step(b)'       \
				   # -prefix pb02.$subj.r01.scale
			
			# combine multiple censor files
			1deval -a motion_${subj}_censor.1D -b outcount_${subj}_censor.1D \
				   -expr "a*b" > censor_${subj}_combined_2.1D
					
			set input_fn = pb01.$subj.r01.scale+orig.HEAD
			
			foreach i ( `count -digit 1 1 12` )
				3dDeconvolve -verb -overwrite											\
					-input $input_fn									                \
					-censor censor_${subj}_combined_2.1D								\
					-ortvec stimuli/csf+wm_run-${run}.1D CSF_WM							\
					-ortvec stimuli/stim-targets_run-${run}.1D task_targ                \
					-ortvec head-motion_run-${run}.1D mot_basic							\
					-polort 3 -float													\
					-num_stimts 12														\
					-stim_times_IM 1 stimuli/offset_${stims[1]}_run-${run}.1D $model	\
					-stim_label 1 ${stims[1]}											\
						-stim_times 2 stimuli/offset_${stims[2]}_run-${run}.1D $model	\
						-stim_label 2 ${stims[2]}										\
						-stim_times 3 stimuli/offset_${stims[3]}_run-${run}.1D $model	\
						-stim_label 3 ${stims[3]}										\
						-stim_times 4 stimuli/offset_${stims[4]}_run-${run}.1D $model	\
						-stim_label 4 ${stims[4]}										\
						-stim_times 5 stimuli/offset_${stims[5]}_run-${run}.1D $model	\
						-stim_label 5 ${stims[5]}										\
						-stim_times 6 stimuli/offset_${stims[6]}_run-${run}.1D $model	\
						-stim_label 6 ${stims[6]}										\
						-stim_times 7 stimuli/offset_${stims[7]}_run-${run}.1D $model	\
						-stim_label 7 ${stims[7]}										\
						-stim_times 8 stimuli/offset_${stims[8]}_run-${run}.1D $model	\
						-stim_label 8 ${stims[8]}										\
						-stim_times 9 stimuli/offset_${stims[9]}_run-${run}.1D $model	\
						-stim_label 9 ${stims[9]}										\
						-stim_times 10 stimuli/offset_${stims[10]}_run-${run}.1D $model	\
						-stim_label 10 ${stims[10]}										\
						-stim_times 11 stimuli/offset_${stims[11]}_run-${run}.1D $model	\
						-stim_label 11 ${stims[11]}										\
						-stim_times 12 stimuli/offset_${stims[12]}_run-${run}.1D $model	\
						-stim_label 12 ${stims[12]}										\
					-x1D xmat.stim-${stims[1]}.1D										\
					-xjpeg X.stim-${stims[1]}.jpg										\
					-x1D_stop # just using 3dDeconvolve to set up the matrix file
				
				3dLSS -verb -overwrite					\
					-matrix xmat.stim-${stims[1]}.1D	\
					-input $input_fn 					\
					-mask $mask_dir/${subj}_task-${gname}_run-${run}_space-T1w_desc-brain_mask.nii.gz \
					-prefix LSS.stim-${stims[1]}		\
					-save1D LSS.stim-${stims[1]}.1D
				
				set tmp = ${stims[1]}
				shift stims
				set stims = ( $stims $tmp )
			end
		end	
	end
end