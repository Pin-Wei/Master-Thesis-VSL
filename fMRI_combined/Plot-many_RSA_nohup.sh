#!/usr/bin/bash

## bash Plot-many_RSA_nohup.sh $x

AFNI_VERs=( 10 )
DATA_VERs=( '--lss' )
# DATA_VERS=( '' '-t' '--reml' '-t --reml' )

case $1 in
	0 ) conda activate pymvpa
		# python_script=Plot_RDMs.py # python 2
		
		for AFNI_VER in ${AFNI_VERs[*]} ; do
			for RUNS in 0 1 ; do 
				for DATA_VER in ${DATA_VERs[*]} ; do
					 python Plot_RDMs.py -a $AFNI_VER $DATA_VER -s 1 --runs $RUNS 
			done; done; done
		;;
	1 ) 
		# python_script=Plot_similarity_changes.py # python 3
		# MEAS=0 # euclidean
		MEAS=1 # correlation
		# MEAS=2 # hamming
		# MEAS=3 # cosine
		# MEAS=4 # squared Euclidean distance

		for AFNI_VER in ${AFNI_VERs[*]} ; do
			for A in 0 1 2 3 4 5 6 7 8  ; do 
			# for A in 0 ; do 
			
				for B in 0 ; do
				# for B in 1 2 ; do
				
					for RUNS in 0 ; do 
						for DATA_VER in ${DATA_VERs[*]} ; do
							 python Plot_similarity_changes.py -a $AFNI_VER $DATA_VER \
								-s 1 --runs $RUNS --targA $A --targB $B --meas $MEAS --re_plot
									#  --re_stats --update_df
		done; done; done; done; done
		;;
esac

## manual log ================================================================
# Archive below:

# for MEAS in 0 1 2 ; do
	# for RUNS in 0 1 ; do
		# python $python_script \
			# -a 7 --lss        \
			# --meas $MEAS      \
			# --runs $RUNS      \
			# --re_plot
	# done
# done

# for MEAS in 0 1 ; do
	# for STIM_TYPE in 1 2 ; do
		# # python $python_script -a 0 -s $STIM_TYPE --meas $MEAS
		# # python $python_script -a 0 -t --reml -s $STIM_TYPE --meas $MEAS
		# python $python_script -a 4 --lss -s $STIM_TYPE --meas $MEAS --runs 1 --re_plot
		# python $python_script -a 4 -t --reml -s $STIM_TYPE --meas $MEAS --runs 1 --re_plot
	# done
# done

# 2023.08.23: Plot_RDMs
# for MEAS in 0 1 ; do
	# for STIM_TYPE in 1 2 ; do
		# python $python_script -a 0 -s $STIM_TYPE --meas $MEAS
		# python $python_script -a 0 -t --reml -s $STIM_TYPE --meas $MEAS
		# python $python_script -a 4 --lss -s $STIM_TYPE --meas $MEAS
		# python $python_script -a 4 -t --reml -s $STIM_TYPE --meas $MEAS
	# done
# done

# 2023.08.25: Plot_similarity_changes
# for MEAS in 0 1 ; do
	# python $python_script -a 0 --meas $MEAS
	# python $python_script -a 0 -t --reml --meas $MEAS
	# python $python_script -a 4 --lss --meas $MEAS
	# python $python_script -a 4 -t --reml --meas $MEAS
# done

# 2023.08.31: Plot_RDMs
# for MEAS in 0 1 ; do
	# for STIM_TYPE in 1 2 ; do
		# python $python_script -a 4 --lss -s $STIM_TYPE --meas $MEAS --runs 1
		# python $python_script -a 4 -t --reml -s $STIM_TYPE --meas $MEAS --runs 1
	# done
# done