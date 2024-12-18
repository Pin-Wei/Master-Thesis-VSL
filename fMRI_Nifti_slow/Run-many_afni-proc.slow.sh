#!/usr/bin/tcsh

set mni = MNI152NLin2009cAsym
set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
echo "BIDS directory: " $top_dir

set prep = fmriprep_fmap_RL
set prep_dir = $top_dir/derivatives/$prep

echo "\n>> afni-proc version(s): "
set suffixs = $<

cd HIDDEN_scripts
if ( ! -d single-subj_scripts ) mkdir single-subj_scripts

foreach sfx ( $suffixs )
	if ! ( -d SS_results_${sfx} ) mkdir SS_results_${sfx}

	foreach subj ( `cat subjList.txt` )
		if ( $sfx == runs ) then
			foreach run ( `seq -f "%02g" 01 1 10`)
				tcsh run_afni-proc.slow_runs.sh $subj $prep $mni $run
				mv ${subj}.results ${subj}_r${run}.results
			end
		else
			# tcsh run_afni-proc.slow.22${sfx}.sh $subj $prep $mni
			tcsh run_afni-proc.slow.23${sfx}.sh $subj $prep $mni
		endif
	end
	
	mv sub-*.results SS_results_${sfx}
	
	cd SS_results_${sfx}
	if ( -f SS_subjList.txt ) rm SS_subjList.txt
	( ls -d sub-*.results ) | sed "s|.results\/||g" > SS_subjList.txt
	
	cp -f SS_subjList.txt $top_dir/code
	
	cd $top_dir/code/HIDDEN_scripts
end

mv SS_results* $top_dir/derivatives/afni_out/
