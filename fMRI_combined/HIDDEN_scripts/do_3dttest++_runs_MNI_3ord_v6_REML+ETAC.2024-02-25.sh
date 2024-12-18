
set top_dir = /media/data2/pinwei/SL_hippocampus
set grp_dir = ../derivatives/WholeBrain
set sdir_1 = $top_dir/Nifti/derivatives/afni_out/SS_results_runs_MNI_3ord_v6
set sdir_2 = $top_dir/Nifti_slow/derivatives/afni_out/SS_results_runs_MNI_3ord_v6

# ================================ run-02 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-02
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r02.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r02.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r02.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r02.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r02.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r02.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r02.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r02.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r02.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r02.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r02.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r02.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r02.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r02.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r02.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r02.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r02.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r02.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r02.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r02.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r02.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r02.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r02.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r02.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r02.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r02.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r02.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r02.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r02.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r02.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r02.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r02.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r02.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r02.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r02.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r02.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r02.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r02.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r02.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r02.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-03 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-03
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r03.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r03.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r03.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r03.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r03.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r03.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r03.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r03.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r03.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r03.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r03.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r03.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r03.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r03.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r03.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r03.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r03.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r03.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r03.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r03.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r03.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r03.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r03.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r03.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r03.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r03.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r03.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r03.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r03.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r03.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r03.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r03.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r03.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r03.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r03.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r03.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r03.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r03.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r03.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r03.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-04 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-04
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r04.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r04.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r04.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r04.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r04.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r04.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r04.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r04.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r04.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r04.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r04.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r04.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r04.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r04.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r04.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r04.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r04.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r04.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r04.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r04.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r04.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r04.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r04.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r04.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r04.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r04.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r04.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r04.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r04.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r04.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r04.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r04.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r04.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r04.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r04.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r04.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r04.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r04.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r04.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r04.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-05 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-05
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r05.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r05.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r05.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r05.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r05.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r05.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r05.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r05.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r05.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r05.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r05.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r05.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r05.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r05.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r05.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r05.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r05.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r05.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r05.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r05.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r05.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r05.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r05.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r05.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r05.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r05.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r05.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r05.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r05.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r05.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r05.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r05.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r05.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r05.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r05.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r05.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r05.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r05.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r05.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r05.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-06 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-06
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r06.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r06.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r06.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r06.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r06.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r06.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r06.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r06.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r06.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r06.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r06.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r06.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r06.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r06.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r06.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r06.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r06.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r06.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r06.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r06.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r06.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r06.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r06.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r06.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r06.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r06.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r06.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r06.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r06.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r06.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r06.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r06.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r06.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r06.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r06.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r06.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r06.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r06.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r06.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r06.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-07 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-07
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r07.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r07.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r07.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r07.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r07.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r07.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r07.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r07.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r07.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r07.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r07.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r07.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r07.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r07.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r07.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r07.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r07.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r07.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r07.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r07.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r07.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r07.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r07.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r07.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r07.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r07.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r07.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r07.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r07.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r07.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r07.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r07.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r07.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r07.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r07.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r07.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r07.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r07.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r07.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r07.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-08 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-08
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r08.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r08.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r08.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r08.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r08.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r08.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r08.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r08.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r08.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r08.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r08.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r08.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r08.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r08.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r08.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r08.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r08.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r08.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r08.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r08.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r08.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r08.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r08.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r08.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r08.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r08.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r08.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r08.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r08.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r08.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r08.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r08.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r08.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r08.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r08.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r08.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r08.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r08.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r08.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r08.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir

# ================================ run-09 ================================
set out_dir = $grp_dir/ap.runs_MNI_3ord_v6/ClustSim+ETAC/run-09
if ( ! -d $out_dir ) mkdir -p $out_dir 

## ------------------------------ Predicting_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicting_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicting \
		sub-02 "${sdir_1}/sub-02_r09.results/stats.sub-02_REML+tlrc[Predicting#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/stats.sub-03_REML+tlrc[Predicting#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/stats.sub-04_REML+tlrc[Predicting#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/stats.sub-05_REML+tlrc[Predicting#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/stats.sub-06_REML+tlrc[Predicting#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/stats.sub-07_REML+tlrc[Predicting#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/stats.sub-08_REML+tlrc[Predicting#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/stats.sub-09_REML+tlrc[Predicting#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/stats.sub-10_REML+tlrc[Predicting#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/stats.sub-11_REML+tlrc[Predicting#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/stats.sub-12_REML+tlrc[Predicting#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/stats.sub-101_REML+tlrc[Predicting#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/stats.sub-102_REML+tlrc[Predicting#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/stats.sub-104_REML+tlrc[Predicting#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/stats.sub-105_REML+tlrc[Predicting#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/stats.sub-106_REML+tlrc[Predicting#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/stats.sub-107_REML+tlrc[Predicting#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/stats.sub-108_REML+tlrc[Predicting#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/stats.sub-109_REML+tlrc[Predicting#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/stats.sub-110_REML+tlrc[Predicting#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/stats.sub-111_REML+tlrc[Predicting#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/stats.sub-112_REML+tlrc[Predicting#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/stats.sub-113_REML+tlrc[Predicting#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/stats.sub-114_REML+tlrc[Predicting#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/stats.sub-115_REML+tlrc[Predicting#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/stats.sub-116_REML+tlrc[Predicting#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/stats.sub-117_REML+tlrc[Predicting#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/stats.sub-118_REML+tlrc[Predicting#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/stats.sub-119_REML+tlrc[Predicting#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/stats.sub-120_REML+tlrc[Predicting#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/stats.sub-121_REML+tlrc[Predicting#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/stats.sub-122_REML+tlrc[Predicting#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/stats.sub-123_REML+tlrc[Predicting#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/stats.sub-124_REML+tlrc[Predicting#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/stats.sub-125_REML+tlrc[Predicting#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/stats.sub-126_REML+tlrc[Predicting#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/stats.sub-127_REML+tlrc[Predicting#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicting_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicting_REML.ttest* $out_dir

## ------------------------------ Predicted_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Predicted_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Predicted \
		sub-02 "${sdir_1}/sub-02_r09.results/stats.sub-02_REML+tlrc[Predicted#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/stats.sub-03_REML+tlrc[Predicted#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/stats.sub-04_REML+tlrc[Predicted#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/stats.sub-05_REML+tlrc[Predicted#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/stats.sub-06_REML+tlrc[Predicted#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/stats.sub-07_REML+tlrc[Predicted#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/stats.sub-08_REML+tlrc[Predicted#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/stats.sub-09_REML+tlrc[Predicted#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/stats.sub-10_REML+tlrc[Predicted#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/stats.sub-11_REML+tlrc[Predicted#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/stats.sub-12_REML+tlrc[Predicted#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/stats.sub-101_REML+tlrc[Predicted#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/stats.sub-102_REML+tlrc[Predicted#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/stats.sub-104_REML+tlrc[Predicted#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/stats.sub-105_REML+tlrc[Predicted#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/stats.sub-106_REML+tlrc[Predicted#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/stats.sub-107_REML+tlrc[Predicted#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/stats.sub-108_REML+tlrc[Predicted#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/stats.sub-109_REML+tlrc[Predicted#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/stats.sub-110_REML+tlrc[Predicted#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/stats.sub-111_REML+tlrc[Predicted#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/stats.sub-112_REML+tlrc[Predicted#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/stats.sub-113_REML+tlrc[Predicted#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/stats.sub-114_REML+tlrc[Predicted#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/stats.sub-115_REML+tlrc[Predicted#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/stats.sub-116_REML+tlrc[Predicted#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/stats.sub-117_REML+tlrc[Predicted#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/stats.sub-118_REML+tlrc[Predicted#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/stats.sub-119_REML+tlrc[Predicted#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/stats.sub-120_REML+tlrc[Predicted#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/stats.sub-121_REML+tlrc[Predicted#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/stats.sub-122_REML+tlrc[Predicted#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/stats.sub-123_REML+tlrc[Predicted#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/stats.sub-124_REML+tlrc[Predicted#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/stats.sub-125_REML+tlrc[Predicted#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/stats.sub-126_REML+tlrc[Predicted#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/stats.sub-127_REML+tlrc[Predicted#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Predicted_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Predicted_REML.ttest* $out_dir

## ------------------------------ Tpt_start_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpt_start_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpt_start \
		sub-02 "${sdir_1}/sub-02_r09.results/stats.sub-02_REML+tlrc[Tpt_start#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/stats.sub-03_REML+tlrc[Tpt_start#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/stats.sub-04_REML+tlrc[Tpt_start#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/stats.sub-05_REML+tlrc[Tpt_start#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/stats.sub-06_REML+tlrc[Tpt_start#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/stats.sub-07_REML+tlrc[Tpt_start#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/stats.sub-08_REML+tlrc[Tpt_start#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/stats.sub-09_REML+tlrc[Tpt_start#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/stats.sub-10_REML+tlrc[Tpt_start#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/stats.sub-11_REML+tlrc[Tpt_start#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/stats.sub-12_REML+tlrc[Tpt_start#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/stats.sub-101_REML+tlrc[Tpt_start#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/stats.sub-102_REML+tlrc[Tpt_start#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/stats.sub-104_REML+tlrc[Tpt_start#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/stats.sub-105_REML+tlrc[Tpt_start#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/stats.sub-106_REML+tlrc[Tpt_start#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/stats.sub-107_REML+tlrc[Tpt_start#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/stats.sub-108_REML+tlrc[Tpt_start#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/stats.sub-109_REML+tlrc[Tpt_start#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/stats.sub-110_REML+tlrc[Tpt_start#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/stats.sub-111_REML+tlrc[Tpt_start#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/stats.sub-112_REML+tlrc[Tpt_start#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/stats.sub-113_REML+tlrc[Tpt_start#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/stats.sub-114_REML+tlrc[Tpt_start#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/stats.sub-115_REML+tlrc[Tpt_start#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/stats.sub-116_REML+tlrc[Tpt_start#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/stats.sub-117_REML+tlrc[Tpt_start#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/stats.sub-118_REML+tlrc[Tpt_start#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/stats.sub-119_REML+tlrc[Tpt_start#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/stats.sub-120_REML+tlrc[Tpt_start#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/stats.sub-121_REML+tlrc[Tpt_start#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/stats.sub-122_REML+tlrc[Tpt_start#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/stats.sub-123_REML+tlrc[Tpt_start#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/stats.sub-124_REML+tlrc[Tpt_start#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/stats.sub-125_REML+tlrc[Tpt_start#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/stats.sub-126_REML+tlrc[Tpt_start#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/stats.sub-127_REML+tlrc[Tpt_start#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpt_start_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpt_start_REML.ttest* $out_dir

## ------------------------------ Tpl_end_GLT --------------------------------
3dttest++ -overwrite \
	-prefix $out_dir/Tpl_end_REML.ttest \
	-mask /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/WholeBrain/group_mask+tlrc \
	-setA Tpl_end \
		sub-02 "${sdir_1}/sub-02_r09.results/stats.sub-02_REML+tlrc[Tpl_end#0_Coef]" \
		sub-03 "${sdir_1}/sub-03_r09.results/stats.sub-03_REML+tlrc[Tpl_end#0_Coef]" \
		sub-04 "${sdir_1}/sub-04_r09.results/stats.sub-04_REML+tlrc[Tpl_end#0_Coef]" \
		sub-05 "${sdir_1}/sub-05_r09.results/stats.sub-05_REML+tlrc[Tpl_end#0_Coef]" \
		sub-06 "${sdir_1}/sub-06_r09.results/stats.sub-06_REML+tlrc[Tpl_end#0_Coef]" \
		sub-07 "${sdir_1}/sub-07_r09.results/stats.sub-07_REML+tlrc[Tpl_end#0_Coef]" \
		sub-08 "${sdir_1}/sub-08_r09.results/stats.sub-08_REML+tlrc[Tpl_end#0_Coef]" \
		sub-09 "${sdir_1}/sub-09_r09.results/stats.sub-09_REML+tlrc[Tpl_end#0_Coef]" \
		sub-10 "${sdir_1}/sub-10_r09.results/stats.sub-10_REML+tlrc[Tpl_end#0_Coef]" \
		sub-11 "${sdir_1}/sub-11_r09.results/stats.sub-11_REML+tlrc[Tpl_end#0_Coef]" \
		sub-12 "${sdir_1}/sub-12_r09.results/stats.sub-12_REML+tlrc[Tpl_end#0_Coef]" \
		sub-101 "${sdir_2}/sub-101_r09.results/stats.sub-101_REML+tlrc[Tpl_end#0_Coef]" \
		sub-102 "${sdir_2}/sub-102_r09.results/stats.sub-102_REML+tlrc[Tpl_end#0_Coef]" \
		sub-104 "${sdir_2}/sub-104_r09.results/stats.sub-104_REML+tlrc[Tpl_end#0_Coef]" \
		sub-105 "${sdir_2}/sub-105_r09.results/stats.sub-105_REML+tlrc[Tpl_end#0_Coef]" \
		sub-106 "${sdir_2}/sub-106_r09.results/stats.sub-106_REML+tlrc[Tpl_end#0_Coef]" \
		sub-107 "${sdir_2}/sub-107_r09.results/stats.sub-107_REML+tlrc[Tpl_end#0_Coef]" \
		sub-108 "${sdir_2}/sub-108_r09.results/stats.sub-108_REML+tlrc[Tpl_end#0_Coef]" \
		sub-109 "${sdir_2}/sub-109_r09.results/stats.sub-109_REML+tlrc[Tpl_end#0_Coef]" \
		sub-110 "${sdir_2}/sub-110_r09.results/stats.sub-110_REML+tlrc[Tpl_end#0_Coef]" \
		sub-111 "${sdir_2}/sub-111_r09.results/stats.sub-111_REML+tlrc[Tpl_end#0_Coef]" \
		sub-112 "${sdir_2}/sub-112_r09.results/stats.sub-112_REML+tlrc[Tpl_end#0_Coef]" \
		sub-113 "${sdir_2}/sub-113_r09.results/stats.sub-113_REML+tlrc[Tpl_end#0_Coef]" \
		sub-114 "${sdir_2}/sub-114_r09.results/stats.sub-114_REML+tlrc[Tpl_end#0_Coef]" \
		sub-115 "${sdir_2}/sub-115_r09.results/stats.sub-115_REML+tlrc[Tpl_end#0_Coef]" \
		sub-116 "${sdir_2}/sub-116_r09.results/stats.sub-116_REML+tlrc[Tpl_end#0_Coef]" \
		sub-117 "${sdir_2}/sub-117_r09.results/stats.sub-117_REML+tlrc[Tpl_end#0_Coef]" \
		sub-118 "${sdir_2}/sub-118_r09.results/stats.sub-118_REML+tlrc[Tpl_end#0_Coef]" \
		sub-119 "${sdir_2}/sub-119_r09.results/stats.sub-119_REML+tlrc[Tpl_end#0_Coef]" \
		sub-120 "${sdir_2}/sub-120_r09.results/stats.sub-120_REML+tlrc[Tpl_end#0_Coef]" \
		sub-121 "${sdir_2}/sub-121_r09.results/stats.sub-121_REML+tlrc[Tpl_end#0_Coef]" \
		sub-122 "${sdir_2}/sub-122_r09.results/stats.sub-122_REML+tlrc[Tpl_end#0_Coef]" \
		sub-123 "${sdir_2}/sub-123_r09.results/stats.sub-123_REML+tlrc[Tpl_end#0_Coef]" \
		sub-124 "${sdir_2}/sub-124_r09.results/stats.sub-124_REML+tlrc[Tpl_end#0_Coef]" \
		sub-125 "${sdir_2}/sub-125_r09.results/stats.sub-125_REML+tlrc[Tpl_end#0_Coef]" \
		sub-126 "${sdir_2}/sub-126_r09.results/stats.sub-126_REML+tlrc[Tpl_end#0_Coef]" \
		sub-127 "${sdir_2}/sub-127_r09.results/stats.sub-127_REML+tlrc[Tpl_end#0_Coef]" \
	-CLUSTSIM -ETAC \
	-prefix_clustsim Tpl_end_REML.ttest \
	-ETAC_opt NN=3:sid=1:pthr=0.05,0.01,0.005,0.001:name=1sided \
	-ETAC_opt NN=3:sid=2:pthr=0.05,0.01,0.005,0.001:name=2sided  

mv *Tpl_end_REML.ttest* $out_dir
