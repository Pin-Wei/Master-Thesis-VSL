#!/bin/bash

afni_dir=/media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/SS_results_runs_v6

# sub-02
stats_dir=$afni_dir/sub-02_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,8,10,12,15,17,19,22,24,27,29,32,34,36,39,41,44,46,48,51,53,56,58,60,63,65,67,70,72,74]'

stats_dir=$afni_dir/sub-02_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,37,40,42,44,46,48,51,53,55,57,59,61,64,66,68,70,72,75,77,79,81,83,86,88,90,92,94,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,62,64,66,68,70,72,75,77,79,81,83,86,88,90,92,94,97,99,101,103,105,107,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,108,110,112,114,116,118,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-02_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-02+orig'[1,3,6,8,10,13,15,17,20,22,25,27,29,32,34,36,39,41,44,46,48,51,53,56,58,60,63,65,67,70,72,74]'

# sub-03
stats_dir=$afni_dir/sub-03_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,39,41,43,46,48,51,53,55,58,60,62,65,67,70,72,74]'

stats_dir=$afni_dir/sub-03_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,105,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,83,86,88,90,92,94,96,99,101,103,106,108,110,112,114,116,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,37,40,42,44,46,49,51,53,55,57,59,62,64,66,68,71,73,75,77,79,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,37,40,42,44,46,48,50,53,55,57,59,61,64,66,68,70,72,75,77,79,81,83,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,118,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,40,43,45,47,49,51,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-03_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-03+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,39,41,43,46,48,51,53,55,58,60,62,65,67,70,72,74]'

# sub-04
stats_dir=$afni_dir/sub-04_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,6,8,10,13,15,17,20,22,24,27,29,31,34,36,38,41,43,46,48,50,53,55,57,60,62,65,67,70,72,74]'

stats_dir=$afni_dir/sub-04_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,67,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,105,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-04_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-04+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,38,41,43,46,48,51,53,55,58,60,63,65,67,70,72,74]'

# sub-05
stats_dir=$afni_dir/sub-05_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,37,39,42,44,46,49,51,53,56,58,60,63,65,67,70,72,74]'

stats_dir=$afni_dir/sub-05_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,8,10,12,14,16,18,21,23,25,27,29,32,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,118,120,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,118,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,108,110,112,114,116,118,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,80,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-05_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-05+orig'[1,3,5,8,10,12,15,18,20,22,25,27,29,32,34,36,39,41,44,46,48,51,53,55,58,60,62,65,67,70,72,74]'

# sub-06
stats_dir=$afni_dir/sub-06_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,38,41,43,45,48,50,52,55,58,60,62,65,67,70,72,74]'

stats_dir=$afni_dir/sub-06_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,32,34,36,38,40,42,45,47,49,51,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,69,71,73,75,78,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,92,94,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,5,7,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,43,45,47,49,51,54,56,58,60,62,64,67,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-06_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-06+orig'[1,3,6,8,10,13,15,18,20,22,25,27,29,32,34,36,39,41,44,46,48,51,53,56,58,60,63,65,67,70,72,74]'

# sub-07
stats_dir=$afni_dir/sub-07_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,6,8,10,13,15,17,20,22,24,27,29,31,34,36,38,41,43,45,48,50,52,55,57,60,62,64,67,69,71,74]'

stats_dir=$afni_dir/sub-07_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,11,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,37,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,83,86,88,90,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,11,14,16,18,21,23,25,27,29,31,34,36,38,40,43,45,47,49,51,53,56,58,60,62,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,84,86,88,90,93,95,97,99,101,103,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,8,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,83,86,88,90,92,95,97,99,101,103,105,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-07_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-07+orig'[1,3,5,8,10,12,15,17,20,22,24,27,29,31,34,36,38,41,43,45,48,50,53,55,57,60,62,64,67,69,72,74]'

# sub-08
stats_dir=$afni_dir/sub-08_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,8,10,12,15,17,20,22,24,27,29,31,34,36,38,41,43,46,48,51,53,55,58,60,62,65,67,69,72,74]'

stats_dir=$afni_dir/sub-08_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,91,93,95,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,69,71,73,75,77,79,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,47,49,51,53,55,57,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,62,64,66,68,70,72,75,77,79,81,83,86,88,90,92,95,97,99,101,103,105,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,56,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,105,108,110,112,114,116,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,7,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,55,58,60,62,64,66,69,71,73,75,78,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-08_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-08+orig'[1,3,5,8,10,12,15,17,19,22,24,27,29,31,34,36,38,41,43,45,48,50,53,55,57,60,62,64,67,69,71,74]'

# sub-09
stats_dir=$afni_dir/sub-09_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,8,10,12,15,17,19,22,24,27,29,32,34,36,39,41,44,46,48,51,53,55,58,60,62,65,67,70,72,74]'

stats_dir=$afni_dir/sub-09_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,72,75,77,79,81,83,86,88,90,92,94,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,8,10,12,14,16,19,21,23,25,27,29,32,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,8,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,43,45,47,49,51,53,56,58,60,62,64,67,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-09_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-09+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,38,41,43,45,48,50,52,55,57,60,62,65,67,70,72,74]'

# sub-10
stats_dir=$afni_dir/sub-10_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,8,10,13,15,17,20,22,24,27,29,31,34,36,39,41,43,46,48,50,53,55,57,60,62,65,67,69,72,74]'

stats_dir=$afni_dir/sub-10_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,71,73,75,77,80,82,84,86,88,91,93,95,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,61,64,66,68,70,72,74,77,79,81,83,85,88,90,92,95,97,99,101,103,105,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,80,82,84,86,88,91,93,95,97,99,102,104,106,108,110,112,115,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,81,84,86,88,90,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,41,43,45,47,49,51,54,56,58,60,62,64,67,69,71,73,75,78,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-10_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-10+orig'[1,3,5,8,10,12,15,17,20,22,25,27,29,32,34,36,39,41,43,46,48,50,53,55,58,60,62,65,67,69,72,74]'

# sub-11
stats_dir=$afni_dir/sub-11_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,6,8,10,13,15,18,20,22,25,27,29,32,34,37,39,41,44,46,48,51,53,55,58,60,62,65,67,69,72,74]'

stats_dir=$afni_dir/sub-11_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,61,64,66,68,70,72,74,77,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,114,116,118,120,122,125,127,129,131,134,136,138]'

stats_dir=$afni_dir/sub-11_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,61,64,66,68,70,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,10,12,14,16,18,20,23,25,27,29,31,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,79,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[None]'

stats_dir=$afni_dir/sub-11_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,47,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-11_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-11+orig'[1,3,6,8,10,13,15,17,20,22,24,27,29,31,34,36,38,41,43,45,48,50,52,55,57,60,62,65,67,69,72,74]'

# sub-12
stats_dir=$afni_dir/sub-12_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,8,10,12,15,17,19,22,24,27,29,32,34,36,39,41,44,46,48,51,53,55,58,60,62,65,67,70,72,74]'

stats_dir=$afni_dir/sub-12_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,72,75,77,79,81,83,86,88,90,92,94,97,99,101,104,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,12,14,16,18,20,22,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,58,60,62,64,66,68,71,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,128,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,107,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,42,44,46,49,51,53,55,57,59,62,64,66,68,70,73,75,77,79,81,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,12,14,16,18,20,23,25,27,29,31,33,36,38,40,42,44,46,49,51,53,55,57,60,62,64,66,68,71,73,75,77,79,81,84,86,88,90,92,94,97,99,101,103,105,108,110,112,114,116,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,8,10,12,14,16,19,21,23,25,27,29,32,34,36,38,40,42,45,47,49,51,53,56,58,60,62,64,66,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,8,10,12,14,16,18,21,23,25,27,29,31,34,36,38,40,42,44,47,49,51,53,55,57,60,62,64,66,68,70,73,75,77,79,82,84,86,88,90,92,95,97,99,101,103,106,108,110,112,114,117,119,121,123,125,127,130,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,7,9,11,14,16,18,20,22,25,27,29,31,33,35,38,40,43,45,47,49,51,53,56,58,60,62,64,67,69,71,73,75,77,80,82,84,86,88,90,93,95,97,99,101,103,106,108,110,112,114,116,119,121,123,125,127,129,132,134,136,138]'

stats_dir=$afni_dir/sub-12_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allBetas.nii \
	$stats_dir/stats.sub-12+orig'[1,3,5,8,10,12,15,17,19,22,24,26,29,31,34,36,38,41,43,45,48,50,52,55,57,60,62,65,67,70,72,74]'

