#!/usr/bin/env tcsh
# tcsh Extract_ss_review.sh

set ver = 7
set sfx = 'runs_MNI_3ord_v'$ver

# set ver = '7.T1w.trial-wise'
# set sfx = 'runs_v7'

set grp_dir = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain
set grp_out = $grp_dir/ap.$sfx
if ( ! -d $grp_out ) mkdir -p $grp_out

set fn_list = ( \
	'cen_TR' 'cen_TR_motion' 'cen_TR_outlim' 'motion_avg' 'TSNR_avg' 'GCOR' \
)
set keyword_list = (              \
	'TRs\sremoved'                \
	'num\sTRs\sabove\smot\slimit' \
	'num\sTRs\sabove\sout\slimit' \
	'average\smotion'             \
	'TSNR\saverage'               \
	'global\scorrelation'         \
)

foreach fn ( ${fn_list[*]} )
	set file = $grp_out/v.${ver}_review_final_${fn}.tsv
	if ( -f $file ) rm $file
	# touch $file
	echo "Subject\tRun\tValue" > $file
end

foreach task ( vsl slowVSL )
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
	
	foreach subj ( $subj_list )
		# foreach run ( `seq -f "%02g" 01 1 10` )
		foreach run ( `seq -f "%02g" 2 9` )
		
			set stats_dir = $top_dir/derivatives/afni_out/SS_results_$sfx/${subj}_r${run}.results
			set ss_review = $stats_dir/out.ss_review.$subj.txt
			
			foreach x ( `count -digit 1 1 ${#fn_list}` )
				echo $subj'	'$run'	'`grep ${keyword_list[$x]} $ss_review | awk '{print $NF}'` \
					>> $grp_out/v.${ver}_review_final_${fn_list[$x]}.tsv
			end
		end
	end
end

			

			 
