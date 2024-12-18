#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

echo -e "\n>> input AFNI stats type: \n\t(a.) Sequence order --1102 \n\t(b.) Shapes to Tpl --1115"
read -p "a/b? " choose
case $choose in
	a ) ss_ver=1102 
		cond_list=( first second third ) ;;
	b ) ss_ver=1115 
		cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ) ;;
esac

out_file=HIDDEN_scripts/extract_all-expo-trial_Betas_script_v${ss_ver}.sh
if [ -f $out_file ]; then rm $out_file; fi

echo '#!/bin/bash' >> $out_file
echo >> $out_file
echo 'afni_dir='$afni_dir >> $out_file
echo >> $out_file

for subj in `cat subjList.txt`; do
	stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
	stim_dir=$stats_dir/stimuli
	echo '#' $subj >> $out_file
	echo 'stats_dir=$afni_dir/SS_results_'${ss_ver}'/'${subj}'.results' >> $out_file
	
	attr_file=$stats_dir/all-stim_attrs.txt
	if [ -f $attr_file ]; then rm $attr_file ; fi
	attr_file_2=$stats_dir/all-stim_Triplets_attrs.txt ###
	if [ -f $attr_file_2 ]; then rm $attr_file_2 ; fi
	
	tmp_2=-1
	case $ss_ver in	
		1102 ) 
			for cond in ${cond_list[*]} ; do
				tmp_1=`expr ${tmp_2} + 2`
				eval ${cond}_1=$tmp_1	## start sub-brick of the current condition 
				
				subb_n=`cat $stim_dir/offset_${cond}_exposure-runs.1D | wc -w`			
				tmp_2=`expr ${subb_n} \* 2 + ${tmp_1} - 1`
				eval ${cond}_2=$tmp_2	## end sub-brick 
				
				for count in `seq 1 8`; do
					run=`expr ${count} + 1`
					run_n=`awk -v c=${count} 'NR==c {print NF}' $stim_dir/offset_${cond}_exposure-runs.1D`
					
					for ((i=0; i<$run_n; i++)); do
						echo $cond $run >> $attr_file
					done
				done
			done
			
			echo '3dTcat -overwrite -prefix $stats_dir/all-stim_allBetas.nii \' >> $out_file
			echo '	$stats_dir/stats.'${subj}"_REML+orig'[" \
				${first_1}'-'${first_2}'(2), ' \
				${second_1}'-'${second_2}'(2), ' \
				${third_1}'-'${third_2}"(2)]'" >> $out_file		
			echo >> $out_file
			;;
			
		1115 ) 
			for cond in ${cond_list[*]} ; do
				tmp_1=`expr ${tmp_2} + 2`
				eval ${cond}_1=$tmp_1	## start sub-brick of the current condition 
				
				subb_n=`cat $stim_dir/offset_${cond}_exposure-runs.1D | wc -w`
				tmp_2=`expr ${subb_n} \* 2 + ${tmp_1} - 1`
				eval ${cond}_2=$tmp_2	## end sub-brick 
				
				for count in `seq 1 8`; do
					run=`expr ${count} + 1`
					run_n=`awk -v c=${count} 'NR==c {print NF}' $stim_dir/offset_${cond}_exposure-runs.1D`
					
					for ((i=0; i<$run_n; i++)); do
						echo $cond $run >> $attr_file
						Tpl_ID=`echo ${cond} | sed 's/[0-9]//g'`
						echo $Tpl_ID $run >> $attr_file_2
					done
				done
			done
			
			echo '3dTcat -overwrite -prefix $stats_dir/all-stim_allBetas.nii \' >> $out_file
			echo '	$stats_dir/stats.'${subj}"_REML+orig'[" \
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
			;;
	esac		
done

bash $out_file
