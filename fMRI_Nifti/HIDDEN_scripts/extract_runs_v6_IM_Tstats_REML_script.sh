#!/bin/bash

afni_dir=/media/data2/pinwei/SL_hippocampus/Nifti/derivatives/afni_out/SS_results_runs_v6

# sub-02
stats_dir=$afni_dir/sub-02_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,33,35,37,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-02_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,108,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-02_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-02_REML+orig'[2,4,7,9,11,14,16,18,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

# sub-03
stats_dir=$afni_dir/sub-03_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,40,42,44,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-03_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,51,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,44,46,48,50,52,55,57,59,61,63,66,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-03_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-03_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,40,42,44,47,49,52,54,56,59,61,63,66,68,71,73,75]'

# sub-04
stats_dir=$afni_dir/sub-04_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,58,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-04_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-04_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-04_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,39,42,44,47,49,52,54,56,59,61,64,66,68,71,73,75]'

# sub-05
stats_dir=$afni_dir/sub-05_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,38,40,43,45,47,50,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-05_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,121,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-05_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-05_REML+orig'[2,4,6,9,11,13,16,19,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

# sub-06
stats_dir=$afni_dir/sub-06_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,39,42,44,46,49,51,53,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-06_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,33,35,37,39,41,43,46,48,50,52,55,57,59,61,63,66,68,70,72,74,77,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-06_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-06_REML+orig'[2,4,7,9,11,14,16,19,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

# sub-07
stats_dir=$afni_dir/sub-07_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,53,56,58,61,63,65,68,70,72,75]'

stats_dir=$afni_dir/sub-07_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,12,15,17,19,22,24,26,28,30,32,35,37,39,41,44,46,48,50,52,54,57,59,61,63,66,68,70,72,74,77,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-07_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-07_REML+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,54,56,58,61,63,65,68,70,73,75]'

# sub-08
stats_dir=$afni_dir/sub-08_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-08_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-08_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-08_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,39,42,44,46,49,51,54,56,58,61,63,65,68,70,72,75]'

# sub-09
stats_dir=$afni_dir/sub-09_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-09_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,9,11,13,15,17,20,22,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,44,46,48,50,52,54,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-09_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-09_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,39,42,44,46,49,51,53,56,58,61,63,66,68,71,73,75]'

# sub-10
stats_dir=$afni_dir/sub-10_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,40,42,44,47,49,51,54,56,58,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-10_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,86,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,42,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-10_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-10_REML+orig'[2,4,6,9,11,13,16,18,21,23,26,28,30,33,35,37,40,42,44,47,49,51,54,56,59,61,63,66,68,70,73,75]'

# sub-11
stats_dir=$afni_dir/sub-11_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,7,9,11,14,16,19,21,23,26,28,30,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-11_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,86,88,91,93,95,97,99,101,104,106,108,110,112,115,117,119,121,123,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-11_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[None]'

stats_dir=$afni_dir/sub-11_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-11_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-11_REML+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,53,56,58,61,63,66,68,70,73,75]'

# sub-12
stats_dir=$afni_dir/sub-12_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-12_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,9,11,13,15,17,20,22,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,44,46,48,50,52,54,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-12_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats_REML.nii \
	$stats_dir/stats.sub-12_REML+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,39,42,44,46,49,51,53,56,58,61,63,66,68,71,73,75]'

