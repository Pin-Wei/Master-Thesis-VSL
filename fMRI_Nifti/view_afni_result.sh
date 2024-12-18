#!/usr/bin/tcsh -xef

set datdir = $1.results

afni $datdir/{$1}_space-MNI152NLin2009cAsym_desc-preproc_T1w+tlrc. \
	$datdir/stats.{$1}_REML+tlrc. \
	$datdir/stats.{$1}+tlrc.

