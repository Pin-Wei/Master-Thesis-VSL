#!/usr/bin/bash

## bash
## mamba/conda activate pymvpa
## nohup bash Make_pymvpa_dataset_nohup.sh > pymvpa_dataset.log &

## Read input:
# echo -e "\n[0] runs [1] runs_v2 [2] runs+behav [3] runs_v+ [4] runs_v4"
# read -p ">> AFNI version: " AFNI_VER
# read -p ">> Individual Modulation (IM)? [y/n] " do_im
# case $do_im in
	# y ) im='' ;;
	# n ) im='--no_im' ;;
# esac

## Spesified:
python Make_info_dataset.py -a 12 --lss
python Make_fmri_dataset.py -a 12 --lss 

# python Make_info_dataset.py -a 11 --lss
# python Make_fmri_dataset.py -a 11 --lss 

# python Make_info_dataset.py -a 9 --lss
# python Make_fmri_dataset.py -a 9 --lss 
# python Make_info_dataset.py -a 10 --lss
# python Make_fmri_dataset.py -a 10 --lss 

# python Make_info_dataset.py -a 7 --lss  
# python Make_fmri_dataset.py -a 7 --lss 
# python Make_info_dataset.py -a 6 --lss  
# python Make_fmri_dataset.py -a 6 --lss 
# python Make_info_dataset.py -a 5
# python Make_fmri_dataset.py -a 5
# python Make_info_dataset.py -a 4 --lss  
# python Make_fmri_dataset.py -a 4 --lss 

## Auto loop:

# AFNI_VER=8
# for DATA_VER in '' '-t' '--reml' '-t --reml' '--lss'; do
	# python Make_info_dataset.py -a $AFNI_VER $DATA_VER
	# python Make_fmri_dataset.py -a $AFNI_VER $DATA_VER
# done

# for AFNI_VER in 0 1 3 4 ; do
# for AFNI_VER in 3 ; do
	# if [[ $AFNI_VER == 3 || $AFNI_VER == 4 ]]; then 
		# IM='--no_im'
	# else
		# IM=''
	# fi

	# for STAT in '' '-t'; do 
		# for REML in '' '--reml'; do 
			# python Make_info_dataset.py -a $AFNI_VER $IM $STAT $REML
			# python Make_fmri_dataset.py -a $AFNI_VER $IM $STAT $REML
		# done
	# done
# done

TODAY=`date +'%Y-%m-%d'`
mv pymvpa_dataset.log HIDDEN_scripts/pymvpa_dataset_${TODAY}.log

# -------------------------------------------------------
# about nohup usage: https://www.runoob.com/linux/linux-comm-nohup.html

# To terminate the script, first we need to find the PID of current script:
	# ps -aux | grep Make_pymvpa_dataset_nohup.sh 

# then kill the script with PID:
	# kill -PID