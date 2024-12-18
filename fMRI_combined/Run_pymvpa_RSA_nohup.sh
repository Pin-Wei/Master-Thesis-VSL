#!/usr/bin/bash

## bash
## mamba/conda activate pymvpa
## bash Run_pymvpa_RSA_nohup.sh

### nohup bash Run_pymvpa_RSA_nohup.sh > pymvpa_rsa.log 

AFNI_VERs=( 10 )
DATA_VERs=( '--lss' )
# MEAS=0 # euclidean
# MEAS=1 # correlation
# MEAS=2 # hamming
# MEAS=3 # cosine
MEAS=4 # sqeuclidean
		
for RUNS in 0 1 ; do
	for AFNI_VER in ${AFNI_VERs[*]}; do
		python Run_pymvpa_RSA_exposure.py -a $AFNI_VER $DATA_VER -sg 1 -rg $RUNS --meas $MEAS
		python Run_pymvpa_RSA.py -a $AFNI_VER $DATA_VER -s 1 --runs $RUNS --meas $MEAS
	done
done

# for RUNS in 0 1 ; do
	# for AFNI_VER in 9 10 11; do
		# python Run_pymvpa_RSA_exposure.py -a $AFNI_VER --lss -sg 1 -rg $RUNS
		# python Run_pymvpa_RSA.py -a $AFNI_VER --lss -s 1 --runs $RUNS
	# done
# done

# AFNI_VER=8
# STIM_TYPE=1

# for RUNS in 0 1 ; do
	# for DATA_VER in '' '-t' '--reml' '-t --reml' '--lss'; do
		# python Run_pymvpa_RSA.py -a $AFNI_VER $DATA_VER -s $STIM_TYPE --runs $RUNS
	# done
# done

# OPT_ADD='--runs 1' # '--meas 0' 
# NAME_ADD='-expo' # '-euc'

# ## LSS only
# for RUNS in '' '--runs 1' ; do
	# for STIM_TYPE in 1 2 ; do
		# python Run_pymvpa_RSA.py -a 7 -s $STIM_TYPE $RUNS
	# done
# done

# for STIM_TYPE in 1 2 ; do
	# python Run_pymvpa_RSA.py -a 5 -s $STIM_TYPE $OPT_ADD
	
	# for AFNI_VER in 0 1 2 4 ; do
		# for STAT in '' '-t'; do 
			# for REML in '' '--reml'; do 
				# python Run_pymvpa_RSA.py -a $AFNI_VER $STAT $REML
				# python Run_pymvpa_RSA.py -a $AFNI_VER $STAT $REML -s $STIM_TYPE $OPT_ADD
			# done
		# done
	# done
# done

# python Run_pymvpa_RSA.py -a 4 --lss $OPT_ADD

# ------------------------------------------------------------------------------------------
# TODAY=`date +'%Y-%m-%d'`
# mv pymvpa_rsa.log HIDDEN_scripts/pymvpa_rsa${NAME_ADD}_${TODAY}.log