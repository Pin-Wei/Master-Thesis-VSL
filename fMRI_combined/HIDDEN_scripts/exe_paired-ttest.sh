#!/usr/bin/env tcsh

set out_file = $argv[1]
set condA = $argv[2]
set condB = $argv[3]

set sdir_1 = /media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/$argv[4]
set sdir_2 = /media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out/$argv[4]
set stats_fn = $argv[5]

3dttest++ -overwrite \
	-prefix $out_file  \
	-paired                  \
	-mask ../derivatives/Group_analysis/group_mask+tlrc \
	-setA $condA             \
		sub-02 "${sdir_1}/sub-02.results/${stats_fn}.sub-02+tlrc[$condA#0_Coef]"  \
		sub-03 "${sdir_1}/sub-03.results/${stats_fn}.sub-03+tlrc[$condA#0_Coef]"  \
		sub-04 "${sdir_1}/sub-04.results/${stats_fn}.sub-04+tlrc[$condA#0_Coef]"  \
		sub-05 "${sdir_1}/sub-05.results/${stats_fn}.sub-05+tlrc[$condA#0_Coef]"  \
		sub-06 "${sdir_1}/sub-06.results/${stats_fn}.sub-06+tlrc[$condA#0_Coef]"  \
		sub-07 "${sdir_1}/sub-07.results/${stats_fn}.sub-07+tlrc[$condA#0_Coef]"  \
		sub-08 "${sdir_1}/sub-08.results/${stats_fn}.sub-08+tlrc[$condA#0_Coef]"  \
		sub-09 "${sdir_1}/sub-09.results/${stats_fn}.sub-09+tlrc[$condA#0_Coef]"  \
		sub-10 "${sdir_1}/sub-10.results/${stats_fn}.sub-10+tlrc[$condA#0_Coef]"  \
		sub-11 "${sdir_1}/sub-11.results/${stats_fn}.sub-11+tlrc[$condA#0_Coef]"  \
		sub-12 "${sdir_1}/sub-12.results/${stats_fn}.sub-12+tlrc[$condA#0_Coef]"  \
		sub-101 "${sdir_2}/sub-101.results/${stats_fn}.sub-101+tlrc[$condA#0_Coef]"  \
		sub-102 "${sdir_2}/sub-102.results/${stats_fn}.sub-102+tlrc[$condA#0_Coef]"  \
		sub-104 "${sdir_2}/sub-104.results/${stats_fn}.sub-104+tlrc[$condA#0_Coef]"  \
		sub-105 "${sdir_2}/sub-105.results/${stats_fn}.sub-105+tlrc[$condA#0_Coef]"  \
		sub-106 "${sdir_2}/sub-106.results/${stats_fn}.sub-106+tlrc[$condA#0_Coef]"  \
		sub-107 "${sdir_2}/sub-107.results/${stats_fn}.sub-107+tlrc[$condA#0_Coef]"  \
		sub-108 "${sdir_2}/sub-108.results/${stats_fn}.sub-108+tlrc[$condA#0_Coef]"  \
		sub-109 "${sdir_2}/sub-109.results/${stats_fn}.sub-109+tlrc[$condA#0_Coef]"  \
		sub-110 "${sdir_2}/sub-110.results/${stats_fn}.sub-110+tlrc[$condA#0_Coef]"  \
		sub-111 "${sdir_2}/sub-111.results/${stats_fn}.sub-111+tlrc[$condA#0_Coef]"  \
		sub-112 "${sdir_2}/sub-112.results/${stats_fn}.sub-112+tlrc[$condA#0_Coef]"  \
		sub-113 "${sdir_2}/sub-113.results/${stats_fn}.sub-113+tlrc[$condA#0_Coef]"  \
		sub-114 "${sdir_2}/sub-114.results/${stats_fn}.sub-114+tlrc[$condA#0_Coef]"  \
		sub-115 "${sdir_2}/sub-115.results/${stats_fn}.sub-115+tlrc[$condA#0_Coef]"  \
		sub-116 "${sdir_2}/sub-116.results/${stats_fn}.sub-116+tlrc[$condA#0_Coef]"  \
		sub-117 "${sdir_2}/sub-117.results/${stats_fn}.sub-117+tlrc[$condA#0_Coef]"  \
		sub-118 "${sdir_2}/sub-118.results/${stats_fn}.sub-118+tlrc[$condA#0_Coef]"  \
		sub-119 "${sdir_2}/sub-119.results/${stats_fn}.sub-119+tlrc[$condA#0_Coef]"  \
		sub-120 "${sdir_2}/sub-120.results/${stats_fn}.sub-120+tlrc[$condA#0_Coef]"  \
		sub-121 "${sdir_2}/sub-121.results/${stats_fn}.sub-121+tlrc[$condA#0_Coef]"  \
		sub-122 "${sdir_2}/sub-122.results/${stats_fn}.sub-122+tlrc[$condA#0_Coef]"  \
		sub-123 "${sdir_2}/sub-123.results/${stats_fn}.sub-123+tlrc[$condA#0_Coef]"  \
		sub-124 "${sdir_2}/sub-124.results/${stats_fn}.sub-124+tlrc[$condA#0_Coef]"  \
		sub-125 "${sdir_2}/sub-125.results/${stats_fn}.sub-125+tlrc[$condA#0_Coef]"  \
		sub-126 "${sdir_2}/sub-126.results/${stats_fn}.sub-126+tlrc[$condA#0_Coef]"  \
		sub-127 "${sdir_2}/sub-127.results/${stats_fn}.sub-127+tlrc[$condA#0_Coef]"  \
	-setB $condB \
		sub-02 "${sdir_1}/sub-02.results/${stats_fn}.sub-02+tlrc[$condB#0_Coef]"  \
		sub-03 "${sdir_1}/sub-03.results/${stats_fn}.sub-03+tlrc[$condB#0_Coef]"  \
		sub-04 "${sdir_1}/sub-04.results/${stats_fn}.sub-04+tlrc[$condB#0_Coef]"  \
		sub-05 "${sdir_1}/sub-05.results/${stats_fn}.sub-05+tlrc[$condB#0_Coef]"  \
		sub-06 "${sdir_1}/sub-06.results/${stats_fn}.sub-06+tlrc[$condB#0_Coef]"  \
		sub-07 "${sdir_1}/sub-07.results/${stats_fn}.sub-07+tlrc[$condB#0_Coef]"  \
		sub-08 "${sdir_1}/sub-08.results/${stats_fn}.sub-08+tlrc[$condB#0_Coef]"  \
		sub-09 "${sdir_1}/sub-09.results/${stats_fn}.sub-09+tlrc[$condB#0_Coef]"  \
		sub-10 "${sdir_1}/sub-10.results/${stats_fn}.sub-10+tlrc[$condB#0_Coef]"  \
		sub-11 "${sdir_1}/sub-11.results/${stats_fn}.sub-11+tlrc[$condB#0_Coef]"  \
		sub-12 "${sdir_1}/sub-12.results/${stats_fn}.sub-12+tlrc[$condB#0_Coef]"  \
		sub-101 "${sdir_2}/sub-101.results/${stats_fn}.sub-101+tlrc[$condB#0_Coef]"  \
		sub-102 "${sdir_2}/sub-102.results/${stats_fn}.sub-102+tlrc[$condB#0_Coef]"  \
		sub-104 "${sdir_2}/sub-104.results/${stats_fn}.sub-104+tlrc[$condB#0_Coef]"  \
		sub-105 "${sdir_2}/sub-105.results/${stats_fn}.sub-105+tlrc[$condB#0_Coef]"  \
		sub-106 "${sdir_2}/sub-106.results/${stats_fn}.sub-106+tlrc[$condB#0_Coef]"  \
		sub-107 "${sdir_2}/sub-107.results/${stats_fn}.sub-107+tlrc[$condB#0_Coef]"  \
		sub-108 "${sdir_2}/sub-108.results/${stats_fn}.sub-108+tlrc[$condB#0_Coef]"  \
		sub-109 "${sdir_2}/sub-109.results/${stats_fn}.sub-109+tlrc[$condB#0_Coef]"  \
		sub-110 "${sdir_2}/sub-110.results/${stats_fn}.sub-110+tlrc[$condB#0_Coef]"  \
		sub-111 "${sdir_2}/sub-111.results/${stats_fn}.sub-111+tlrc[$condB#0_Coef]"  \
		sub-112 "${sdir_2}/sub-112.results/${stats_fn}.sub-112+tlrc[$condB#0_Coef]"  \
		sub-113 "${sdir_2}/sub-113.results/${stats_fn}.sub-113+tlrc[$condB#0_Coef]"  \
		sub-114 "${sdir_2}/sub-114.results/${stats_fn}.sub-114+tlrc[$condB#0_Coef]"  \
		sub-115 "${sdir_2}/sub-115.results/${stats_fn}.sub-115+tlrc[$condB#0_Coef]"  \
		sub-116 "${sdir_2}/sub-116.results/${stats_fn}.sub-116+tlrc[$condB#0_Coef]"  \
		sub-117 "${sdir_2}/sub-117.results/${stats_fn}.sub-117+tlrc[$condB#0_Coef]"  \
		sub-118 "${sdir_2}/sub-118.results/${stats_fn}.sub-118+tlrc[$condB#0_Coef]"  \
		sub-119 "${sdir_2}/sub-119.results/${stats_fn}.sub-119+tlrc[$condB#0_Coef]"  \
		sub-120 "${sdir_2}/sub-120.results/${stats_fn}.sub-120+tlrc[$condB#0_Coef]"  \
		sub-121 "${sdir_2}/sub-121.results/${stats_fn}.sub-121+tlrc[$condB#0_Coef]"  \
		sub-122 "${sdir_2}/sub-122.results/${stats_fn}.sub-122+tlrc[$condB#0_Coef]"  \
		sub-123 "${sdir_2}/sub-123.results/${stats_fn}.sub-123+tlrc[$condB#0_Coef]"  \
		sub-124 "${sdir_2}/sub-124.results/${stats_fn}.sub-124+tlrc[$condB#0_Coef]"  \
		sub-125 "${sdir_2}/sub-125.results/${stats_fn}.sub-125+tlrc[$condB#0_Coef]"  \
		sub-126 "${sdir_2}/sub-126.results/${stats_fn}.sub-126+tlrc[$condB#0_Coef]"  \
		sub-127 "${sdir_2}/sub-127.results/${stats_fn}.sub-127+tlrc[$condB#0_Coef]"  

