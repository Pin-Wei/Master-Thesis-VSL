#!/usr/bin/env tcsh

set out_file = $argv[2]
set condA = $argv[3]

set sdir_1 = /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/$argv[4]
set sdir_2 = /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out/$argv[4]
set run = $argv[5]

if ( $#argv >= 6 ) then
	set reml = $argv[6]
else
	set reml = ''
endif

3dttest++ -overwrite \
	-prefix $out_file \
	-mask $argv[1] \
	-setA $condA \
		sub-02 "${sdir_1}/sub-02_r${run}.results/stats.sub-02${reml}+tlrc[$condA#0_Coef]"  \
		sub-03 "${sdir_1}/sub-03_r${run}.results/stats.sub-03${reml}+tlrc[$condA#0_Coef]"  \
		sub-04 "${sdir_1}/sub-04_r${run}.results/stats.sub-04${reml}+tlrc[$condA#0_Coef]"  \
		sub-05 "${sdir_1}/sub-05_r${run}.results/stats.sub-05${reml}+tlrc[$condA#0_Coef]"  \
		sub-06 "${sdir_1}/sub-06_r${run}.results/stats.sub-06${reml}+tlrc[$condA#0_Coef]"  \
		sub-07 "${sdir_1}/sub-07_r${run}.results/stats.sub-07${reml}+tlrc[$condA#0_Coef]"  \
		sub-08 "${sdir_1}/sub-08_r${run}.results/stats.sub-08${reml}+tlrc[$condA#0_Coef]"  \
		sub-09 "${sdir_1}/sub-09_r${run}.results/stats.sub-09${reml}+tlrc[$condA#0_Coef]"  \
		sub-10 "${sdir_1}/sub-10_r${run}.results/stats.sub-10${reml}+tlrc[$condA#0_Coef]"  \
		sub-11 "${sdir_1}/sub-11_r${run}.results/stats.sub-11${reml}+tlrc[$condA#0_Coef]"  \
		sub-12 "${sdir_1}/sub-12_r${run}.results/stats.sub-12${reml}+tlrc[$condA#0_Coef]"  \
		sub-101 "${sdir_2}/sub-101_r${run}.results/stats.sub-101${reml}+tlrc[$condA#0_Coef]"  \
		sub-102 "${sdir_2}/sub-102_r${run}.results/stats.sub-102${reml}+tlrc[$condA#0_Coef]"  \
		sub-104 "${sdir_2}/sub-104_r${run}.results/stats.sub-104${reml}+tlrc[$condA#0_Coef]"  \
		sub-105 "${sdir_2}/sub-105_r${run}.results/stats.sub-105${reml}+tlrc[$condA#0_Coef]"  \
		sub-106 "${sdir_2}/sub-106_r${run}.results/stats.sub-106${reml}+tlrc[$condA#0_Coef]"  \
		sub-107 "${sdir_2}/sub-107_r${run}.results/stats.sub-107${reml}+tlrc[$condA#0_Coef]"  \
		sub-108 "${sdir_2}/sub-108_r${run}.results/stats.sub-108${reml}+tlrc[$condA#0_Coef]"  \
		sub-109 "${sdir_2}/sub-109_r${run}.results/stats.sub-109${reml}+tlrc[$condA#0_Coef]"  \
		sub-110 "${sdir_2}/sub-110_r${run}.results/stats.sub-110${reml}+tlrc[$condA#0_Coef]"  \
		sub-111 "${sdir_2}/sub-111_r${run}.results/stats.sub-111${reml}+tlrc[$condA#0_Coef]"  \
		sub-112 "${sdir_2}/sub-112_r${run}.results/stats.sub-112${reml}+tlrc[$condA#0_Coef]"  \
		sub-113 "${sdir_2}/sub-113_r${run}.results/stats.sub-113${reml}+tlrc[$condA#0_Coef]"  \
		sub-114 "${sdir_2}/sub-114_r${run}.results/stats.sub-114${reml}+tlrc[$condA#0_Coef]"  \
		sub-115 "${sdir_2}/sub-115_r${run}.results/stats.sub-115${reml}+tlrc[$condA#0_Coef]"  \
		sub-116 "${sdir_2}/sub-116_r${run}.results/stats.sub-116${reml}+tlrc[$condA#0_Coef]"  \
		sub-117 "${sdir_2}/sub-117_r${run}.results/stats.sub-117${reml}+tlrc[$condA#0_Coef]"  \
		sub-118 "${sdir_2}/sub-118_r${run}.results/stats.sub-118${reml}+tlrc[$condA#0_Coef]"  \
		sub-119 "${sdir_2}/sub-119_r${run}.results/stats.sub-119${reml}+tlrc[$condA#0_Coef]"  \
		sub-120 "${sdir_2}/sub-120_r${run}.results/stats.sub-120${reml}+tlrc[$condA#0_Coef]"  \
		sub-121 "${sdir_2}/sub-121_r${run}.results/stats.sub-121${reml}+tlrc[$condA#0_Coef]"  \
		sub-122 "${sdir_2}/sub-122_r${run}.results/stats.sub-122${reml}+tlrc[$condA#0_Coef]"  \
		sub-123 "${sdir_2}/sub-123_r${run}.results/stats.sub-123${reml}+tlrc[$condA#0_Coef]"  \
		sub-124 "${sdir_2}/sub-124_r${run}.results/stats.sub-124${reml}+tlrc[$condA#0_Coef]"  \
		sub-125 "${sdir_2}/sub-125_r${run}.results/stats.sub-125${reml}+tlrc[$condA#0_Coef]"  \
		sub-126 "${sdir_2}/sub-126_r${run}.results/stats.sub-126${reml}+tlrc[$condA#0_Coef]"  \
		sub-127 "${sdir_2}/sub-127_r${run}.results/stats.sub-127${reml}+tlrc[$condA#0_Coef]"  
