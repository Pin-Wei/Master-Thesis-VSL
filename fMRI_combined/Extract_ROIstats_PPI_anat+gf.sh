#!/usr/bin/env tcsh

# tcsh Extract_ROIstats_PPI_anat+gf.sh

set RE_DO = 0 # [0:False, 1:True]

set ver = 6
set afni_ver = 'runs_MNI_3ord_v'$ver
set reml = '_REML'  # ''
set glt = ''        # '_GLT'

set seed_list = ( Hippocampus ) # ( 'HPC-head' 'HPC-body' 'HPC-tail' ) 

set roi_ver = 'anat' # 'gfunc'
set roi_list = ( \
	'V1' 'V2' 'V1+2' 'V3' 'V1+2+3' 'LOC-V12' 'High-Vis' 'Inf_Temp' 'Fusiform' \
	'Pre_Central' 'Para_Central' 'Post_Central' 'Supra_Marginal'              \
	'Sup_Pari' 'Inf_Pari' 'Pre_Cuneus' 'Lingual' 'Peri_Calcarine' 'Cuneus'    \
	'Sup_Temp' 'Mid_Temp' 'Trans_Temp' 'PHC' 'PRC' 'ERC' 'Caudate' 'Putamen'  \
	'Insula' 'Post_Cingulate' 'Isth_Cingulate' \
	'hLOC+Fus+IT' 'MTL' )

set cond_list = ( 'PPI.Fst' 'PPI.Snd' 'PPI.Trd' 'PPI.ANY_stim'$glt )
set c_names = ( '_Fst' '_Snd' '_Trd' '_any.stim' )

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_out = $top_dir/Combined_group/derivatives

set run_list = ( `seq -f "%02g" 2 9` )
set output_types = ( 'maskave' 'maskave_tstats' )
set mni = MNI152NLin2009cAsym

## Main =========================================================================================

set roi_versions = ( 'anat' 'gfunc' )
echo "\n>> ROI version? [1] anat, [2] gfunc "
set roi_ver = ${roi_versions[$<]}

foreach seed ( ${seed_list[*]} )
	set stats_fn = PPI.gfunc_${seed}.stats${reml}+tlrc
	
	if ( $roi_ver == 'anat' ) then
		set out_folder = 'ROIstats'
	else
		set out_folder = 'ROIstats_gfunc'
	endif
	set out_dir = $grp_out/$out_folder/${afni_ver}'.PPI'${reml}/$seed # <-- output directory
	if ( ! -d $out_dir ) mkdir -p $out_dir

	foreach roi ( ${roi_list[*]} )
	
		switch ( $roi_ver ) 
			case 'anat':
				set roimask_fn = roimask_space-${mni}_${roi}_resam.nii.gz
				breaksw
			case 'gfunc':
				set roimask_fn = collapseAll__${roi}+tlrc
				breaksw
		endsw
		
		foreach x ( `seq 1 1 ${#cond_list}` )
			set cond = ${cond_list[$x]}
		
			foreach run ( ${run_list[*]} )
				set PREFIX = run-${run}_MNI_${roi}${c_names[$x]} # <-- output prefix
				
				foreach out_type ( ${output_types[*]} )
					switch ( $out_type ) 
						case 'maskave':
							set backup_dir = $out_dir/old_maskave
							set out_fn = ${PREFIX}_maskave
							breaksw
							
						case 'maskave_tstats':
							set backup_dir = $out_dir/old_maskave_t-val
							set out_fn = ${PREFIX}_maskave_t-val
							breaksw
					endsw
					
					if ( -f $out_dir/${out_fn}.txt )  then
						set subj_n = `awk '{print NR}' $out_dir/${out_fn}.txt | tail -n 1`
					else
						set subj_n = 0
					endif
					
					if (( -f $out_dir/${out_fn}.txt ) && ( $subj_n == 37 ) && ( $RE_DO == 0 )) then
						echo $out_fn' good exist, not required to overwrite, skip it!'
						
					else
						set INIT = 1 # <-- before the first subj 

						foreach task ( 'vsl' 'slowVSL' )
							switch ( $task )
								case vsl:
									set out_top = $top_dir/Nifti/derivatives
									set subj_list = `cat subjList_1.txt`
									breaksw
									
								case slowVSL:
									set out_top = $top_dir/Nifti_slow/derivatives
									set subj_list = `cat subjList_2.txt`
									breaksw
							endsw

							foreach subj ( ${subj_list[*]} )
								set stats_dir = $out_top/afni_out/SS_results_$afni_ver/${subj}_r${run}.results
								
								switch ( $roi_ver ) 
									case 'anat':
										set roimask_dir = $out_top/fmriprep_fmap_RL/$subj/anat/ROImasks
										breaksw
									case 'gfunc':
										set SIDE = '1pos'
										set FPR = '05perc'
										set roimask_dir = $grp_out/group_func_ROImasks/ap.${afni_ver}${reml}/ETAC_$SIDE.$FPR
										breaksw
								endsw
						
								## backup: 
								if (( -f $out_dir/${out_fn}.txt ) && ( $INIT == 1 )) then
								
									if ( -d $backup_dir ) then # If backup folder already exist
										rm -R $backup_dir      # remove older one
										echo '-- WARNING: older version of '$out_fn' exists, remove it --'
									endif

									if ( ! -d $backup_dir ) mkdir $backup_dir
									mv $out_dir/$out_fn* $backup_dir
									echo '.. WARNING: '$out_fn' exists, move it to folder "old"'
									
								endif
								
								## main: 
								switch ( $out_type ) 
									case 'maskave': # beta coefficients
										3dmaskave -q -mask $roimask_dir/$roimask_fn \
											$stats_dir/$stats_fn'['$cond'#0_Coef]'  \
												>> $out_dir/$out_fn.txt
										breaksw
										
									case 'maskave_tstats': # t-statistic
										3dmaskave -q -mask $roimask_dir/$roimask_fn \
											$stats_dir/$stats_fn'['$cond'#0_Tstat]' \
												>> $out_dir/$out_fn.txt
										breaksw
								endsw
								
								echo $subj',' `tail -n 1 $out_dir/$out_fn.txt` \
									>> $out_dir/$out_fn.csv
								
								set INIT = 0 # <-- one subj finished :-)
							end 
						end # <------------------- all subj finished :-))
					endif
				end	
			end				
		end					
	end
	echo ''
	echo '++ '$seed' Done ++'
	echo ''
end

echo ''
echo '+++ Well Done +++'
echo '\n+ Version: runs_MNI_3ord_v'${ver}${reml}
echo '\n+ seed list: '${seed_list[*]}
echo '\n+ ROI list:\n'${roi_list[*]}
echo ''
#!/usr/bin/env tcsh

# tcsh Extract_ROIstats_PPI_anat.sh

set RE_DO = 1 # [0:False, 1:True]

set afni_ver = 'runs_MNI_3ord_v6'
set reml = '_REML'  # ''
set glt = ''        # '_GLT'

set seed_list = ( 'HPC-head' 'HPC-body' 'HPC-tail' ) # ( Hippocampus )

set roi_ver = 'anat' # 'gfunc'
set roi_list = ( \
	'V1' 'V2' 'V1+2' 'V3' 'V1+2+3' 'LOC-V12' 'High-Vis' 'Inf_Temp' 'Fusiform' \
	'Pre_Central' 'Para_Central' 'Post_Central' 'Supra_Marginal'              \
	'Sup_Pari' 'Inf_Pari' 'Pre_Cuneus' 'Lingual' 'Peri_Calcarine' 'Cuneus'    \
	'Sup_Temp' 'Mid_Temp' 'Trans_Temp' 'PHC' 'PRC' 'ERC' 'Caudate' 'Putamen'  \
	'Insula' 'Post_Cingulate' 'Isth_Cingulate' )

set cond_list = ( 'PPI.Fst' 'PPI.Snd' 'PPI.Trd' 'PPI.ANY_stim'$glt )
set c_names = ( '_Fst' '_Snd' '_Trd' '_any.stim' )

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_out = $top_dir/Combined_group/derivatives

set run_list = ( `seq -f "%02g" 2 9` )
set output_types = ( 'maskave' 'maskave_tstats' )
set mni = MNI152NLin2009cAsym

## Main =========================================================================================

foreach seed ( ${seed_list[*]} )
	set stats_fn = PPI.gfunc_${seed}.stats${reml}+tlrc
	
	set out_dir = $grp_out/ROIstats/${afni_ver}'.PPI'${reml}/$seed # <-- output directory
	if ( ! -d $out_dir ) mkdir -p $out_dir

	foreach roi ( ${roi_list[*]} )
		switch
			case
				set roimask_fn = roimask_space-${mni}_${roi}_resam.nii.gz
			case	
				set roimask = $roimask_dir/${clust_mask_pfx}__${roi}

		foreach x ( `seq 1 1 ${#cond_list}` )
			set cond = ${cond_list[$x]}
		
			foreach run ( ${run_list[*]} )
				set PREFIX = run-${run}_MNI_${roi}${c_names[$x]} # <-- output prefix
				
				foreach out_type ( ${output_types[*]} )
					switch ( $out_type ) 
						case 'maskave':
							set backup_dir = $out_dir/old_maskave
							set out_fn = ${PREFIX}_maskave
							breaksw
							
						case 'maskave_tstats':
							set backup_dir = $out_dir/old_maskave_t-val
							set out_fn = ${PREFIX}_maskave_t-val
							breaksw
					endsw
					
					if ( -f $out_dir/${out_fn}.txt )  then
						set subj_n = `awk '{print NR}' $out_dir/${out_fn}.txt | tail -n 1`
					else
						set subj_n = 0
					endif
					
					if (( -f $out_dir/${out_fn}.txt ) && ( $subj_n == 37 ) && ( $RE_DO == 0 )) then
						echo $out_fn' good exist, not required to overwrite, skip it!'
						
					else
						set INIT = 1 # <-- before the first subj 

						foreach task ( 'vsl' 'slowVSL' )
							switch ( $task )
								case vsl:
									set out_top = $top_dir/Nifti/derivatives
									set subj_list = `cat subjList_1.txt`
									breaksw
									
								case slowVSL:
									set out_top = $top_dir/Nifti_slow/derivatives
									set subj_list = `cat subjList_2.txt`
									breaksw
							endsw

							foreach subj ( ${subj_list[*]} )
								set stats_dir = $out_top/afni_out/SS_results_$afni_ver/${subj}_r${run}.results
								set roimask_dir = $out_top/fmriprep_fmap_RL/$subj/anat/ROImasks
						
								## backup: 
								if (( -f $out_dir/${out_fn}.txt ) && ( $INIT == 1 )) then
								
									if ( -d $backup_dir ) then # If backup folder already exist
										rm -R $backup_dir      # remove older one
										echo '-- WARNING: older version of '$out_fn' exists, remove it --'
									endif

									if ( ! -d $backup_dir ) mkdir $backup_dir
									mv $out_dir/$out_fn* $backup_dir
									echo '.. WARNING: '$out_fn' exists, move it to folder "old"'
									
								endif
								
								## main: 
								switch ( $out_type ) 
									case 'maskave': # beta coefficients
										3dmaskave -q -mask $roimask_dir/$roimask_fn \
											$stats_dir/$stats_fn'['$cond'#0_Coef]'  \
												>> $out_dir/$out_fn.txt
										breaksw
										
									case 'maskave_tstats': # t-statistic
										3dmaskave -q -mask $roimask_dir/$roimask_fn \
											$stats_dir/$stats_fn'['$cond'#0_Tstat]' \
												>> $out_dir/$out_fn.txt
										breaksw
								endsw
								
								echo $subj',' `tail -n 1 $out_dir/$out_fn.txt` \
									>> $out_dir/$out_fn.csv
								
								set INIT = 0 # <-- one subj finished :-)
							end 
						end # <------------------- all subj finished :-))
					endif
				end	
			end				
		end					
	end
	echo ''
	echo '++ '$seed' Done ++'
	echo ''
end

echo ''
echo '+++ Well Done +++'
echo '\n+ Version: runs_MNI_3ord_v'${ver}${reml}
echo '\n+ seed list: '${seed_list[*]}
echo '\n+ ROI list:\n'${roi_list[*]}
echo ''
