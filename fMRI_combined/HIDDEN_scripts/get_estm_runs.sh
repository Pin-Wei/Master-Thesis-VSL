#!/usr/bin/bash

case $1 in
	vsl ) subj_list=`cat subjList_1.txt` ;;
	slowVSL ) subj_list=`cat subjList_2.txt` ;;
esac

afni_dir=$2
stat_pfx=$3
attr_fn='Attrs.txt'

run_list=`seq -f "%02g" 1 10`
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ) 

for subj in ${subj_list[*]} ; do
	for run in ${run_list[*]} ; do
	
		stats_dir=$afni_dir/${subj}_r${run}.results
		stim_dir=$stats_dir/stimuli
		attr_file=$stats_dir/$attr_fn
		
		# write attribute file:
		if [ -f $attr_file ]; then rm $attr_file ; fi
		
		for cond in ${cond_list[*]} ; do
			echo $cond $run >> $attr_file
		done
		
		for estm in 'Betas' 'Tstats' ; do
			for reml in '' '_REML'; do
			
				stats_fn=${stat_pfx}'stats.'${subj}${reml}'+orig'
				out_fn='all'${estm}${reml}'.nii'
					# allBetas.nii
					# allBetas_REML.nii
					# allTstats.nii
					# allTstats_REML.nii
					
				case $estm in
					Betas ) 
						3dTcat -overwrite \
							-prefix $stats_dir/$out_fn $stats_dir/$stats_fn'[1-35(3)]'					
						;;
					Tstats ) 
						3dTcat -overwrite \
							-prefix $stats_dir/$out_fn $stats_dir/$stats_fn'[2-35(3)]'	
						;;
				esac
			done
		done
	done
done