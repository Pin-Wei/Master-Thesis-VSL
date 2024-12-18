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
	-num_glt 8 \
		-gltLabel 1 'r02__1.vs.3' -gltCode 1 'Run : 1*r02 Order : 1*Fst -1*Trd' \
		-gltLabel 2 'r03__1.vs.3' -gltCode 2 'Run : 1*r03 Order : 1*Fst -1*Trd' \
		-gltLabel 3 'r04__1.vs.3' -gltCode 3 'Run : 1*r04 Order : 1*Fst -1*Trd' \
		-gltLabel 4 'r05__1.vs.3' -gltCode 4 'Run : 1*r05 Order : 1*Fst -1*Trd' \
		-gltLabel 5 'r06__1.vs.3' -gltCode 5 'Run : 1*r06 Order : 1*Fst -1*Trd' \
		-gltLabel 6 'r07__1.vs.3' -gltCode 6 'Run : 1*r07 Order : 1*Fst -1*Trd' \
		-gltLabel 7 'r08__1.vs.3' -gltCode 7 'Run : 1*r08 Order : 1*Fst -1*Trd' \
		-gltLabel 8 'r09__1.vs.3' -gltCode 8 'Run : 1*r09 Order : 1*Fst -1*Trd' \
	-num_glf 15 \
		-glfLabel 1 'L.vs.N__r02__1.vs.3' -glfCode 1 'Group : 1*Learn -1*No Run : 1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 2 'L.vs.N__r03__1.vs.3' -glfCode 2 'Group : 1*Learn -1*No Run : 1*r03 Order : 1*Fst -1*Trd' \
		-glfLabel 3 'L.vs.N__r04__1.vs.3' -glfCode 3 'Group : 1*Learn -1*No Run : 1*r04 Order : 1*Fst -1*Trd' \
		-glfLabel 4 'L.vs.N__r05__1.vs.3' -glfCode 4 'Group : 1*Learn -1*No Run : 1*r05 Order : 1*Fst -1*Trd' \
		-glfLabel 5 'L.vs.N__r06__1.vs.3' -glfCode 5 'Group : 1*Learn -1*No Run : 1*r06 Order : 1*Fst -1*Trd' \
		-glfLabel 6 'L.vs.N__r07__1.vs.3' -glfCode 6 'Group : 1*Learn -1*No Run : 1*r07 Order : 1*Fst -1*Trd' \
		-glfLabel 7 'L.vs.N__r08__1.vs.3' -glfCode 7 'Group : 1*Learn -1*No Run : 1*r08 Order : 1*Fst -1*Trd' \
		-glfLabel 8 'L.vs.N__r09__1.vs.3' -glfCode 8 'Group : 1*Learn -1*No Run : 1*r09 Order : 1*Fst -1*Trd' \
		-glfLabel  9 'r03.vs.02__1.vs.3' -glfCode  9 'Run : 1*r03 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 10 'r04.vs.02__1.vs.3' -glfCode 10 'Run : 1*r04 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 11 'r05.vs.02__1.vs.3' -glfCode 11 'Run : 1*r05 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 12 'r06.vs.02__1.vs.3' -glfCode 12 'Run : 1*r06 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 13 'r07.vs.02__1.vs.3' -glfCode 13 'Run : 1*r07 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 14 'r08.vs.02__1.vs.3' -glfCode 14 'Run : 1*r08 -1*r02 Order : 1*Fst -1*Trd' \
		-glfLabel 15 'r09.vs.02__1.vs.3' -glfCode 15 'Run : 1*r09 -1*r02 Order : 1*Fst -1*Trd' \
	-dataTable @$data_table
		