#!/usr/bin/env tcsh

# tcsh Gen_PPI_ttest+ETAC_script.sh

set EXECUTE = yes

set ver = 6
set ss_ver = 'runs_MNI_3ord_v'$ver
set reml = '_REML' # ''

set roi_list = ( Hippocampus ) # ( 'HPC-head' 'HPC-body' 'HPC-tail' )

set cond_list = ( 'Fst' 'Snd' 'Trd' )
# set cond_list = ( 'ANY_stim_GLT' 'Fst_and_Snd_GLT' 'Snd_and_Trd_GLT' \
                  # 'Fst_vs_Snd_GLT' 'Trd_vs_Snd_GLT' 'Fst_vs_Trd_GLT' \
                  # 'Predicting_GLT' 'Predicted_GLT' 'Tpt_start_GLT' 'Tpl_end_GLT' )

set PREFIX = HIDDEN_scripts/do_3dttest++_${ss_ver}${reml}_PPI
set script_name = $PREFIX.sh

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain
set grp_mask = $grp_dir/group_mask+tlrc

set FOLDER = PPI

## start printing ========================================================================

echo '' > $script_name
echo 'set top_dir = /media/data2/pinwei/SL_hippocampus' >> $script_name
echo 'set grp_dir = ../derivatives/WholeBrain' >> $script_name 
echo 'set sdir_1 = $top_dir/Nifti/derivatives/afni_out/SS_results_'$ss_ver >> $script_name
echo 'set sdir_2 = $top_dir/Nifti_slow/derivatives/afni_out/SS_results_'$ss_ver >> $script_name

foreach run ( `seq -f '%02g' 2 9` )
	echo '' >> $script_name
	echo '# ================================ run-'$run' ================================' >> $script_name
	
	foreach roi ( ${roi_list[*]} )
		echo '' >> $script_name
		echo '## --------------------------- gfunc_'$roi' ---------------------------' >> $script_name
		echo '' >> $script_name
		echo 'set out_dir = $grp_dir/ap.'$ss_ver'/'$FOLDER'/run-'$run'/gfunc_'$roi >> $script_name	
		echo 'if ( ! -d $out_dir ) mkdir -p $out_dir ' >> $script_name
		
		set stats_file = PPI.gfunc_${roi}.stats${reml}+tlrc

		foreach cond ( ${cond_list[*]} )
			set cond_name = `echo ${cond:s/_GLT//}`	
			if ( $reml == '_REML' ) then
				set cond = $cond_name
			endif
			set out_name = ${cond}${reml}.ttest
			set cond = PPI.${cond} 
		
			echo '' >> $script_name
			echo '### '$cond':' >> $script_name
			echo '' >> $script_name
			echo '3dttest++ -overwrite \' >> $script_name
			echo '	-prefix $out_dir/'$out_name' \' >> $script_name
			echo '	-mask '$grp_mask' \' >> $script_name
			echo '	-setA '$cond' \' >> $script_name
			
			foreach subj ( `cat subjList_1.txt` )
				echo '		'$subj' "${sdir_1}/'$subj'_r'$run'.results/'$stats_file'['$cond'#0_Coef]" \' >> $script_name
			end
			
			foreach subj ( `cat subjList_2.txt` )
				echo '		'$subj' "${sdir_2}/'$subj'_r'$run'.results/'$stats_file'['$cond'#0_Coef]" \' >> $script_name
			end

			echo '	-CLUSTSIM \' >> $script_name
			echo '		-prefix_clustsim '$out_name' \' >> $script_name
			echo '	-ETAC \' >> $script_name
			echo '		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \' >> $script_name
			echo '		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  ' >> $script_name
			
			echo '' >> $script_name
			echo 'mv *'$out_name'* $out_dir' >> $script_name
		end
	end
end

## end printing ==========================================================================

set TODAY = `date +'%Y-%m-%d'`
mv $PREFIX.sh $PREFIX.${TODAY}.sh

if ( $EXECUTE == yes ) then
	tcsh $PREFIX.${TODAY}.sh
	cp $PREFIX.${TODAY}.sh $grp_dir/ap.${ss_ver}/$FOLDER
endif
