#!/usr/bin/env tcsh

set grp_top = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis
set olay_fn = $1
set out_pfx = $2
set side = $3

switch ( $side )
	case '1sided':
		set cbar = "Spectrum:yellow_to_red"
		# set cbar = "red_monochrome"
		set pos_only = '' # '-pbar_posonly'
		breaksw
	case 'bisided':
		# set cbar = "Spectrum:red_to_blue"
		set cbar = "Reds_and_Blues"
		set pos_only = '' # '-pbar_posonly'
		breaksw
endsw

@chauffeur_afni                                       \
	-ulay $grp_top/MNI152NLin2009cAsym_T1+tlrc        \
	-edgy_ulay                                        \
	-box_focus_slices $grp_top/group_func_mask+tlrc   \
	-olay $olay_fn                                    \
	-obl_resam_olay cubic                             \
	-obl_resam_box cubic                              \
	-opacity 9                                        \
    -cbar $cbar                                       \
	$pos_only                                         \
	-pbar_saveim $out_pfx.colorbar.jpg                \
	-pbar_dim '32x512'                                \
	-prefix $out_pfx                                  \
	-set_xhairs OFF                                   \
	-montx 5 -monty 5                                 \
	-label_mode 1 -label_size 4

# 