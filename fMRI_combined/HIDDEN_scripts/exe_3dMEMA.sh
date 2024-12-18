#!/usr/bin/env tcsh

set out_file = $argv[1]
set condA = $argv[2]

set sdir_1 = /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/$argv[3]
set sdir_2 = /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out/$argv[3]
set stats_fn = $argv[4]

3dMEMA -overwrite \
	-prefix $out_file     \
	-jobs 12                 \
	-mask ../derivatives/Group_analysis/group_mask+tlrc \
	-missing_data 0          \
	-HKtest                  \
	-dbgArgs                 \
	-set $cond               \
sub-02 ${sdir_1}/sub-02.results/${stats_fn}.sub-02_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-02.results/${stats_fn}.sub-02_REML+tlrc'['$cond'#0_Tstat]'  \
sub-03 ${sdir_1}/sub-03.results/${stats_fn}.sub-03_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-03.results/${stats_fn}.sub-03_REML+tlrc'['$cond'#0_Tstat]'  \
sub-04 ${sdir_1}/sub-04.results/${stats_fn}.sub-04_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-04.results/${stats_fn}.sub-04_REML+tlrc'['$cond'#0_Tstat]'  \
sub-05 ${sdir_1}/sub-05.results/${stats_fn}.sub-05_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-05.results/${stats_fn}.sub-05_REML+tlrc'['$cond'#0_Tstat]'  \
sub-06 ${sdir_1}/sub-06.results/${stats_fn}.sub-06_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-06.results/${stats_fn}.sub-06_REML+tlrc'['$cond'#0_Tstat]'  \
sub-07 ${sdir_1}/sub-07.results/${stats_fn}.sub-07_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-07.results/${stats_fn}.sub-07_REML+tlrc'['$cond'#0_Tstat]'  \
sub-08 ${sdir_1}/sub-08.results/${stats_fn}.sub-08_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-08.results/${stats_fn}.sub-08_REML+tlrc'['$cond'#0_Tstat]'  \
sub-09 ${sdir_1}/sub-09.results/${stats_fn}.sub-09_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-09.results/${stats_fn}.sub-09_REML+tlrc'['$cond'#0_Tstat]'  \
sub-10 ${sdir_1}/sub-10.results/${stats_fn}.sub-10_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-10.results/${stats_fn}.sub-10_REML+tlrc'['$cond'#0_Tstat]'  \
sub-11 ${sdir_1}/sub-11.results/${stats_fn}.sub-11_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-11.results/${stats_fn}.sub-11_REML+tlrc'['$cond'#0_Tstat]'  \
sub-12 ${sdir_1}/sub-12.results/${stats_fn}.sub-12_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-12.results/${stats_fn}.sub-12_REML+tlrc'['$cond'#0_Tstat]'  \
sub-101 ${sdir_2}/sub-101.results/${stats_fn}.sub-101_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-101.results/${stats_fn}.sub-101_REML+tlrc'['$cond'#0_Tstat]'  \
sub-102 ${sdir_2}/sub-102.results/${stats_fn}.sub-102_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-102.results/${stats_fn}.sub-102_REML+tlrc'['$cond'#0_Tstat]'  \
sub-104 ${sdir_2}/sub-104.results/${stats_fn}.sub-104_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-104.results/${stats_fn}.sub-104_REML+tlrc'['$cond'#0_Tstat]'  \
sub-105 ${sdir_2}/sub-105.results/${stats_fn}.sub-105_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-105.results/${stats_fn}.sub-105_REML+tlrc'['$cond'#0_Tstat]'  \
sub-106 ${sdir_2}/sub-106.results/${stats_fn}.sub-106_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-106.results/${stats_fn}.sub-106_REML+tlrc'['$cond'#0_Tstat]'  \
sub-107 ${sdir_2}/sub-107.results/${stats_fn}.sub-107_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-107.results/${stats_fn}.sub-107_REML+tlrc'['$cond'#0_Tstat]'  \
sub-108 ${sdir_2}/sub-108.results/${stats_fn}.sub-108_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-108.results/${stats_fn}.sub-108_REML+tlrc'['$cond'#0_Tstat]'  \
sub-109 ${sdir_2}/sub-109.results/${stats_fn}.sub-109_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-109.results/${stats_fn}.sub-109_REML+tlrc'['$cond'#0_Tstat]'  \
sub-110 ${sdir_2}/sub-110.results/${stats_fn}.sub-110_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-110.results/${stats_fn}.sub-110_REML+tlrc'['$cond'#0_Tstat]'  \
sub-111 ${sdir_2}/sub-111.results/${stats_fn}.sub-111_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-111.results/${stats_fn}.sub-111_REML+tlrc'['$cond'#0_Tstat]'  \
sub-112 ${sdir_2}/sub-112.results/${stats_fn}.sub-112_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-112.results/${stats_fn}.sub-112_REML+tlrc'['$cond'#0_Tstat]'  \
sub-113 ${sdir_2}/sub-113.results/${stats_fn}.sub-113_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-113.results/${stats_fn}.sub-113_REML+tlrc'['$cond'#0_Tstat]'  \
sub-114 ${sdir_2}/sub-114.results/${stats_fn}.sub-114_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-114.results/${stats_fn}.sub-114_REML+tlrc'['$cond'#0_Tstat]'  \
sub-115 ${sdir_2}/sub-115.results/${stats_fn}.sub-115_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-115.results/${stats_fn}.sub-115_REML+tlrc'['$cond'#0_Tstat]'  \
sub-116 ${sdir_2}/sub-116.results/${stats_fn}.sub-116_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-116.results/${stats_fn}.sub-116_REML+tlrc'['$cond'#0_Tstat]'  \
sub-117 ${sdir_2}/sub-117.results/${stats_fn}.sub-117_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-117.results/${stats_fn}.sub-117_REML+tlrc'['$cond'#0_Tstat]'  \
sub-118 ${sdir_2}/sub-118.results/${stats_fn}.sub-118_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-118.results/${stats_fn}.sub-118_REML+tlrc'['$cond'#0_Tstat]'  \
sub-119 ${sdir_2}/sub-119.results/${stats_fn}.sub-119_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-119.results/${stats_fn}.sub-119_REML+tlrc'['$cond'#0_Tstat]'  \
sub-120 ${sdir_2}/sub-120.results/${stats_fn}.sub-120_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-120.results/${stats_fn}.sub-120_REML+tlrc'['$cond'#0_Tstat]'  \
sub-121 ${sdir_2}/sub-121.results/${stats_fn}.sub-121_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-121.results/${stats_fn}.sub-121_REML+tlrc'['$cond'#0_Tstat]'  \
sub-122 ${sdir_2}/sub-122.results/${stats_fn}.sub-122_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-122.results/${stats_fn}.sub-122_REML+tlrc'['$cond'#0_Tstat]'  \
sub-123 ${sdir_2}/sub-123.results/${stats_fn}.sub-123_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-123.results/${stats_fn}.sub-123_REML+tlrc'['$cond'#0_Tstat]'  \
sub-124 ${sdir_2}/sub-124.results/${stats_fn}.sub-124_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-124.results/${stats_fn}.sub-124_REML+tlrc'['$cond'#0_Tstat]'  \
sub-125 ${sdir_2}/sub-125.results/${stats_fn}.sub-125_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-125.results/${stats_fn}.sub-125_REML+tlrc'['$cond'#0_Tstat]'  \
sub-126 ${sdir_2}/sub-126.results/${stats_fn}.sub-126_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-126.results/${stats_fn}.sub-126_REML+tlrc'['$cond'#0_Tstat]'  \
sub-127 ${sdir_2}/sub-127.results/${stats_fn}.sub-127_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-127.results/${stats_fn}.sub-127_REML+tlrc'['$cond'#0_Tstat]'  

