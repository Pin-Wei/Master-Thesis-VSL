
set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = ../derivatives/WholeBrain
set sdir_1 = $top_dir/Nifti/derivatives/afni_out/SS_results_runs_MNI_3ord_v6
set sdir_2 = $top_dir/Nifti_slow/derivatives/afni_out/SS_results_runs_MNI_3ord_v6

# ================================ run-02 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-02/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-03 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-03/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-04 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-04/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-05 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-05/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-06 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-06/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-07 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-07/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-08 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-08/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir

# ================================ run-09 ================================

## --------------------------- gfunc_Hippocampus ---------------------------

set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/PPI/run-09/gfunc_Hippocampus
if ( ! -d $out_dir ) mkdir -p $out_dir 

### PPI.Fst:

3dttest++ -overwrite \
	-prefix $out_dir/Fst_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Fst \
		sub-02 "${sdir_1}/sub-02_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Fst#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Fst_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Fst_REML.ttest* $out_dir

### PPI.Snd:

3dttest++ -overwrite \
	-prefix $out_dir/Snd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Snd \
		sub-02 "${sdir_1}/sub-02_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Snd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Snd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Snd_REML.ttest* $out_dir

### PPI.Trd:

3dttest++ -overwrite \
	-prefix $out_dir/Trd_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA PPI.Trd \
		sub-02 "${sdir_1}/sub-02_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/PPI.gfunc_Hippocampus.stats_REML+tlrc[PPI.Trd#0_Coef]" \
	-CLUSTSIM \
		-prefix_clustsim Trd_REML.ttest \
	-ETAC \
		-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
		-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Trd_REML.ttest* $out_dir
