# #!/usr/bin/env tcsh

# # tcsh Make_ttest+ETAC_reports.sh

# set ss_ver = 'runs_MNI_3ord_v5'
# set reml = '_REML' # ''

# set NAME = 'ttest.1sided'
# set SIDE = '1pos'
# set FPR = '05perc'

# set atlas = 'FS.afni.MNI2009c_asym'

# set top_dir = /media/data2/pinwei/SL_hippocampus
# set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain
# set etac_dir = $grp_dir/ap.$ss_ver/ClustSim+ETAC

# set out_dir = $etac_dir/Together
# if ( ! -d $out_dir ) mkdir -p $out_dir
# if ( ! -d $out_dir/$atlas ) mkdir $out_dir/$atlas

# foreach run ( `seq -f "run-%02g" 2 9` )
	# set data_dir = $etac_dir/$run
	
	# foreach cond ( 'Fst' 'Snd' 'Trd' )	
	
		# set PREFIX = ${cond}${reml}		
		# set stat_dat = $data_dir/${PREFIX}.ttest+tlrc
		# set ETAC_mask = $data_dir/${PREFIX}.${NAME}.ETACmask.global.${SIDE}.${FPR}.nii.gz
		
		# set out_prefix = ${run}_${cond}${reml}_${SIDE}.${FPR}
		
		# ## Mask data with ETAC threshold --------------------------------------------------------
		
		# 3dcalc -a "${stat_dat}[0]" -b $ETAC_mask -expr 'a*step(b)' \
			# -prefix $out_dir/${out_prefix}_ttest.mean
			
		# 3dcalc -a "${stat_dat}[1]" -b $ETAC_mask -expr 'a*step(b)' \
			# -prefix $out_dir/${out_prefix}_ttest.Zscr
		
		# ## Get overlap with ROI (Intersection with atlas) ---------------------------------------
		
	# end	
# end