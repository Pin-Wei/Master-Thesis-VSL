#!/bin/bash

afni_dir=/media/data2/pinwei/SL_hippocampus/Nifti_slow/derivatives/afni_out/SS_results_runs_v6

# sub-101
stats_dir=$afni_dir/sub-101_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,5,7,9,12,14,16,19,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-101_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-101_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-101+orig'[2,4,7,9,11,14,16,19,21,23,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

# sub-102
stats_dir=$afni_dir/sub-102_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,33,35,37,40,42,44,47,49,51,54,56,58,61,63,65,68,70,73,75]'

stats_dir=$afni_dir/sub-102_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,33,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-102_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-102+orig'[2,4,6,9,11,13,16,18,20,23,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

# sub-104
stats_dir=$afni_dir/sub-104_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,34,37,39,41,44,46,49,51,53,56,58,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-104_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,51,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-104_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-104+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,34,37,39,42,44,46,49,51,53,56,58,61,63,66,68,71,73,75]'

# sub-105
stats_dir=$afni_dir/sub-105_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,33,35,38,40,43,45,47,50,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-105_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,66,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,61,63,65,67,69,71,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,31,33,35,37,39,42,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-105_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-105+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,64,66,68,71,73,75]'

# sub-106
stats_dir=$afni_dir/sub-106_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,33,35,38,40,42,45,47,49,52,54,56,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-106_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,85,87,89,91,93,95,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,86,89,91,93,95,97,99,102,104,106,108,110,113,115,117,119,121,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-106_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-106+orig'[2,4,7,10,12,14,17,19,22,24,26,29,31,33,36,38,40,43,45,47,50,52,54,57,59,61,64,66,68,71,73,75]'

# sub-107
stats_dir=$afni_dir/sub-107_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-107_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-107_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-107+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,33,35,37,40,42,44,47,49,52,54,57,59,61,64,66,68,71,73,75]'

# sub-108
stats_dir=$afni_dir/sub-108_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,35,37,39,42,44,46,49,51,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-108_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,11,13,15,17,20,22,24,26,29,31,33,35,37,39,42,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-108_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-108+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,33,35,37,40,42,44,47,49,51,54,56,59,61,64,66,68,71,73,75]'

# sub-109
stats_dir=$afni_dir/sub-109_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,58,61,63,65,68,71,73,75]'

stats_dir=$afni_dir/sub-109_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,42,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-109_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,121,124,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-109_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-109+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,40,42,44,47,49,51,54,56,58,61,63,65,68,71,73,75]'

# sub-110
stats_dir=$afni_dir/sub-110_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,58,61,63,65,68,70,73,75]'

stats_dir=$afni_dir/sub-110_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-110_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,121,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,79,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-110_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-110+orig'[None]'

# sub-111
stats_dir=$afni_dir/sub-111_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,39,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-111_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,86,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,121,123,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-111_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-111_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-111+orig'[2,4,6,9,11,13,16,18,20,23,26,28,30,33,35,38,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

# sub-112
stats_dir=$afni_dir/sub-112_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,40,42,44,47,49,51,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-112_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,119,121,124,126,128,130,132,134,137,139]'

stats_dir=$afni_dir/sub-112_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-112_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-112+orig'[2,4,6,9,11,14,16,18,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

# sub-113
stats_dir=$afni_dir/sub-113_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,33,35,37,40,42,44,47,49,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-113_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,76,78,80,82,84,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-113_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,99,102,104,106,108,110,113,115,117,119,122,124,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-113_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-113+orig'[2,4,7,9,12,14,16,19,21,24,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,64,66,68,71,73,75]'

# sub-114
stats_dir=$afni_dir/sub-114_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,7,9,12,14,16,19,21,23,26,28,30,33,35,37,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-114_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,57,59,61,63,65,68,70,72,74,76,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-114_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-114+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,58,61,63,66,68,70,73,75]'

# sub-115
stats_dir=$afni_dir/sub-115_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,32,35,37,40,42,44,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-115_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,9,11,14,16,18,20,22,24,27,29,31,33,35,38,40,42,44,46,48,51,53,55,57,59,61,64,66,68,70,72,74,77,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-115_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-115+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,39,42,44,47,49,52,54,56,59,61,63,66,68,71,73,75]'

# sub-116
stats_dir=$afni_dir/sub-116_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,33,35,37,40,42,44,47,49,51,54,56,58,61,63,65,68,70,72,75]'

stats_dir=$afni_dir/sub-116_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,119,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-116_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-116+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,33,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

# sub-117
stats_dir=$afni_dir/sub-117_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,53,56,58,61,63,65,68,70,73,75]'

stats_dir=$afni_dir/sub-117_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,51,54,56,58,60,62,64,67,69,71,73,75,78,80,82,84,86,89,91,93,95,97,99,102,104,106,108,111,113,115,117,119,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-117_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-117+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,38,40,42,45,47,50,52,54,57,59,61,64,66,68,71,73,75]'

# sub-118
stats_dir=$afni_dir/sub-118_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-118_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,11,13,15,17,20,22,24,26,28,30,33,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-118_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-118+orig'[2,4,6,9,11,14,16,18,21,23,25,28,30,32,35,37,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

# sub-119
stats_dir=$afni_dir/sub-119_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,9,11,13,16,19,21,23,26,28,30,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-119_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,46,48,50,52,54,56,59,61,63,66,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,44,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,121,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-119_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-119+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,40,42,44,47,49,51,54,56,58,61,63,66,68,71,73,75]'

# sub-120
stats_dir=$afni_dir/sub-120_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,33,35,37,40,42,44,47,49,52,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-120_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,119,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,51,54,56,58,60,63,65,67,69,71,74,76,78,80,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-120_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-120+orig'[2,4,7,9,12,14,16,19,21,24,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

# sub-121
stats_dir=$afni_dir/sub-121_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,39,42,44,46,49,51,54,56,58,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-121_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,48,50,52,54,57,59,61,63,65,67,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[None]'

stats_dir=$afni_dir/sub-121_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-121_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[None]'

stats_dir=$afni_dir/sub-121_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-121+orig'[2,4,6,9,11,13,16,18,21,23,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,64,66,68,71,73,75]'

# sub-122
stats_dir=$afni_dir/sub-122_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,9,11,13,16,18,21,23,25,28,30,32,35,37,40,42,44,47,49,51,54,56,58,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-122_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,44,46,48,50,52,55,57,59,61,64,66,68,70,72,74,77,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,10,12,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[None]'

stats_dir=$afni_dir/sub-122_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,46,48,50,52,54,57,59,61,63,65,68,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[None]'

stats_dir=$afni_dir/sub-122_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-122_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-122+orig'[None]'

# sub-123
stats_dir=$afni_dir/sub-123_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,7,9,11,14,16,18,21,23,26,28,31,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-123_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,79,81,83,85,87,90,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,33,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,72,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,108,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-123_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-123+orig'[2,5,7,9,12,14,16,19,21,23,26,28,30,33,35,37,40,42,44,47,49,51,54,56,59,61,63,66,68,70,73,75]'

# sub-124
stats_dir=$afni_dir/sub-124_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,7,9,11,14,16,18,21,23,25,28,30,33,35,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75]'

stats_dir=$afni_dir/sub-124_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,10,12,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,9,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,33,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-124_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-124+orig'[2,4,7,9,11,14,16,19,21,23,26,28,30,33,35,37,40,42,45,47,50,52,54,57,59,61,64,66,68,71,73,75]'

# sub-125
stats_dir=$afni_dir/sub-125_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,9,11,14,16,19,21,23,26,28,30,33,35,37,40,42,44,47,49,51,54,57,59,61,64,66,68,71,73,75]'

stats_dir=$afni_dir/sub-125_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,100,102,104,106,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,11,13,15,17,20,22,24,26,28,30,33,35,37,39,41,43,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,84,87,89,91,93,95,98,100,102,104,106,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,34,37,39,41,43,45,47,50,52,54,56,58,60,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,96,98,100,102,104,106,109,111,113,115,117,120,122,124,126,128,130,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,33,35,37,39,42,44,46,48,50,52,55,57,59,61,63,66,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,8,10,12,15,17,19,21,23,26,28,30,32,34,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-125_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-125+orig'[2,4,6,9,11,14,16,18,21,23,26,28,31,33,35,38,40,42,45,47,49,52,54,57,59,61,64,66,68,71,73,75]'

# sub-126
stats_dir=$afni_dir/sub-126_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,33,35,37,40,42,44,47,49,51,54,56,58,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-126_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,11,13,15,17,20,22,24,26,28,30,33,35,37,39,41,44,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,92,94,96,98,100,103,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,30,33,35,37,39,41,43,46,48,50,52,55,57,59,61,63,65,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,117,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,11,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,93,95,98,100,102,104,106,109,111,113,115,117,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,33,35,37,39,41,43,46,48,50,52,54,57,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-126_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-126+orig'[2,4,6,9,11,13,16,18,20,23,25,27,30,32,34,37,39,41,44,46,49,51,54,56,58,61,63,66,68,71,73,75]'

# sub-127
stats_dir=$afni_dir/sub-127_r01.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,58,61,63,66,68,71,73,75]'

stats_dir=$afni_dir/sub-127_r02.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,38,41,43,45,47,50,52,54,56,59,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r03.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,71,74,76,78,80,82,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r04.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,12,15,17,19,21,23,25,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,62,65,67,69,71,73,75,78,80,82,84,87,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,122,124,126,128,130,132,135,137,139]'

stats_dir=$afni_dir/sub-127_r05.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,33,35,37,39,41,43,46,48,50,52,54,56,59,61,63,65,67,70,72,74,76,78,81,83,85,87,89,91,94,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r06.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,13,15,17,19,22,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,70,72,74,76,78,80,83,85,87,89,91,93,96,98,100,102,104,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r07.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,13,15,17,19,21,24,26,28,30,32,35,37,39,41,43,45,48,50,52,54,56,58,61,63,65,67,69,72,74,76,78,80,83,85,87,89,91,94,96,98,100,102,105,107,109,111,113,116,118,120,122,124,126,129,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r08.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,10,13,15,17,19,21,23,26,28,30,32,34,36,39,41,43,45,47,49,52,54,56,58,60,63,65,67,69,71,73,76,78,80,82,84,86,89,91,93,95,97,100,102,104,106,108,110,113,115,117,119,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r09.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,8,11,13,15,17,19,21,24,26,28,31,33,35,37,39,42,44,46,48,50,52,55,57,59,61,63,66,68,70,72,74,76,79,81,83,85,87,89,92,94,96,98,100,102,105,107,109,111,113,115,118,120,122,124,126,128,131,133,135,137,139]'

stats_dir=$afni_dir/sub-127_r10.results
3dTcat -overwrite \
	-prefix $stats_dir/all-stim_allTstats.nii \
	$stats_dir/stats.sub-127+orig'[2,4,6,9,11,13,16,18,20,23,25,28,30,32,35,37,39,42,44,47,49,51,54,56,59,61,63,66,68,71,73,75]'

