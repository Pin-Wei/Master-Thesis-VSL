#!/usr/bin/tcsh

# tcsh Run-many_ap+LSS_runs.sh

set sfx = 'runs_v7'

set script_name = run_afni-proc_${sfx}.sh
set LSS_script_name = run_3dLSS_${sfx}.sh

set current_dir = `pwd`

startup:
	echo "\n>> Which dataset, [a] rapid, [b] slow, or [c] both?"
	set ver = $<

	if ( $ver == a ) then
		set todo_list = ( vsl )
	else if ( $ver == b ) then
		set todo_list = ( slowVSL )
	else if ( $ver == c ) then
		set todo_list = ( vsl slowVSL )
	else
		echo "Bad option, try again"
		goto startup
	endif

main:
	foreach task ( ${todo_list[*]} )
		switch ( $task )
			case vsl:
				set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti
				set subj_list = `cat subjList_1.txt`
				breaksw
			case slowVSL:
				set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
				set subj_list = `cat subjList_2.txt` 
				breaksw
		endsw
		
		set code_dir = $top_dir/code/HIDDEN_scripts
		cp -u $current_dir/HIDDEN_scripts/$LSS_script_name $code_dir
		cp -u $current_dir/HIDDEN_scripts/$script_name $code_dir

		cd $code_dir
		if ! ( -d SS_results_${sfx} ) mkdir SS_results_${sfx}
		if ! ( -d scripts.$sfx ) mkdir scripts.$sfx

		foreach subj ( $subj_list )
		# foreach subj ( `seq -f "sub-%03g" 106 1 127` )
		# foreach subj ( sub-02 sub-03 )
		
			foreach run ( `seq -f "%02g" 01 1 10` )
			# foreach run ( 07 10 )
			
				if ( ! -d $code_dir/${subj}_r${run}.results ) then
					if ( -d $code_dir/${subj}.results ) rm -R $code_dir/${subj}.results
					
					tcsh $script_name $subj $run $task $top_dir
					tcsh $LSS_script_name $subj $run $task $top_dir ${subj}.results
					
					mv ${subj}.results ${subj}_r${run}.results
				endif
			end	
		end

		mv sub-*.results SS_results_${sfx}
		mv SS_results* $top_dir/derivatives/afni_out
		mv scripts.$sfx $top_dir/derivatives/single-subj_scripts
		
		cd $current_dir
	end
