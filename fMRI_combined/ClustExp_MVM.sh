#!/usr/bin/env tcsh

# tcsh ClustExp_MVM.sh $GET_READY
set GET_READY = $1

set ss_ver = 'runs_MNI_3ord_v6'
set reml = '_REML'

set add_name = '_score' # others: '' '_add' '_add2' '_add3'
set mask_type = 0       # see below
set table_type = 1      # see below

set p_uncor = 0.001
set alpha = 0.05
set side = 'bisided'
set nn = 3 

set atlas = 'FS.afni.MNI2009c_asym' # others: '' 'Julich_MNI2009c'
	
## ----------------------------------------------------------------------------------------------

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain
set data_dir = $grp_dir/ap.$ss_ver/MVM
set now_dir = `pwd`

set out_dir = $grp_dir/ap.$ss_ver/MVM/ClustExp_${desc}
if ( ! -d $out_dir ) mkdir -p $out_dir

switch ( $mask_type )
	case 0: 
		set desc = 'wholebrain_3way'${reml}${add_name}
		breaksw
	case 1:
		set desc = 'masked_3way'${reml}${add_name}
		breaksw
	case 2:	
		set desc = 'masked.2sid_3way'${reml}${add_name}
		breaksw
endsw

switch ( $table_type )
	case 0:
		set hist_table = $data_dir/dataTable_3ord_LearnOrNot${reml}.tsv
		breaksw
	case 1:	
		set hist_table = $data_dir/dataTable_3ord_Score${reml}.tsv
		breaksw
endsw

## ----------------------------------------------------------------------------------------------

if ( $GET_READY == 0 ) then
	3dinfo -subbrick_info $data_dir/${desc}+tlrc
	
else
	if ( $add_name == '_score' ) then
		set value_sb_list = ( 1 8 9 10 11 12 13 22 24 26 28 30 32 34 36 54 56 58 60 61 )
		set thres_sb_list = ( 1 8 9 10 11 12 13 23 25 27 29 31 33 35 37 55 57 59 60 61 )
		set cond_namelist = ( \
			'F_Score'                       \
			'F.SC_Run'                      \
			'F.SC_Score_x_Run'              \
			'F.SC_Order'                    \
			'F.SC_Score_x_Order'            \
			'F.SC_Run_x_Order'              \
			'F.SC_Score_x_Run_x_Order'      \
			'GLT_Score_x_Fst'               \
			'GLT_Score_x_Snd'               \
			'GLT_Score_x_Trd'               \
			'post.hoc_Score_x_1_vs_2'       \
			'post.hoc_Score_x_2_vs_3'       \
			'post.hoc_Score_x_3_vs_1'       \
			'GLT_Score_x_12_vs_3'           \
			'GLT_Score_x_23_vs_1'           \
			'GLT_Score_x_Fst_lin.decay'     \
			'GLT_Score_x_Snd_lin.decay'     \
			'GLT_Score_x_Trd_lin.decay'     \
			'GLF_Score_x_12_vs_3_lin.decay' \
			'GLF_Score_x_23_vs_1_lin.decay' \
		)
	else 
		# set value_sb_list = ( 15 16 17 18 19 20 21 ) # ges
		set value_sb_list = ( 1 8 9 10 11 12 13 )
		set thres_sb_list = ( 1 8 9 10 11 12 13 )
		set cond_namelist = (      \
			'Group_F'              \
			'Run_F.SC'             \
			'Group.Run_F.SC'       \
			'Order_F.SC'           \
			'Group.Order_F.SC'     \
			'Run.Order_F.SC'       \
			'Group.Run.Order_F.SC' \
		)
	endif

	# ===========================================================================================

	set dset_table = $out_dir/data_Table.1D # modified table

	if ( ! -f $dset_table ) then
		foreach label ( 'Subj' 'InputFile' )
			awk -F '\t' -v col=$label \
				'NR == 1 {for (i=1; i<=NF; i++) {if ($i==col) {c=i; break}}} NR > 1 {print $c}' \
				$hist_table > tmp.$label.1D
		end
		
		paste tmp.Subj.1D tmp.InputFile.1D > $dset_table
	endif

	# -------------------------------------------------------------------------------------------

	set subj_dcat = $out_dir/data_allSubj.nii.gz 
		# concatenated dataset (with each subbrik labeled with a subject ID)

	if ( ! -f $subj_dcat ) then
		@ClustExp_CatLab -input $dset_table -prefix $subj_dcat
	endif
	
	## see: https://discuss.afni.nimh.nih.gov/t/clustexp-catlab/3635/3
	if ( ! -f $subj_dcat ) then	
		sed 's/\/media\/data2\/pinwei\/SL_hippocampus/\./g' tmp.InputFile.1D > tmp.InputFile_2.1D
		paste tmp.Subj.1D tmp.InputFile_2.1D > $dset_table
		
		cd $top_dir	
		@ClustExp_CatLab -input $dset_table -prefix $subj_dcat
		
		cd $now_dir
	endif

	# -------------------------------------------------------------------------------------------

	set subj_table = $out_dir/data_Table_3col.1D 
		# 1st column: Subject ID
		# 2nd column: Data set and current location path
		# 3rd column: Data set and path at the time of running the analysis (to match the history)
		
	if ( ! -f $subj_table ) then
		awk -F '\t' -v col='InputFile' \
			'NR == 1 {for (i=1; i<=NF; i++) {if ($i==col) {c=i; break}}} NR > 1 {print $c}' \
			$hist_table > tmp.1D
			
		paste $dset_table tmp.1D > $subj_table
			# since we always use absolute path, just paste it again
	endif

	# -------------------------------------------------------------------------------------------

	set script_name = HIDDEN_scripts/read_and_print_cluster_threshold.py
	set n_vox = `python $script_name        \
		--file_dir $data_dir/files_ClustSim \
		--csim_prefix ClustSim.ACF.${desc} 	\
		--NN $nn --side $side --p_val $p_uncor --alpha $alpha`

	set record_txt = $out_dir/voxel_thres_is_${n_vox}.txt
	if ( ! -f $record_txt ) then
		echo '++ find ClustSim threshold with: '$script_name > $record_txt
		echo '++ name of ClustSim threshold file: ClustSim.ACF.'$desc >> $record_txt
		echo '++ uncorrected (per voxel) p-value threshold: '$p_uncor >> $record_txt
		echo '++ corrected (whole volume) alpha threshold: '$alpha >> $record_txt
		echo '++ type of thresholding: '$side >> $record_txt 	
		echo '++ level of nearest neighbor (NN): '$nn >> $record_txt
		echo '++ voxel threshold is: '$n_vox >> $record_txt
	endif
	
	foreach x ( `seq 1 1 ${#cond_namelist}` )
		set cond = ${cond_namelist[$x]}
		
		if (( ! -d $out_dir/$cond ) && ( ! -d $out_dir/'#NO_CLUSTER__'$cond )) then
			set sb_1 = ${value_sb_list[$x]}
			set sb_2 = ${thres_sb_list[$x]}
			
			python HIDDEN_scripts/my_ClustExp_StatParse.py \
				-overwrite -NoShiny               \
				-MVM_dataTable $hist_table 	      \
				-SubjTable $subj_table 		      \
				-master $grp_dir/MNI152NLin2009cAsym_T1+tlrc \
				-SubjDSET $subj_dcat 		      \
				-StatDSET $data_dir/${desc}+tlrc  \
				-MeanBrik $sb_1 -ThreshBrik $sb_2 \
				-p $p_uncor -MinVox $n_vox 	      \
				-atlas $atlas                     \
				-session $out_dir -prefix $cond
		
			set cluster_mask = $out_dir/${cond}_ClustExp/${cond}_p_uncor_${p_uncor}_mask.nii.gz
		
			if ( -f $cluster_mask ) then
				mv $out_dir/${cond}_ClustExp $out_dir/$cond
			else
				mv $out_dir/${cond}_ClustExp $out_dir/'#NO_CLUSTER__'${cond}
			endif
		endif
		
		if ( -d $out_dir/$cond ) then
			set cluster_table = $out_dir/$cond/${cond}_p_uncor_3dClust.1D
			
			
			set cluster_mask = $out_dir/$cond/${cond}_p_uncor_${p_uncor}_mask.nii.gz
			
			set whereami_report = $out_dir/$atlas/${FILEAME}_whereami.csv
		endif
	end

	rm tmp.*
	rm *_delete_me*
endif

## ==========================================================================================
## introduction: https://github.com/afni/afni/tree/master/src/discoraj/ClusterExplorer
## location: /usr/local/abin (check more: afni_system_check.py -check_all)

## Output files from ClustExp_StatParse.py (with -NoShiny option):
#	- {PREFIX}_p_uncor_{P_VAL}_3dClust.1D:
#		Output directly from 3dclust with orientation of LPI.
#	- {PREFIX}_p_uncor_{P_VAL}.nii.gz:
#		A new data set from your input statistics data set, 
#		thresholded at your uncorrected p value using the selected subbriks.
#	- {PREFIX}_p_uncor_{P_VAL}_mask.nii.gz:
#		An integer labeled mask of the above image
#		with cluster sizes at least as big as the -MinVox 
#	- {PREFIX}_master.nii.gz:
#		A NIfTI copy of the master file provided that may have been resampled.
#		Generate for the shiny app.

## see more AFNI's atlas in: /usr/local/abin/AFNI_atlas_spaces.niml
## Brainnetome_1.0: https://pubmed.ncbi.nlm.nih.gov/27230218/

