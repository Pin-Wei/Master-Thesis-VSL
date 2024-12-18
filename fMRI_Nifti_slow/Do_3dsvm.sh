#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

# echo -e "\n>> input AFNI stats type: \n\t(a.) Sequence order --1102 \n\t(b.) Shapes to Tpl --1115 \n\t(c.) Triplets --1123"
# read -p ">> a, b or c? " input_ver
# case $input_ver in  a ) ss_ver=1102 ;; b ) ss_ver=1115 ;; c ) ss_ver=1123 ;; esac
input_ver=b; ss_ver=1115

# if [ $1 == 1 ]; then lss='LSS.'; else lss=''; fi
lss='LSS.'

# echo -e "\n>> Early or Late stage? "
# read -p ">> 1 or 2? " input_stg
# case $input_stg in  1 ) stage='early' ;; 2 ) stage='late' ;; esac
for stage in early late ; do
	pfx=${lss}${stage}-expo_
	
	train_ds=${pfx}'trainBlock.nii'
	cond_labels=${pfx}'trainLabels.1D'
	test_ds=${pfx}'testBlock.nii'
	truth=${pfx}'testLabels.1D'

	# model=linSVM_${pfx}fV
	model=linSVM_${pfx}HPC
	acc_out_fn=$afni_dir/SS_results_${ss_ver}/${model}_ACC_*.tsv
	if [ -f $acc_out_fn ]; then rm $acc_out_fn ; fi

	for subj in `cat subjList.txt` ; do
		stats_dir=$afni_dir/SS_results_${ss_ver}/${subj}.results
		anat_dir=$prep_dir/$subj/anat
		
		if [ ! -d $stats_dir/3dsvm ]; then mkdir $stats_dir/3dsvm ; fi
		out_dir=$stats_dir/3dsvm
				
		## Choose a mask:
		Mask=$anat_dir/ROImasks/roimask_space-T1w_HPC_resam.nii.gz
		# Mask=$afni_dir/SS_results_1029/${subj}.results/${subj}_all-expo_Visual_cluster-mask.nii.gz
		
		## Prepare train/test datasets:
		# bash create_${lss}train-test_dataset.sh $input_ver $subj
		for xi in `seq 0 1 9`; do
			echo '================== fold-'$xi' =================='
		
			bash HIDDEN_scripts/create_train-test_cv_LSS-dataset.sh $subj $stage $xi
		
			# rm $out_dir/$model* $stats_dir/$model*
			3dsvm -overwrite \
				-trainvol $stats_dir/$train_ds	\
				-trainlabels $stats_dir/$cond_labels 	\
				-mask $Mask				\
				-model $out_dir/$model.nii		\
				-alpha $out_dir/${model}_alpha	\
				-bucket $out_dir/${model}_weights
				## "-kernel rbf (-g float)" -> Radial Basis Function (+ Gamma parameter, default= 1.0)
			
			3dsvm -overwrite \
				-testvol $stats_dir/$test_ds		\
				-testlabels $stats_dir/$truth		\
				-model $out_dir/$model.nii		\
				-predictions $out_dir/pred2_$model	\
				-multiclass DAG -classout
				## "DAG" -> Directed Acyclic Graph		
				## "-nodetrend" -> prediction files should NOT be linearly detrended (which is performed by default)	
				## "-classout" -> prediction files should be integer (class predictions) rather than continuous valued output

			bash HIDDEN_scripts/evaluate_3dsvm_results.sh $input_ver $model $truth $subj $Mask 
		done
	done
done
