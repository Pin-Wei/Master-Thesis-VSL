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
	-num_glt 6 \
		-gltLabel 1 'Fst' -gltCode 1 'Order : 1*Fst' \
		-gltLabel 2 'Snd' -gltCode 2 'Order : 1*Snd' \
		-gltLabel 3 'Trd' -gltCode 3 'Order : 1*Trd' \
		-gltLabel 4 'Fst__linear.increase' -gltCode 4 'Order : 1*Fst Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
		-gltLabel 5 'Snd__linear.increase' -gltCode 5 'Order : 1*Snd Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
		-gltLabel 6 'Trd__linear.increase' -gltCode 6 'Order : 1*Trd Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
	-num_glf 3 \
		-glfLabel 1 '1.vs.3__linear.increase'  -glfCode 1 'Order : 1*Fst -1*Trd Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
		-glfLabel 2 '12.vs.3__linear.increase' -glfCode 2 'Order : 1*Fst +1*Snd -2*Trd Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
		-glfLabel 3 '23.vs.1__linear.increase' -glfCode 3 'Order : 1*Snd +1*Trd -2*Fst Run : 1*r02 +2*r03 +3*r04 +4*r05 +5*r06 +6*r07 +7*r08 +8*r09' \
	-dataTable @$data_table
		