#!/usr/bin/env tcsh
# tcsh Make_func_masks.sh

set make_t1_masks = 'no'

set ss_ver = 'runs_MNI_3ord_v3'
# set ss_ver = 'runs_MNI_3ord_v2'
set reml = '_REML'

set SIDE = '1pos' # '2sid'
set FPR = '05perc'
set FOLDER = $SIDE.$FPR$reml
set FILENAME = 'conj-all_r2-9' # 'Clust-merge_1+2+3_r2-9'

set grp_top = /media/data2/pinwei/SL_hippocampus/Combined_group
set roimask_dir = $grp_top/derivatives/group_ROImasks
set data_dir = $grp_top/derivatives/Group_analysis/ap.$ss_ver/ClustSim+ETAC/$FOLDER/Conjunctions
set out_dir = $data_dir/../'Clust_merge'
if ( ! -d $out_dir ) mkdir -p $out_dir
set grp_mask_list = () # Initialize, to capture file paths of group functional masks

set PREFIX = $out_dir/$FILENAME
set COUNT_OUT = $out_dir/ABoverlap_$FILENAME.tsv
set col_names = ( \
	'ROI' 'A' 'B' 'union' 'inter' 'A_not_B' 'B_not_A'     \
	'perc_A_not_B' 'perc_B_not_A' 'Rx_BA' 'Ry_BA' 'Rz_BA' \
)
echo $col_names > $COUNT_OUT

## Merge any activated cluster across all exposure runs:
3dmask_tool -overwrite                        \
	-input $data_dir/ConjAna_run-??+tlrc.HEAD \
	-prefix $PREFIX                           \
	-union -fill_holes -NN3
	
3dcopy -overwrite ${PREFIX}+tlrc ${PREFIX}.nii.gz
set grp_mask_list = ( $grp_mask_list ${PREFIX}.nii.gz )

# foreach roi ( 'Hippocampus' 'MTL' 'Hipp+MTL' 'Visual' 'Striatal' )
foreach roi ( `cat roiList.txt` )

	## Check if overlap:
	set ABoverlap = `3dABoverlap -quiet ${PREFIX}+tlrc \
						$roimask_dir/group-roimask_${roi}_resam+tlrc`
	set A_and_B = `echo $ABoverlap | awk '{print $4}'`
	
	## Crop within specific ROI(s):
	if ( $A_and_B != 0 ) then
		echo $roi' '$ABoverlap >> $COUNT_OUT
		
		3dmask_tool -overwrite                                    \
			-input ${PREFIX}+tlrc.HEAD                            \
				$roimask_dir/group-roimask_${roi}_resam+tlrc.HEAD \
			-prefix ${PREFIX}_${roi}                              \
			-inter
		
		3dcopy -overwrite ${PREFIX}_${roi}+tlrc ${PREFIX}_${roi}.nii.gz
		
		set grp_mask_list = ( $grp_mask_list ${PREFIX}_${roi}.nii.gz )
	endif
end	

## Transform to subjects' native space:
if ( $make_t1_masks != 'no' ) then

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
		set prep_dir = $top_dir/derivatives/fmriprep_fmap_RL
		
		foreach subj ( $subj_list )
			set anat_dir = $prep_dir/$subj/anat
			set func_dir = $prep_dir/$subj/func
			set mni = MNI152NLin2009cAsym
			
			foreach grp_mask ( ${grp_mask_list[*]} )
				set out_fn = `basename $grp_mask`
				set out_fn = `echo $out_fn | sed "s/.nii.gz/_T1w.nii.gz/g"`
				
				if ( ! -f $anat_dir/ROImasks/$out_fn )
					antsApplyTransforms \
						-d 3 -n nearestNeighbor                                   \
						-i $grp_mask                                              \
						-r $func_dir/Masks/${subj}_all-runs_space-T1w_mask.nii.gz \
						-t $anat_dir/${subj}_from-${mni}_to-T1w_mode-image_xfm.h5 \
						-o $anat_dir/ROImasks/$out_fn
				endif
			end
			
			# # TEMP: to generate the (down-sampled) whole-brain masks, execute:
			# foreach space ( T1w $mni )
				# set anat_mask = $anat_dir/${subj}_space-${space}_desc-brain_mask.nii.gz
				# if ( $space == T1w ) set anat_mask = $anat_dir/${subj}_desc-brain_mask.nii.gz
				# set bold_mask = $func_dir/Masks/${subj}_all-runs_space-${space}_mask.nii.gz
				
				# 3dresample -overwrite  \
					# -master $bold_mask \
					# -prefix $anat_dir/mask_space-${space}_resam.nii.gz \
					# -input $anat_mask  \
					# -rmode NN
			# end
		end
	end
endif

## Save the name of all group functional ROI masks to file:
set cwd = `pwd`
set gfunc_txt = $grp_top/code/"roiList_gfunc_ap.${ss_ver}${reml}.txt"
if ( -f $gfunc_txt ) rm $gfunc_txt
cd $data_dir
ls ${FILENAME}_*.nii.gz | sed "s|${FILENAME}_||g" | sed "s|.nii.gz||g" > $gfunc_txt
cd $cwd

# ===============================================================================
    # #A         = number of voxels in the A mask
    # #B         = number of voxels in the B mask
    # #(A uni B) = number of voxels in the either or both masks (set union)
    # #(A int B) = number of voxels present in BOTH masks (set intersection)
    # #(A \ B)   = number of voxels in A mask that aren't in B mask
    # #(B \ A)   = number of voxels in B mask that aren't in A mask
    # %(A \ B)   = percentage of voxels from A mask that aren't in B mask
    # %(B \ A)   = percentage of voxels from B mask that aren't in A mask
    # Rx(B/A)    = radius of gyration of B mask / A mask, in x direction
    # Ry(B/A)    = radius of gyration of B mask / A mask, in y direction
    # Rz(B/A)    = radius of gyration of B mask / A mask, in z direction
	
