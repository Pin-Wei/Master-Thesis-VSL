#!/usr/bin/tcsh

# nohup tcsh Run-many_afni-proc_runs.sh

# set sfx = 'runs_MNI_3ord_AM'
# set sfx = 'runs_MNI_3ord_v6_cont'
set sfx = 'runs_MNI_3ord_v7'
# set sfx = 'runs_T1w_3ord_v6'

set current_dir = `pwd`
set script_name = run_afni-proc_${sfx}.sh

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
				set subj_list = `cat subjList_2.txt` # `seq -f "sub-%03g" 120 1 127` # 
				breaksw
		endsw
		
		set code_dir = $top_dir/code/HIDDEN_scripts
		cp -u $current_dir/HIDDEN_scripts/$script_name $code_dir

		cd $code_dir
		if ! ( -d SS_results_${sfx} ) mkdir SS_results_${sfx}
		if ! ( -d scripts.$sfx ) mkdir scripts.$sfx
		# if ! ( -d single-subj_scripts ) mkdir single-subj_scripts

		foreach subj ( $subj_list )
		# foreach subj ( `seq -f "sub-%03g" 120 127` )	
		# foreach subj ( sub-127 )
		
			# foreach run ( `seq -f "%02g" 01 1 10` )
			foreach run ( `seq -f "%02g" 2 9` )
			# foreach run ( 01 10 )
			
				if ( ! -d $code_dir/${subj}_r${run}.results ) then
					if ( -d $code_dir/${subj}.results ) rm -R $code_dir/${subj}.results
					
					tcsh $script_name $subj $run $task $top_dir
					mv ${subj}.results ${subj}_r${run}.results
				endif
			end	
		end

		mv sub-*.results SS_results_${sfx}
		mv SS_results* $top_dir/derivatives/afni_out
		mv scripts.$sfx $top_dir/derivatives/single-subj_scripts

		cd $current_dir
	end