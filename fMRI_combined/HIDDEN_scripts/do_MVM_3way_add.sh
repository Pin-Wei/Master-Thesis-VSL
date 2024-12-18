#!/usr/bin/env tcsh

set ss_ver = $1
set mvm_mask = $2
set data_table = $3
set PREFIX = $4

3dMVM -overwrite \
	-prefix $PREFIX 		\
	-resid ${PREFIX}_resid 	\
	-mask $mvm_mask 	 	\
	-bsVars 'Group' 		\
	-wsVars 'Run*Order'		\
	-SC -GES -dbgArgs		\
	-num_glt 9 \
		-gltLabel  1 'All__linear.decay' -gltCode 1 'Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
		-gltLabel  2 'Fst__linear.decay' -gltCode 2 'Order : 1*Fst Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
		-gltLabel  3 'Snd__linear.decay' -gltCode 3 'Order : 1*Snd Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
		-gltLabel  4 'Trd__linear.decay' -gltCode 4 'Order : 1*Trd Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
		-gltLabel  5 '1.vs.2'  -gltCode  5 'Order : 1*Fst -1*Snd' \
		-gltLabel  6 '3.vs.2'  -gltCode  6 'Order : 1*Trd -1*Snd' \
		-gltLabel  7 '1.vs.3'  -gltCode  7 'Order : 1*Fst -1*Trd' \
		-gltLabel  8 '12.vs.3' -gltCode  8 'Order : 1*Fst +1*Snd -2*Trd' \
		-gltLabel  9 '23.vs.1' -gltCode  9 'Order : 1*Snd +1*Trd -2*Fst' \
	-num_glf 8 \
		-glfLabel  1 'L.vs.N__linear.decay' -glfCode 1 'Group : 1*Learn -1*No Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
		-glfLabel  2 'learn__1.vs.2.vs.3'   -glfCode 2 'Group : 1*Learn Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-glfLabel  3 'learn__1.vs.2'  -glfCode 3 'Group : 1*Learn Order : 1*Fst -1*Snd' \
		-glfLabel  4 'learn__3.vs.2'  -glfCode 4 'Group : 1*Learn Order : 1*Trd -1*Snd' \
		-glfLabel  5 'learn__1.vs.3'  -glfCode 5 'Group : 1*Learn Order : 1*Fst -1*Trd' \
		-glfLabel  6 'learn__12.vs.3' -glfCode 6 'Group : 1*Learn Order : 1*Fst +1*Snd -2*Trd' \
		-glfLabel  7 'learn__23.vs.1' -glfCode 7 'Group : 1*Learn Order : 1*Snd +1*Trd -2*Fst' \
		-glfLabel  8 'learn__linear.decay'  -glfCode 8 'Group : 1*Learn Run : 8*r02 +7*r03 +6*r04 +5*r05 +4*r06 +3*r07 +2*r08 +1*r09' \
	-dataTable @$data_table
		