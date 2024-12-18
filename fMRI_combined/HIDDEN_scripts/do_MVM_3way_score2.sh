#!/usr/bin/env tcsh

set ss_ver = $1
set mvm_mask = $2
set data_table = $3
set PREFIX = $4

3dMVM -overwrite \
	-prefix $PREFIX 		\
	-resid ${PREFIX}_resid 	\
	-mask $mvm_mask 	 	\
	-bsVars 'Score' 		\
	-wsVars 'Run*Order'		\
	-qVars  'Score'         \
	-qVarCenters '0.5'      \
	-SC -GES -dbgArgs		\
	-num_glt 19             \
		-gltLabel  1 'expo_r1'  -gltCode  1 'Run : 1*r02 Score :' \
		-gltLabel  2 'expo_r2'  -gltCode  2 'Run : 1*r03 Score :' \
		-gltLabel  3 'expo_r3'  -gltCode  3 'Run : 1*r04 Score :' \
		-gltLabel  4 'expo_r4'  -gltCode  4 'Run : 1*r05 Score :' \
		-gltLabel  5 'expo_r5'  -gltCode  5 'Run : 1*r06 Score :' \
		-gltLabel  6 'expo_r6'  -gltCode  6 'Run : 1*r07 Score :' \
		-gltLabel  7 'expo_r7'  -gltCode  7 'Run : 1*r08 Score :' \
		-gltLabel  8 'expo_r8'  -gltCode  8 'Run : 1*r09 Score :' \
		-gltLabel  9 'expo_r12' -gltCode  9 'Run : 1*r02 +1*r03 Score :' \
		-gltLabel 10 'expo_r34' -gltCode 10 'Run : 1*r04 +1*r05 Score :' \
		-gltLabel 11 'expo_r56' -gltCode 11 'Run : 1*r06 +1*r07 Score :' \
		-gltLabel 12 'expo_r78' -gltCode 12 'Run : 1*r08 +1*r09 Score :' \
		-gltLabel 13 'expo_r1234' -gltCode 13 'Run : 1*r02 +1*r03 +1*r04 +1*r05 Score :' \
		-gltLabel 14 'expo_r5678' -gltCode 14 'Run : 1*r06 +1*r07 +1*r08 +1*r09 Score :' \
		-gltLabel 15 'early_vs_late' -gltCode 15 'Run : 1*r02 +1*r03 +1*r04 +1*r05 -1*r06 -1*r07 -1*r08 -1*r09 Score :' \
		-gltLabel 16 'lin.dec' -gltCode 16 'Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
		-gltLabel 17 'log.dec' -gltCode 17 'Run : 3.079*r02 +2.945*r03 +2.791*r04 +2.609*r05 +2.386*r06 +2.098*r07 +1.693*r08 +1*r09 Score :' \
		-gltLabel 18 'lin.inc' -gltCode 18 'Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09 Score :' \
		-gltLabel 19 'log.inc' -gltCode 19 'Run : 1*r02 +1.693*r03 +2.098*r04 +2.386*r05 +2.609*r06 +2.791*r07 +2.945*r08 +3.079*r09 Score :' \
	-dataTable @$data_table
