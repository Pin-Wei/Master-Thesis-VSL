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
		-gltLabel  1 'Fst' -gltCode 1 'Order : 1*Fst Score :' \
		-gltLabel  2 'Snd' -gltCode 2 'Order : 1*Snd Score :' \
		-gltLabel  3 'Trd' -gltCode 3 'Order : 1*Trd Score :' \
		-gltLabel  4 'post.hoc__1.vs.2' -gltCode 4 'Order : 1*Fst -1*Snd Score :' \
		-gltLabel  5 'post.hoc__2.vs.3' -gltCode 5 'Order : 1*Snd -1*Trd Score :' \
		-gltLabel  6 'post.hoc__3.vs.1' -gltCode 6 'Order : 1*Trd -1*Fst Score :' \
		-gltLabel  7 '12.vs.3' -gltCode 7 'Order : 1*Fst +1*Snd -2*Trd Score :' \
		-gltLabel  8 '23.vs.1' -gltCode 8 'Order : 1*Snd +1*Trd -2*Fst Score :' \
		-gltLabel  9 '12.vs.3__R.23' -gltCode  9 'Run : 1*r02 +1*r03 Order : 1*Fst +1*Snd -2*Trd Score :' \
		-gltLabel 10 '12.vs.3__R.45' -gltCode 10 'Run : 1*r04 +1*r05 Order : 1*Fst +1*Snd -2*Trd Score :' \
		-gltLabel 11 '12.vs.3__R.67' -gltCode 11 'Run : 1*r06 +1*r07 Order : 1*Fst +1*Snd -2*Trd Score :' \
		-gltLabel 12 '12.vs.3__R.89' -gltCode 12 'Run : 1*r08 +1*r09 Order : 1*Fst +1*Snd -2*Trd Score :' \
		-gltLabel 13 '23.vs.1__R.23' -gltCode 13 'Run : 1*r02 +1*r03 Order : 1*Snd +1*Trd -2*Fst Score :' \
		-gltLabel 14 '23.vs.1__R.45' -gltCode 14 'Run : 1*r04 +1*r05 Order : 1*Snd +1*Trd -2*Fst Score :' \
		-gltLabel 15 '23.vs.1__R.67' -gltCode 15 'Run : 1*r06 +1*r07 Order : 1*Snd +1*Trd -2*Fst Score :' \
		-gltLabel 16 '23.vs.1__R.89' -gltCode 16 'Run : 1*r08 +1*r09 Order : 1*Snd +1*Trd -2*Fst Score :' \
		-gltLabel 17 'Fst__linear.decay' -gltCode 17 'Order : 1*Fst Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
		-gltLabel 18 'Snd__linear.decay' -gltCode 18 'Order : 1*Snd Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
		-gltLabel 19 'Trd__linear.decay' -gltCode 19 'Order : 1*Trd Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
	-num_glf 2 \
		-glfLabel 1 '12.vs.3__linear.decay' -glfCode 1 'Order : 1*Fst +1*Snd -2*Trd Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
		-glfLabel 2 '23.vs.1__linear.decay' -glfCode 2 'Order : 1*Snd +1*Trd -2*Fst Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09 Score :' \
	-dataTable @$data_table
		