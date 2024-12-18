#!/bin/bash

top_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow
prep_dir=$top_dir/derivatives/fmriprep_fmap_RL
afni_dir=$top_dir/derivatives/afni_out

subj=$1
stage=$2
xi=$3 ## iterate

stats_dir=$afni_dir/SS_results_1115/${subj}.results
input_dt=$stats_dir/${stage}-expo-trials_betas.nii
input_targets=$stats_dir/${stage}-expo-trials_attrs.txt
pfx=$stats_dir/LSS.${stage}-expo ##

train_dt_out=${pfx}_trainBlock.nii
train_targets=${pfx}_trainLabels.1D
if [ -f $train_targets ]; then rm $train_targets ; fi

test_dt_out=${pfx}_testBlock.nii
test_targets=${pfx}_testLabels.1D
if [ -f $test_targets ]; then rm $test_targets ; fi

total=`cat $input_targets | wc -l`
final=`expr $total - 1`
# xi=`shuf -i 0-9 -n 1` ## set a seed
xj=0; Xs=(); Ys=()
target_list=( `seq $xi 10 $final` ) ## "10-fold" partitioner
until [[ "${#target_list[@]}" -eq 0 ]]; do ## count the length
	x=${target_list[0]}
	Xs=( ${Xs[@]} $x )
	Ys=( ${Ys[@]} $xj'-'`expr $x - 1` )
	xj=`expr $x + 1`		
	if [[ "$xj" -ge "$final" ]]; then break; fi
	target_list=( ${target_list[@]:1} )
done
if [[ "$xi" -eq 0 ]]; then 
	Ys=( ${Ys[@]:1} ); Ys=( ${Ys[@]} $xj'-'$final )
elif [[ "$xi" -eq 1 ]]; then 
	Ys=( ${Ys[@]:1} ); Ys=( 0 ${Ys[@]} )
fi

## testing set:
eval '3dTcat -verb -overwrite -prefix '$test_dt_out' '$input_dt"'["${Xs[0]}", "${Xs[1]}", "${Xs[2]}", "${Xs[3]}", "${Xs[4]}", "${Xs[5]}", "${Xs[6]}", "${Xs[7]}", "${Xs[8]}", "${Xs[9]}", "${Xs[10]}", "${Xs[11]}", "${Xs[12]}", "${Xs[13]}", "${Xs[14]}", "${Xs[15]}", "${Xs[16]}", "${Xs[17]}", "${Xs[18]}", "${Xs[19]}", "${Xs[20]}", "${Xs[21]}", "${Xs[22]}", "${Xs[23]}", "${Xs[24]}", "${Xs[25]}"]'" 

## training set:
get_train_ds='3dTcat -verb -overwrite -prefix '$train_dt_out' '$input_dt"'["${Ys[0]}", "${Ys[1]}", "${Ys[2]}", "${Ys[3]}", "${Ys[4]}", "${Ys[5]}", "${Ys[6]}", "${Ys[7]}", "${Ys[8]}", "${Ys[9]}", "${Ys[10]}", "${Ys[11]}", "${Ys[12]}", "${Ys[13]}", "${Ys[14]}", "${Ys[15]}", "${Ys[16]}", "${Ys[17]}", "${Ys[18]}", "${Ys[19]}", "${Ys[20]}", "${Ys[21]}", "${Ys[22]}", "${Ys[23]}", "${Ys[24]}", "${Ys[25]}

if [[ "$xi" -eq 0 || "$xj" -gt "$final" ]]; then
## the first or last sub-brick (beta-series) is assigned to testing-set
	eval ${get_train_ds}"]'"
elif [[ "$xj" -eq "$final" ]]; then
	Ys=( ${Ys[@]} $final ) ## append the last sub-brick to training-set (but not the range)
	eval ${get_train_ds}", "${Ys[26]}"]'"
else
	Ys=( ${Ys[@]} $xj'-'$final ) ## append the last range
	eval ${get_train_ds}", "${Ys[26]}"]'"
fi

for ((i=0; i<$total; i++)); do
	nr=`expr $i + 1`
	cond=` awk -v nr=$nr 'NR==nr {print $1}' $input_targets `
	case $cond in 
		A1 ) c_id=1 ;;	A2 ) c_id=2 ;;	A3 ) c_id=3 ;; 
		B1 ) c_id=4 ;;	B2 ) c_id=5 ;;	B3 ) c_id=6 ;; 
		C1 ) c_id=7 ;;	C2 ) c_id=8 ;;	C3 ) c_id=9 ;; 
		D1 ) c_id=10 ;;	D2 ) c_id=11 ;;	D3 ) c_id=12 ;; 
	esac
	
	if [[ " ${Xs[*]} " =~ " $i " ]]; then
		echo $c_id >> $test_targets
	else
		echo $c_id >> $train_targets
	fi
done

