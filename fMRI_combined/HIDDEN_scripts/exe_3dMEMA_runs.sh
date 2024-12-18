#!/usr/bin/env tcsh

set out_file = $argv[2]
set cond = $argv[3]

set sdir_1 = /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/$argv[4]
set sdir_2 = /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out/$argv[4]
set run = $argv[5]

3dMEMA -overwrite \
	-prefix $out_file        \
	-jobs 12                 \
	-mask $argv[1]			 \
	-missing_data 0          \
	-HKtest                  \
	-dbgArgs                 \
	-set $cond               \
sub-02 ${sdir_1}/sub-02_r${run}.results/stats.sub-02_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-02_r${run}.results/stats.sub-02_REML+tlrc'['$cond'#0_Tstat]'  \
sub-03 ${sdir_1}/sub-03_r${run}.results/stats.sub-03_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-03_r${run}.results/stats.sub-03_REML+tlrc'['$cond'#0_Tstat]'  \
sub-04 ${sdir_1}/sub-04_r${run}.results/stats.sub-04_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-04_r${run}.results/stats.sub-04_REML+tlrc'['$cond'#0_Tstat]'  \
sub-05 ${sdir_1}/sub-05_r${run}.results/stats.sub-05_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-05_r${run}.results/stats.sub-05_REML+tlrc'['$cond'#0_Tstat]'  \
sub-06 ${sdir_1}/sub-06_r${run}.results/stats.sub-06_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-06_r${run}.results/stats.sub-06_REML+tlrc'['$cond'#0_Tstat]'  \
sub-07 ${sdir_1}/sub-07_r${run}.results/stats.sub-07_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-07_r${run}.results/stats.sub-07_REML+tlrc'['$cond'#0_Tstat]'  \
sub-08 ${sdir_1}/sub-08_r${run}.results/stats.sub-08_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-08_r${run}.results/stats.sub-08_REML+tlrc'['$cond'#0_Tstat]'  \
sub-09 ${sdir_1}/sub-09_r${run}.results/stats.sub-09_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-09_r${run}.results/stats.sub-09_REML+tlrc'['$cond'#0_Tstat]'  \
sub-10 ${sdir_1}/sub-10_r${run}.results/stats.sub-10_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-10_r${run}.results/stats.sub-10_REML+tlrc'['$cond'#0_Tstat]'  \
sub-11 ${sdir_1}/sub-11_r${run}.results/stats.sub-11_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-11_r${run}.results/stats.sub-11_REML+tlrc'['$cond'#0_Tstat]'  \
sub-12 ${sdir_1}/sub-12_r${run}.results/stats.sub-12_REML+tlrc'['$cond'#0_Coef]' ${sdir_1}/sub-12_r${run}.results/stats.sub-12_REML+tlrc'['$cond'#0_Tstat]'  \
sub-101 ${sdir_2}/sub-101_r${run}.results/stats.sub-101_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-101_r${run}.results/stats.sub-101_REML+tlrc'['$cond'#0_Tstat]'  \
sub-102 ${sdir_2}/sub-102_r${run}.results/stats.sub-102_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-102_r${run}.results/stats.sub-102_REML+tlrc'['$cond'#0_Tstat]'  \
sub-104 ${sdir_2}/sub-104_r${run}.results/stats.sub-104_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-104_r${run}.results/stats.sub-104_REML+tlrc'['$cond'#0_Tstat]'  \
sub-105 ${sdir_2}/sub-105_r${run}.results/stats.sub-105_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-105_r${run}.results/stats.sub-105_REML+tlrc'['$cond'#0_Tstat]'  \
sub-106 ${sdir_2}/sub-106_r${run}.results/stats.sub-106_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-106_r${run}.results/stats.sub-106_REML+tlrc'['$cond'#0_Tstat]'  \
sub-107 ${sdir_2}/sub-107_r${run}.results/stats.sub-107_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-107_r${run}.results/stats.sub-107_REML+tlrc'['$cond'#0_Tstat]'  \
sub-108 ${sdir_2}/sub-108_r${run}.results/stats.sub-108_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-108_r${run}.results/stats.sub-108_REML+tlrc'['$cond'#0_Tstat]'  \
sub-109 ${sdir_2}/sub-109_r${run}.results/stats.sub-109_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-109_r${run}.results/stats.sub-109_REML+tlrc'['$cond'#0_Tstat]'  \
sub-110 ${sdir_2}/sub-110_r${run}.results/stats.sub-110_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-110_r${run}.results/stats.sub-110_REML+tlrc'['$cond'#0_Tstat]'  \
sub-111 ${sdir_2}/sub-111_r${run}.results/stats.sub-111_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-111_r${run}.results/stats.sub-111_REML+tlrc'['$cond'#0_Tstat]'  \
sub-112 ${sdir_2}/sub-112_r${run}.results/stats.sub-112_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-112_r${run}.results/stats.sub-112_REML+tlrc'['$cond'#0_Tstat]'  \
sub-113 ${sdir_2}/sub-113_r${run}.results/stats.sub-113_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-113_r${run}.results/stats.sub-113_REML+tlrc'['$cond'#0_Tstat]'  \
sub-114 ${sdir_2}/sub-114_r${run}.results/stats.sub-114_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-114_r${run}.results/stats.sub-114_REML+tlrc'['$cond'#0_Tstat]'  \
sub-115 ${sdir_2}/sub-115_r${run}.results/stats.sub-115_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-115_r${run}.results/stats.sub-115_REML+tlrc'['$cond'#0_Tstat]'  \
sub-116 ${sdir_2}/sub-116_r${run}.results/stats.sub-116_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-116_r${run}.results/stats.sub-116_REML+tlrc'['$cond'#0_Tstat]'  \
sub-117 ${sdir_2}/sub-117_r${run}.results/stats.sub-117_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-117_r${run}.results/stats.sub-117_REML+tlrc'['$cond'#0_Tstat]'  \
sub-118 ${sdir_2}/sub-118_r${run}.results/stats.sub-118_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-118_r${run}.results/stats.sub-118_REML+tlrc'['$cond'#0_Tstat]'  \
sub-119 ${sdir_2}/sub-119_r${run}.results/stats.sub-119_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-119_r${run}.results/stats.sub-119_REML+tlrc'['$cond'#0_Tstat]'  \
sub-120 ${sdir_2}/sub-120_r${run}.results/stats.sub-120_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-120_r${run}.results/stats.sub-120_REML+tlrc'['$cond'#0_Tstat]'  \
sub-121 ${sdir_2}/sub-121_r${run}.results/stats.sub-121_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-121_r${run}.results/stats.sub-121_REML+tlrc'['$cond'#0_Tstat]'  \
sub-122 ${sdir_2}/sub-122_r${run}.results/stats.sub-122_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-122_r${run}.results/stats.sub-122_REML+tlrc'['$cond'#0_Tstat]'  \
sub-123 ${sdir_2}/sub-123_r${run}.results/stats.sub-123_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-123_r${run}.results/stats.sub-123_REML+tlrc'['$cond'#0_Tstat]'  \
sub-124 ${sdir_2}/sub-124_r${run}.results/stats.sub-124_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-124_r${run}.results/stats.sub-124_REML+tlrc'['$cond'#0_Tstat]'  \
sub-125 ${sdir_2}/sub-125_r${run}.results/stats.sub-125_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-125_r${run}.results/stats.sub-125_REML+tlrc'['$cond'#0_Tstat]'  \
sub-126 ${sdir_2}/sub-126_r${run}.results/stats.sub-126_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-126_r${run}.results/stats.sub-126_REML+tlrc'['$cond'#0_Tstat]'  \
sub-127 ${sdir_2}/sub-127_r${run}.results/stats.sub-127_REML+tlrc'['$cond'#0_Coef]' ${sdir_2}/sub-127_r${run}.results/stats.sub-127_REML+tlrc'['$cond'#0_Tstat]'  

