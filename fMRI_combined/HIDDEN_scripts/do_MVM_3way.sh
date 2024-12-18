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
	-num_glt 16 \
		-gltLabel  1 'L.vs.N' -gltCode 1 'Group : 1*Learn -1*No' \
		-gltLabel  2 'learn__ord.F' -gltCode 2 'Group : 1*Learn Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel  3 'learn__1.vs.2' -gltCode 3 'Group : 1*Learn Order : 1*Fst -1*Snd' \
		-gltLabel  4 'learn__3.vs.2' -gltCode 4 'Group : 1*Learn Order : 1*Trd -1*Snd' \
		-gltLabel  5 'learn__1.vs.3' -gltCode 5 'Group : 1*Learn Order : 1*Fst -1*Trd' \
		-gltLabel  6 'learn__12.vs.3' -gltCode 6 'Group : 1*Learn Order : 1*Fst +1*Snd -2*Trd' \
		-gltLabel  7 'learn__23.vs.1' -gltCode 7 'Group : 1*Learn Order : 1*Snd +1*Trd -2*Fst' \
		-gltLabel  8 'learn__2.vs.13' -gltCode 8 'Group : 1*Learn Order : 2*Snd -1*Fst -1*Trd' \
		-gltLabel  9 'r02__ord.F' -gltCode  9 'Run : 1*r02 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 10 'r03__ord.F' -gltCode 10 'Run : 1*r03 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 11 'r04__ord.F' -gltCode 11 'Run : 1*r04 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 12 'r05__ord.F' -gltCode 12 'Run : 1*r05 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 13 'r06__ord.F' -gltCode 13 'Run : 1*r06 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 14 'r07__ord.F' -gltCode 14 'Run : 1*r07 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 15 'r08__ord.F' -gltCode 15 'Run : 1*r08 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-gltLabel 16 'r09__ord.F' -gltCode 16 'Run : 1*r09 Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
	-num_glf 7 \
		-glfLabel  1 'L.vs.N__ord.F' -glfCode 1 'Group : 1*Learn -1*No Order : 1*Fst -1*Snd & 1*Trd -1*Snd' \
		-glfLabel  2 'L.vs.N__1.vs.2' -glfCode 2 'Group : 1*Learn -1*No Order : 1*Fst -1*Snd' \
		-glfLabel  3 'L.vs.N__3.vs.2' -glfCode 3 'Group : 1*Learn -1*No Order : 1*Trd -1*Snd' \
		-glfLabel  4 'L.vs.N__1.vs.3' -glfCode 4 'Group : 1*Learn -1*No Order : 1*Fst -1*Trd' \
		-glfLabel  5 'L.vs.N__12.vs.3' -glfCode 5 'Group : 1*Learn -1*No Order : 1*Fst +1*Snd -2*Trd' \
		-glfLabel  6 'L.vs.N__23.vs.1' -glfCode 6 'Group : 1*Learn -1*No Order : 1*Snd +1*Trd -2*Fst' \
		-glfLabel  7 'L.vs.N__2.vs.13' -glfCode 7 'Group : 1*Learn -1*No Order : 2*Snd -1*Trd -1*Fst' \
	-dataTable @$data_table
		
# =============================================================================
# ~ Notes ~
# *** Separate into 2 groups (1*Learned vs Not learned) 
# *** Considering potential non-linear changes, 
#     runs are not entered as quantitative variables.
# *** By default, using Type-III sums of squares for the omnibus F-statistics.
# *** By default, mean centering is performed voxel-wise across all subjects.

# ~ Add options ~
# -resid
# -SC   : additionally output the F-statistics of sphericity correction 
#         (when the assumption is violated) for main and interaction effects.
# -GES  : As an analog of the determination coefficient R^2 in multiple regression,
#         generalized eta-squared (GES) provides a measure of effect size 
#         for each F-stat in ANOVA or general GLM.

# -----------------------------------------------------------------------------
		# -gltLabel 11 'L.vs.N__1st' -gltCode 11 'Group : 1*Learn -1*No Order : Fst' \
		# -glfLabel 12 'L.vs.N__2nd' -glfCode 12 'Group : 1*Learn -1*No Order : Snd' \
		# -glfLabel 13 'L.vs.N__3rd' -glfCode 13 'Group : 1*Learn -1*No Order : Trd' \
		# -gltLabel 14 'L.vs.N__1st__anyrun' -gltCode 11 'Group : 1*Learn -1*No Order : Fst Run : 1*r02 | 1*r03 | 1*r04 | 1*r05 | 1*r06 | 1*r07 | 1*r08 | 1*r09' \
		# -glfLabel 15 'L.vs.N__2nd__anyrun' -glfCode 12 'Group : 1*Learn -1*No Order : Snd Run : 1*r02 | 1*r03 | 1*r04 | 1*r05 | 1*r06 | 1*r07 | 1*r08 | 1*r09' \
		# -glfLabel 16 'L.vs.N__3rd__anyrun' -glfCode 13 'Group : 1*Learn -1*No Order : Trd Run : 1*r02 | 1*r03 | 1*r04 | 1*r05 | 1*r06 | 1*r07 | 1*r08 | 1*r09' \
