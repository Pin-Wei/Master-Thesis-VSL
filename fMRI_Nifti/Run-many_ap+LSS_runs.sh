#!/usr/bin/tcsh

# set mni = MNI152NLin2009cAsym
set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
cd HIDDEN_scripts

# set sfx = runs
# set sfx = runs_v2
set sfx = runs+behav
if ! ( -d SS_results_${sfx} ) mkdir SS_results_${sfx}

foreach subj ( `cat subjList.txt` )
# foreach subj ( `seq -f "sub-%02g" 07 1 12` )
	foreach run ( `seq -f "%02g" 01 1 10` )
		# tcsh run_afni-proc_runs.sh $subj $run
		# tcsh run_afni-proc_runs_v2.sh $subj $run
		tcsh run_afni-proc_runs_v3.sh $subj $run
		mv ${subj}.results ${subj}_r${run}.results
	end	
end

mv sub-*.results SS_results_${sfx}
mv SS_results* $top_dir/derivatives/afni_out

foreach run ( `seq -f "%02g" 01 1 10`)
	# tcsh run_3dLSS_runs.sh $run
	# tcsh run_3dLSS_runs_v2.sh $run
	tcsh run_3dLSS_runs_v3.sh $run
end
