#!/usr/bin/env tcsh

# tcsh Make_ttest+ETAC_collapsed_mask.sh

echo "\n>> What version? (runs_MNI_3ord_v?) "
set ver = $<
set afni_ver = 'runs_MNI_3ord_v'$ver

set reml_options = ( '_REML' '' ) 
echo "\n>> REML? [1] Yes, [2] No "
set reml = ${reml_options[$<]}

echo "\n>> PPI? [1] Yes, [2] No "
set ppi = $<

set cond_todo_list = ( 'All' 'Fst' 'Snd' 'Trd' )
# set cond_todo_list = ( 'ANY_stim' 'Predicting' 'Predicted' 'Tpt_start' 'Tpl_end' \
                       # 'Fst_vs_Snd' 'Trd_vs_Snd' 'Fst_vs_Trd' )

set NAME = 'ttest.1sided'
set SIDE = '1pos'
set FPR = '05perc'

# set NAME = 'ttest.2sided'
# set SIDE = '2sid'
# set FPR = '05perc'

set do_addition = 0 # 1==True
set atlas = 'FS.afni.MNI2009c_asym'

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain

if ( $ppi == 1 ) then
	set out_top = $grp_dir/ap.$ss_ver/PPI
	set seed_list = ( 'gfunc_HPC-head' 'gfunc_HPC-body' 'gfunc_HPC-tail' )
else
	set out_top = $grp_dir/ap.$ss_ver/ClustSim+ETAC
endif

## Main =========================================================================================
if ( $ppi == 1 ) then
	set count = ${#seed_list}
else
	set count = 1
endif

while ( $count > 0 )
	###
	if ( $ppi == 1 ) then
		set out_dir = $out_top/Together/${seed_list[$count]}
	else
		set out_dir = $out_top/Together
	endif
	if ( ! -d $out_dir ) mkdir -p $out_dir
	
	foreach cond_todo ( ${cond_todo_list[*]} )

		if ( $cond_todo == 'All' ) then
			set cond_list = ( 'Fst' 'Snd' 'Trd' )
			set FILEAME = 'collapseAll'${reml}'_'${SIDE}.${FPR} # merge across runs & conds
		else
			set cond_list = ( $cond_todo )
			set FILEAME = 'collapseRuns_'${cond_todo}${reml}'_'${SIDE}.${FPR} # merge across runs
		endif
		
		set file_list = () # Initialize
		
		foreach run ( `seq -f "run-%02g" 2 9` )
			###
			if ( $ppi == 1 ) then
				set data_dir = $out_top/$run/${seed_list[$count]}
			else
				set data_dir = $out_top/$run
			endif
			
			foreach cond ( ${cond_list[*]} )	
				set PREFIX = ${cond}${reml}	
				
				set file_list = ( ${file_list[*]} \
					$data_dir/${PREFIX}.${NAME}.ETACmask.global.${SIDE}.${FPR}.nii.gz )
			end	
		end

		3dmask_tool -overwrite \
			-input ${file_list[*]} -union \
			-prefix $out_dir/$FILEAME
			
		if ( `3dBrickStat -count -positive $out_dir/${FILEAME}+tlrc` == 0 ) then
			rm $out_dir/${FILEAME}+tlrc.*

		else
			3dmask_tool -overwrite \
				-input ${file_list[*]} -union -fill_holes \
				-prefix $out_dir/${FILEAME}_filled
		endif

		set template = 'MNI152NLin2009cAsym_T1'
		if ( ! -f $out_dir/${template}.nii ) cp $grp_dir/${template}* $out_dir

		## Additional ===================================================================================
		
		if ( $do_addition == 1 ) then

			set cluster_mask = $out_dir/${FILEAME}+tlrc
			if ( ! -d $out_dir/$atlas ) mkdir $out_dir/$atlas

			## Report overlaps per ROI: ---------------------------------------------------------------------

			set whereami_report = $out_dir/$atlas/${FILEAME}_whereami.csv

			if ( ! -f $whereami_report ) then
				echo "overlap_with_ROI,ROI,ROI_index" > $whereami_report
				whereami \
					-omask $cluster_mask -atlas $atlas -tab | \
						grep "% overlap"                    | \
						sed "s/\s\s%\soverlap\swith/%,/g"   | \
						sed "s/code\s//g"                   | \
						cut -d "," -f 1-3 >> $whereami_report
			endif

			## Overlap with (resampled) atlas file: ---------------------------------------------------------

			set Atlas_file = $out_dir/$atlas/Atlas_resampled

			if ( ! -f ${Atlas_file}+tlrc.HEAD ) then
				3dresample -input "/usr/local/abin/${atlas}.nii.gz" \
					-master $cluster_mask \
					-prefix $Atlas_file 
			endif

			set ROI_overlap_file = $out_dir/$atlas/${FILEAME}_ROImask

			if ( ! -f ${ROI_overlap_file}+tlrc.HEAD ) then
				3dcalc -a $cluster_mask   \
					-b ${Atlas_file}+tlrc \
					-expr 'step(a)*b'     \
					-prefix $ROI_overlap_file
			endif

			#  3dBrickStat -count -positive '3dcalc( -a Atlas_resampled+tlrc -expr iszero(a-$roi_index) )'
			
			## Count number of voxels per ROI: --------------------------------------------------------------

			set Voxel_count_file = $out_dir/$atlas/${FILEAME}_ROIcode_NZcount.tsv

			if ( ! -f $Voxel_count_file ) then
				3dROIstats -mask ${ROI_overlap_file}+tlrc \
					-nzvoxels -nomeanout $cluster_mask > delete.me.00.tsv
					
				awk 'NR==1 {for (i=3; i<=NF; i++) print $i}' delete.me.00.tsv | \
					sed 's/NZcount_//g' > delete.me.01.txt
					
				awk 'NR==2 {for (i=3; i<=NF; i++) print $i}' delete.me.00.tsv > delete.me.02.txt

				paste delete.me.01.txt delete.me.02.txt > delete.me.03.txt
				
				echo "ROI_index\tN_Voxels" > $Voxel_count_file
				cat delete.me.03.txt >> $Voxel_count_file

				rm delete.me.*
			endif

			## Atlas code table: ----------------------------------------------------------------------------

			set code_table = $out_dir/$atlas/Atlas_code.tsv

			if ( ! -f $code_table ) then
				whereami -atlas $atlas -show_atlas_code | \
					cut -d ":" -f 2-3 | grep ":[0-9]" | sed 's/[:]/\t/g' \
						> $code_table	
			endif
		endif
	end
	
	set count = `expr $count - 1`
end