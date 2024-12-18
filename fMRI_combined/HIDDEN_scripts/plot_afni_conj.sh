#!/usr/bin/env tcsh

set grp_top = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis
set olay_fn = $1
set out_pfx = $2

@chauffeur_afni                                       \
	-ulay $grp_top/MNI152NLin2009cAsym_T1+tlrc        \
	-edgy_ulay                                        \
	-box_focus_slices $grp_top/group_func_mask+tlrc   \
	-olay $olay_fn                                    \
	-obl_resam_olay cubic                             \
	-obl_resam_box cubic                              \
	-func_range 7                                     \
	-cbar_ncolors 7                                   \
	-cbar_topval EMPTY                                \
	-cbar "7=blue 6=violet 5=orange 4=red 3=green 2=cyan 1=yellow 0=none" \
	-pbar_posonly                                     \
	-opacity 9                                        \
	-pbar_saveim $out_pfx.colorbar.jpg                \
	-pbar_dim '32x512'                                \
	-prefix $out_pfx                                  \
	-set_xhairs OFF                                   \
	-montx 5 -monty 5                                 \
	-label_mode 1 -label_size 4                           