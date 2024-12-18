#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out
sufx='_REML+orig'

echo -e "\n>> input AFNI stats type: \n\t(a.) Sequence order --1102 \n\t(b.) Shapes to Tpl --1115 \n\t(c.) Triplets --1123"
read -p ">> a, b or c? " choose
case $choose in
	a ) ss_ver=1102 
		cond_list=( first second third ) ;;
	b ) ss_ver=1115 
		cond_list=( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 ) ;;
	c ) ss_ver=1123 
		cond_list=( tpl-A tpl-B tpl-C tpl-D ) ;;
esac

out_file=HIDDEN_scripts/extract_expo-trial_Betas_script_v${ss_ver}.sh
if [ -f $out_file ]; then rm $out_file; fi

echo '#!/bin/bash' >> $out_file
echo >> $out_file
echo 'afni_dir='$afni_dir >> $out_file
echo >> $out_file

for subj in `cat subjList.txt`; do
	stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
	stim_dir=$stats_dir/stimuli
	
	echo >> $out_file
	echo '# ============================' $subj '============================' >> $out_file
	echo 'stats_dir=$afni_dir/SS_results_'${ss_ver}'/'${subj}'.results' >> $out_file
	
	tmp_2=-1
	for cond in ${cond_list[*]} ; do # for each condition (= stimilus type)
		if [ $ss_ver == 1123 ]; then c_name=`echo $cond | sed "s/-/_/g"`; else c_name=$cond; fi		
		
		tmp_1=`expr ${tmp_2} + 2`
		subb_n=`cat $stim_dir/offset_${c_name}_exposure-runs.1D | wc -w` # count the number of trials		
		tmp_2=`expr ${subb_n} \* 2 + ${tmp_1} - 1`
			
		echo >> $out_file
		echo '##' $cond >> $out_file
		echo '3dTcat -overwrite -prefix $stats_dir/stim-'${cond}'_allBetas.nii \' >> $out_file
		echo '	$stats_dir/stats.'${subj}${sufx}"'["${tmp_1}"-"${tmp_2}"(2)]'" >> $out_file
		echo >> $out_file
		
		temp2=-1
		for nr in `seq 1 8`; do	# for each exposure runs			
			run=`expr $nr + 1`
			run_n=`awk -v nr=$nr 'NR==nr {print NF}' $stim_dir/offset_${c_name}_exposure-runs.1D`
			temp1=`expr ${temp2} + 1`
			temp2=`expr ${temp1} + ${run_n} - 1`
			
			echo '3dTcat -overwrite -prefix $stats_dir/stim-'${cond}'_run-'${run}'_Betas.nii \' >> $out_file
			echo '	$stats_dir/stim-'${cond}"_allBetas.nii'["${temp1}"-"${temp2}"]'" >> $out_file
		done
	done
done

bash $out_file