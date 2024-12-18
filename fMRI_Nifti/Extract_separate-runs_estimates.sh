#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

# ss_ver=runs
# ss_ver=runs_v2
# ss_ver=runs+behav
ss_ver=$1
cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
# reml=''
reml='_REML'

for est_type in 'Betas' 'Tstats'; do

	out_file=HIDDEN_scripts/extract_single-runs-trial_${est_type}${reml}_script.sh ###
	if [ -f $out_file ]; then rm $out_file; fi

	echo '#!/bin/bash' >> $out_file
	echo >> $out_file
	echo 'afni_dir='$afni_dir >> $out_file
	echo >> $out_file

	for subj in `cat subjList.txt`; do

		for run in `seq -f "%02g" 1 10` ; do ###
			stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}_r${run}.results
			stim_dir=$stats_dir/stimuli
			echo '#' $subj >> $out_file
			echo 'stats_dir=$afni_dir/SS_results_'${ss_ver}'/'${subj}'_r'${run}'.results' >> $out_file
			
			attr_file=$stats_dir/all-stim_attrs.txt
			if [ -f $attr_file ]; then rm $attr_file ; fi
			attr_file_2=$stats_dir/all-stim_Triplets_attrs.txt ###
			if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi
			
			case ${est_type} in
				Betas ) tmp_2=-1 ;;
				Tstats ) tmp_2=0 ;;
			esac
			
			for cond in ${cond_list[*]} ; do
				tmp_1=`expr ${tmp_2} + 2`
				eval ${cond}_1=$tmp_1	## start sub-brick of the current condition 
				
				subb_n=`cat $stim_dir/offset_${cond}_run-${run}.1D | wc -w`
				tmp_2=`expr ${subb_n} \* 2 + ${tmp_1} - 1`
				eval ${cond}_2=$tmp_2	## end sub-brick 
				
				run_n=`awk 'NR==1 {print NF}' $stim_dir/offset_${cond}_run-${run}.1D`
				for ((i=0; i<$run_n; i++)); do
					echo $cond $run >> $attr_file
					Tpl_ID=`echo ${cond} | sed 's/[0-9]//g'`
					echo $Tpl_ID $run >> $attr_file_2
				done
			done
			
			echo '3dTcat -overwrite -prefix $stats_dir/all-stim_all'${est_type}${reml}'.nii \' >> $out_file
			echo '	$stats_dir/stats.'${subj}${reml}"+orig'[" \
				${A1_1}'-'${A1_2}'(2), ' \
				${A2_1}'-'${A2_2}'(2), ' \
				${A3_1}'-'${A3_2}'(2), ' \
				${B1_1}'-'${B1_2}'(2), ' \
				${B2_1}'-'${B2_2}'(2), ' \
				${B3_1}'-'${B3_2}'(2), ' \
				${C1_1}'-'${C1_2}'(2), ' \
				${C2_1}'-'${C2_2}'(2), ' \
				${C3_1}'-'${C3_2}'(2), ' \
				${D1_1}'-'${D1_2}'(2), ' \
				${D2_1}'-'${D2_2}'(2), ' \
				${D3_1}'-'${D3_2}"(2)]'" >> $out_file		
			echo >> $out_file
		done
	done

	bash $out_file
done

