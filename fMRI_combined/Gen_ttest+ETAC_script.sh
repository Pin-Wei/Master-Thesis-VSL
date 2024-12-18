#!/usr/bin/env tcsh
# tcsh Gen_ttest+ETAC_script.sh

# Wait for exploration: -ETAC_blur

set EXECUTE = yes

set ver = 7
set ss_ver = 'runs_MNI_3ord_v'$ver
set reml = '_REML' # ''

set cond_list = ( 'Fst' 'Snd' 'Trd' \
	'ANY_stim_GLT' 'Fst_and_Snd_GLT' 'Snd_and_Trd_GLT' \
	'Fst_vs_Snd_GLT' 'Trd_vs_Snd_GLT' 'Fst_vs_Trd_GLT' \
	'Predicting_GLT' 'Predicted_GLT' 'Tpt_start_GLT' 'Tpl_end_GLT' )
# v5: ( 'Fst' 'Snd' 'Trd' 'Any_stim_GLT' 'Fst_vs_Snd_GLT' 'Trd_vs_Snd_GLT' 'Fst_vs_Trd_GLT' 'Fst_and_Snd_GLT' 'Snd_and_Trd_GLT' )

set etac = '+ETAC' # ''
set PREFIX = HIDDEN_scripts/do_3dttest++_${ss_ver}${reml}${etac}
set script_name = $PREFIX.sh

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain
set grp_mask = $grp_dir/group_mask+tlrc

## start printing ========================================================================

echo '' > $script_name
echo 'set top_dir = /media/data2/pinwei/SL_hippocampus' >> $script_name
echo 'set grp_dir = ../derivatives/WholeBrain' >> $script_name 
	# ** Cannot use -Clustsim when -prefix has an absolute path **
echo 'set sdir_1 = $top_dir/Nifti/derivatives/afni_out/SS_results_'$ss_ver >> $script_name
echo 'set sdir_2 = $top_dir/Nifti_slow/derivatives/afni_out/SS_results_'$ss_ver >> $script_name

# foreach run ( `seq -f '%02g' 01 1 10` )
foreach run ( `seq -f '%02g' 2 9` )

	echo '' >> $script_name
	echo '# ================================ run-'$run' ================================' >> $script_name
	set results = '_r'$run'.results'
	
	if ( $etac == '+ETAC' ) then
		echo 'set out_dir = $grp_dir/ap.'${ss_ver}'/ClustSim+ETAC/run-'$run >> $script_name	
	else
		echo 'set out_dir = $grp_dir/ap.'${ss_ver}'/run-'$run >> $script_name
	endif
	echo 'if ( ! -d $out_dir ) mkdir -p $out_dir ' >> $script_name

	foreach cond ( ${cond_list[*]} )
		echo '' >> $script_name
		echo '## ------------------------------ '$cond' --------------------------------' >> $script_name
		set out_name = `echo ${cond:s/_GLT//}`	
		
		if ( $reml == '_REML' ) then
			set cond = $out_name
		endif
		
		## Oridinary 3dttest++ ------------------------------------------------------------
		
		echo '3dttest++ -overwrite \' >> $script_name
		echo '	-prefix $out_dir/'${out_name}${reml}'.ttest \' >> $script_name
		echo '	-mask '$grp_mask' \' >> $script_name
		echo '	-setA '$cond' \' >> $script_name
		
		foreach subj ( `cat subjList_1.txt` )
			echo '		'$subj' "${sdir_1}/'${subj}${results}'/stats.'${subj}${reml}'+tlrc['$cond'#0_Coef]" \' >> $script_name
		end
		foreach subj ( `cat subjList_2.txt` )
			if (( $etac == '' ) && ( $subj == 'sub-127' )) then
				set end_dash = ''
			else
				set end_dash = ' \'
			endif
			echo '		'$subj' "${sdir_2}/'${subj}${results}'/stats.'${subj}${reml}'+tlrc['$cond'#0_Coef]"'$end_dash >> $script_name
		end
		
		## Add ETAC option(s) -------------------------------------------------------------
		
		if ( $etac == '+ETAC' ) then
			echo '	-CLUSTSIM -ETAC \' >> $script_name
			echo '	-prefix_clustsim '${out_name}${reml}'.ttest \' >> $script_name
			echo '	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \' >> $script_name
			echo '	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  ' >> $script_name
			
			echo '' >> $script_name
			echo 'mv *'${out_name}${reml}'.ttest* $out_dir' >> $script_name
		endif
	end
end

## end printing ==========================================================================

set TODAY = `date +'%Y-%m-%d'`
mv $PREFIX.sh $PREFIX.${TODAY}.sh

if ( $EXECUTE == yes ) then
	tcsh $PREFIX.${TODAY}.sh
	cp $PREFIX.${TODAY}.sh $grp_dir/ap.${ss_ver}/ClustSim+ETAC
endif

## Notes for -ETAC outputs ===============================================================
## ~1~ A binary mask (main result):
## *** The output from global ETAC is a binary mask file 
##     indicating which voxels survived the multi-thresholding process.
## *** The name of such a file follows the format:
##   * {PREFIX}.{NAME}.ETACmask.global.{SIDE}.{FPR}.nii.gz
##     - {PREFIX} is from'-prefix' or '-prefix_clustsim'
##     - {NAME} is the name given in '-ETAC_opt'
##     - {SIDE} is '1pos' and '1neg' if 1-sided testing was ordered in '-ETAC_opt',
##              or is '2sid' if 2-sided testing was ordered.
##     - {FPR} is the false positive rate (e.g., '5perc')
## *** It is very possible that this output mask will be all zero, indicating that nothing survived. 
## 	** A quick way to see how many voxels made it through the ETAC process:
##      3dBrickStat -non-zero -count MaskDatasetName.nii.gz
##     This command will print (to stdout) a single integer of the count of non-zero voxels in this mask dataset.

## ~2~ which tests 'passed' in each voxel: 
##   * {PREFIX}.{NAME}.ETACmaskALL.global.{SIDE}.{FPR}.nii.gz
## *** This dataset marks each voxel with the set of tests that were passed there
##     therefore, has 1 binary volume for each thresholding sub-test 
##     (i.e., number of p-thresholds times number of blur levels)
					  
## ~3~ the actual output thresholds stored in text files (using an XML format):
##   * globalETAC.mthresh.{PREFIX}.{NAME}.ETAC.{LEVEL}.{FPR}.niml
##     - {LEVEL} is the blur level name (e.g., 'B8.0')
## *** The multiple thresholds are available 
##     as a column of numbers in the single XML element in this file.
## *** If multiple blur levels are used, 
##     there will be one such file for each blur level.