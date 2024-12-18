#!/usr/bin/env tcsh

set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = $top_dir/Combined_group/derivatives/WholeBrain
set mask_fn = $grp_dir/group_mask+tlrc

set mvm_dir = $1
set desc = $2
set resid_fn = $mvm_dir/${desc}_resid+tlrc

set acf_outdir = $mvm_dir/files_ACF
if ( ! -d $acf_outdir ) mkdir $acf_outdir

set csim_outdir = $mvm_dir/files_ClustSim
if ( ! -d $csim_outdir ) mkdir $csim_outdir

## Estimate noise smoothness values: 
set blur_estm_fn = $mvm_dir/blur.resid.$desc.1D

3dFWHMx -overwrite   \
	-mask $mask_fn   \
	-input $resid_fn \
	-ACF $acf_outdir/out.3dFWHMx.ACF.$desc.1D \
		> $blur_estm_fn

set params = ( `tail -n 1 $blur_estm_fn` )

## Generate cluster-size threshold tables with 3dClustSim 
3dClustSim -overwrite \
	-both             \
	-mask $mask_fn    \
	-acf $params[1-3] \
	-iter 10000		  \
	-cmd $csim_outdir/3dClustSim.ACF.$desc.cmd \
	-prefix $csim_outdir/ClustSim.ACF.$desc

## run 3drefit to attach 3dClustSim results to stats
set cmd = ( `cat $csim_outdir/3dClustSim.ACF.$desc.cmd` )
$cmd $mvm_dir/${desc}+tlrc