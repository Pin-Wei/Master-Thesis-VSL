#!/usr/bin/env tcsh

cd HIDDEN_scripts

set top_dir = /media/data2/pinwei/SL_hippocampus/Nifti_slow
set afni_dir = $top_dir/derivatives/afni_out

set ss_ver = 1207
set ssfn = SS_results_${ss_ver}
set out_dir = $afni_dir/Group_analysis/v.${ss_ver}
if ( ! -f $out_dir ) mkdir $out_dir

foreach stat ( 'stats' 'shapeStim.stats' )
	switch ( $stat )
		case 'stats':
			set reg_list = ( Fst.2-3 Fst.4-5 Fst.6-7 Fst.8-9 Snd.2-3 Snd.4-5 Snd.6-7 Snd.8-9 Trd.2-3 Trd.4-5 Trd.6-7 Trd.8-9 )
			set glt_sufxs = ( early-expos mid-expos late-expos All-expos ) # lin-Inc log-Inc
			breaksw
		case 'shapeStim.stats':
			# set reg_list = ( A1 A2 A3 B1 B2 B3 C1 C2 C3 D1 D2 D3 )
			set reg_list = ()
			set glt_sufxs = ( Early Mid Late All )
			breaksw
		default:
			echo '!! Error switch-case setting !!'
			exit
	endsw
	
	## one-sample t-tests:
	# foreach cond ( ${reg_list[*]} )
		# set pfx = stim-$cond
		# set pfx = `echo ${pfx:s/./_r/} `
		# set pfx = `echo ${pfx:s/F/1/} `
		# set pfx = `echo ${pfx:s/S/2/} `
		# set pfx = `echo ${pfx:s/T/3/} `
		# tcsh exe_3dttest++.sh $out_dir/$pfx.ttest $cond $ssfn $stat
		# tcsh exe_3dMEMA.sh $out_dir/$pfx.MEMA $cond $ssfn $stat
	# end

	# ## one-sample t-tests for "-glt" outputs:
	# foreach sufx ( ${glt_sufxs[*]} )
		# foreach stim ( 1st 2nd 3rd )
			# set pfx = ${stim}_${sufx}
			# set glt = ${stim}.${sufx}
			# tcsh exe_3dttest++.sh $out_dir/$pfx.ttest ${glt}_GLT $ssfn $stat
			# tcsh exe_3dMEMA.sh $out_dir/$pfx.MEMA $glt $ssfn $stat				
		# end	
	# end

	## paired t-tests:
	foreach sufx ( ${glt_sufxs[*]} )
		tcsh exe_paired-ttest.sh $out_dir/1.vs.2_${sufx} 1st.${sufx}_GLT 2nd.${sufx}_GLT $ssfn $stat
		tcsh exe_paired-ttest.sh $out_dir/1.vs.3_${sufx} 1st.${sufx}_GLT 3rd.${sufx}_GLT $ssfn $stat
		tcsh exe_paired-ttest.sh $out_dir/2.vs.3_${sufx} 2nd.${sufx}_GLT 3rd.${sufx}_GLT $ssfn $stat
	end
end