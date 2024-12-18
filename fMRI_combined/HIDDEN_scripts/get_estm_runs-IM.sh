#!/usr/bin/bash

case $1 in
	vsl ) subj_list=`cat subjList_1.txt` ;;
	slowVSL ) subj_list=`cat subjList_2.txt` ;;
esac

afni_dir=$2
ss_ver=`basename $afni_dir | sed 's/SS_results_//g'`

script_dir=$3

run_list=`seq -f "%02g" 1 10`
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ) 

attr_fn='all-stim_attrs.txt'
tpl_attr_fn='all-stim_Triplets_attrs.txt'

for reml in '' '_REML' ; do
	for estm in 'Betas' 'Tstats' ; do
	
		out_fn='all-stim_all'${estm}${reml}'.nii'
			# all-stim_allBetas.nii
			# all-stim_allBetas_REML.nii
			# all-stim_allTstats.nii
			# all-stim_allTstats_REML.nii
			
		script_name='extract_'${ss_ver}'_IM_'${estm}${reml}'_script.sh'
		script_file=$script_dir/$script_name
		
		if [ -f $script_file ]; then rm $script_file; fi
		echo '#!/bin/bash' >> $script_file
		echo >> $script_file
		echo 'afni_dir='$afni_dir >> $script_file
		echo >> $script_file
		
		## ======================================================================================
		
		for subj in ${subj_list[*]} ; do
			echo '#' $subj >> $script_file
		
			for run in ${run_list[*]} ; do
				echo 'stats_dir=$afni_dir/'${subj}'_r'${run}'.results' >> $script_file
				
				stats_dir=$afni_dir/${subj}_r${run}.results
				stats_fn='stats.'${subj}${reml}'+orig'
				
				echo `3dinfo -label -sb_delim "," $stats_dir/$stats_fn` | tr "," "\n" \
					> $stats_dir/stats.subbrick_labels.1D				
				
				case $estm in
					'Betas' ) keyword='_Coef' ;;
					'Tstats' ) keyword='_Tstat' ;;
				esac

				## Extract sub-bricks values: ---------------------------------------------------
				raw_indexs=( \
					`grep -n $keyword $stats_dir/stats.subbrick_labels.1D | cut -d ":" -f1` \
				)
				subbrick_indexs='None'
				for index in ${raw_indexs[*]} ; do
					idx=`expr $index - 1`
					if [ $subbrick_indexs == 'None' ]; then
						subbrick_indexs=$idx
					else
						subbrick_indexs=$subbrick_indexs','$idx
					fi
				done
				
				echo '3dTcat -overwrite \' >> $script_file
				echo '	-prefix $stats_dir/'$out_fn' \' >> $script_file
				echo '	$stats_dir/'$stats_fn"'["$subbrick_indexs"]'" >> $script_file
				echo >> $script_file
					
				## Save attribute file of 12 shapes: --------------------------------------------
				# if [ -f $stats_dir/$attr_fn ]; then rm $stats_dir/$attr_fn ; fi
				
				grep $keyword $stats_dir/stats.subbrick_labels.1D |    \
					cut -d "#" -f1 |                                   \
					awk -v run=$run '{ printf "%s\t%02d\n", $1, run }' \
						> $stats_dir/$attr_fn
				
				## Save attribute file of 4 triplets: -------------------------------------------
				# if [ -f $stats_dir/$tpl_attr_fn ]; then rm $stats_dir/$tpl_attr_fn ; fi
				
				grep $keyword $stats_dir/stats.subbrick_labels.1D |    \
					cut -d "#" -f1 | sed 's/[0-9]//g' |                \
					awk -v run=$run '{ printf "%s\t%02d\n", $1, run }' \
						> $stats_dir/$tpl_attr_fn				
			done
		done
		
		## =====================================================================================
		bash $script_file
	done
done