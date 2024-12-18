#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out
case $1 in
	a ) ssfn=SS_results_1102 ; cond_n=3 ;;
	b ) ssfn=SS_results_1115 ; cond_n=12 ;;
	c ) ssfn=SS_results_1123 ; cond_n=4 ;;
esac

model=$2
truth=$3
pred_fn=pred2_${model}_overall_DAG.1D
out_fn=$afni_dir/$ssfn/${model}_ACC_over-${cond_n}.tsv

for subj in $4; do
	stats_dir=$afni_dir/${ssfn}/${subj}.results
	svm_dir=$stats_dir/3dsvm
	
	if [ ! -f $stats_dir/stats.$subj+orig.HEAD ]; then 
		echo -e $subj"\t***no stats***" >> $out_fn
	elif [ ! -f $5 ]; then 
		echo -e $subj"\t***no mask***" >> $out_fn	
	else
		sum_acc=0
		for idx in `seq 1 1 $cond_n` ; do
			1deval -a $stats_dir/$truth -x=${idx} -expr 'iszero(a-x)*x' > $svm_dir/tmp_real_${idx}_only.txt
			1deval -a $svm_dir/$pred_fn -x=${idx} -expr 'iszero(a-x)*x' > $svm_dir/tmp_pred_${idx}_only.txt
			
			1dsum `1deval -1D: -x=${idx} \
				-a $svm_dir/tmp_real_${idx}_only.txt \
				-b $svm_dir/tmp_pred_${idx}_only.txt \
				-expr 'iszero(a-x)*iszero(b-x)'` >> $svm_dir/tmp_${idx}.txt  # N(correct)
				
			expr `1dsum $svm_dir/tmp_real_${idx}_only.txt` / ${idx} >> $svm_dir/tmp_${idx}.txt  # N(total)
			
			# # append N(correct), N(total), & Accuracy rate(%) into file
			# awk '{if (NR==1) a=$1; if (NR==2) b=$1} END {printf ("%d\t%d\t%.3f\n", a, b, a/b*100)}' \
				# $svm_dir/tmp_${idx}.txt >> $afni_dir/$ssfn/ACC_${idx}.txt
				
			acc=`awk '{if (NR==1) a=$1; if (NR==2) b=$1} END {printf ("%.3f\n", a/b*100)}' $svm_dir/tmp_${idx}.txt`
			sum_acc=`echo $sum_acc + $acc | bc`
		done
		
		echo -e $subj'\t'`echo "scale = 2; "$sum_acc / $cond_n | bc` >> $out_fn
		
		rm $svm_dir/tmp*.txt
	fi
done
