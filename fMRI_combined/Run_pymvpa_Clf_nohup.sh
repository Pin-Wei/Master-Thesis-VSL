#!/usr/bin/bash

## bash
## mamba activate pymvpa
## nohup bash Run_pymvpa_Clf_nohup.sh > pymvpa_clf.log &

n_fold='-nf 8'  # ''
re_do='--re_do' # ''
do_avg=''       # '--do_avg'

for targ in '' '--tpl' ; do 
	for clf in 0 1 2 3 ; do
		echo '### run window' >> pymvpa_clf.log
		python Run_pymvpa_Clf.py --r_seg 1 \
			-a 7 --lss $targ $re_do        \
			--clf $clf $n_fold $do_avg
		
		echo '### exposure runs' >> pymvpa_clf.log
		python Run_pymvpa_Clf_ROIbased.py  \
			-a 7 --lss $targ $re_do        \
			--clf $clf $n_fold $do_avg
	done
done

TODAY=`date +'%Y-%m-%d'`
mv pymvpa_clf.log HIDDEN_scripts/pymvpa_clf${NAME_ADD}_${TODAY}.log

## ====================================================================================
# ps -aux | grep 
# kill -9 $(ps -aux | grep 'Run_pymvpa_clf_nohup.sh' | awk '{print $2}')
# https://www.runoob.com/linux/linux-comm-kill.html

## ------------------------------------------------------------------------------------
# clf_script=Run_pymvpa_Clf_ROIbased.py
# targ='' # '--tpl'

# for do_avg in '' '--do_avg' ; do
	# # for n_fold in '-nf 3' '-nf 8' '' ; do
	# for n_fold in '-nf 8' '' ; do
		# for clf in 0 1 2 3 ; do
			# python $clf_script -a 5 $targ --clf $clf $n_fold $do_avg $re_do
			# # python $clf_script -a 4 --lss $targ --clf $clf $n_fold $do_avg $re_do
			
			# for AFNI_VER in 0 1 2 ; do
				# for STAT in '' '-t'; do 
					# for REML in '' '--reml'; do 
						# python $clf_script -a $AFNI_VER $STAT $REML $targ --clf $clf $FOLD $do_avg $re_do
					# done
				# done
			# done			
		# done
	# done
# done