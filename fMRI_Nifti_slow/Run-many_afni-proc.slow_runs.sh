#!/usr/bin/tcsh

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
# cd HIDDEN_scripts
cd TEMP

# set sfx = runs_MNI
set sfx = 'runs_MNI_all-only'
set hidden_sh = run_afni-proc.slow_${sfx}.sh

if ! ( -d SS_results_${sfx} ) mkdir SS_results_${sfx}

# foreach subj ( `cat subjList.txt` )
foreach subj ( `seq -f "sub-%03g" 115 1 127` )
	foreach run ( `seq -f "%02g" 01 1 10` )
		tcsh $hidden_sh $subj $run
		mv ${subj}.results ${subj}_r${run}.results
	end	
end

mv sub-*.results SS_results_${sfx}
mv SS_results* $top_dir/derivatives/afni_out

