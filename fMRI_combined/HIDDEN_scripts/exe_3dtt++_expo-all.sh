# apply any data directories with variables
set data_dir = /media/data2/pinwei/SL_hippocampus/Nifti

3dttest++                                                                                             \
   -prefix                                                                                            \
   /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis/ap.1207/expo-all.tt++ \
                                                                                                      \
   -setA exposure_All_GLT                                                                             \
      sub-02.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-02.results[exposure_All_GLT#0_Coef]"           \
      sub-03.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-03.results[exposure_All_GLT#0_Coef]"           \
      sub-04.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-04.results[exposure_All_GLT#0_Coef]"           \
      sub-05.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-05.results[exposure_All_GLT#0_Coef]"           \
      sub-06.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-06.results[exposure_All_GLT#0_Coef]"           \
      sub-07.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-07.results[exposure_All_GLT#0_Coef]"           \
      sub-08.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-08.results[exposure_All_GLT#0_Coef]"           \
      sub-09.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-09.results[exposure_All_GLT#0_Coef]"           \
      sub-10.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-10.results[exposure_All_GLT#0_Coef]"           \
      sub-11.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-11.results[exposure_All_GLT#0_Coef]"           \
      sub-12.results                                                                                  \
   "$data_dir/derivatives/afni_out/SS_results_1207/sub-12.results[exposure_All_GLT#0_Coef]"           \
      sub-101.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-101.results[exposure_All_GLT#0_Coef]"     \
      sub-102.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-102.results[exposure_All_GLT#0_Coef]"     \
      sub-104.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-104.results[exposure_All_GLT#0_Coef]"     \
      sub-105.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-105.results[exposure_All_GLT#0_Coef]"     \
      sub-106.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-106.results[exposure_All_GLT#0_Coef]"     \
      sub-107.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-107.results[exposure_All_GLT#0_Coef]"     \
      sub-108.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-108.results[exposure_All_GLT#0_Coef]"     \
      sub-109.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-109.results[exposure_All_GLT#0_Coef]"     \
      sub-110.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-110.results[exposure_All_GLT#0_Coef]"     \
      sub-111.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-111.results[exposure_All_GLT#0_Coef]"     \
      sub-112.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-112.results[exposure_All_GLT#0_Coef]"     \
      sub-113.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-113.results[exposure_All_GLT#0_Coef]"     \
      sub-114.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-114.results[exposure_All_GLT#0_Coef]"     \
      sub-115.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-115.results[exposure_All_GLT#0_Coef]"     \
      sub-116.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-116.results[exposure_All_GLT#0_Coef]"     \
      sub-117.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-117.results[exposure_All_GLT#0_Coef]"     \
      sub-118.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-118.results[exposure_All_GLT#0_Coef]"     \
      sub-119.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-119.results[exposure_All_GLT#0_Coef]"     \
      sub-120.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-120.results[exposure_All_GLT#0_Coef]"     \
      sub-121.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-121.results[exposure_All_GLT#0_Coef]"     \
      sub-122.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-122.results[exposure_All_GLT#0_Coef]"     \
      sub-123.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-123.results[exposure_All_GLT#0_Coef]"     \
      sub-124.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-124.results[exposure_All_GLT#0_Coef]"     \
      sub-125.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-125.results[exposure_All_GLT#0_Coef]"     \
      sub-126.results                                                                                 \
   "$data_dir/slow/derivatives/afni_out/SS_results_1207/sub-126.results[exposure_All_GLT#0_Coef]"     \
   -mask                                                                                              \
   /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis/group_mask+tlrc       \
   -ETAC -prefix_clustsim                                                                             \
   /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/Group_analysis/ap.1207/files_ClustSim/expo-all.tt++

