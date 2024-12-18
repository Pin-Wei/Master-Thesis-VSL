#!/usr/bin/env tcsh

# tcsh Execute_RBA.sh $reml $model

## Region-Based Analysis (RBA) through Bayesian multilevel (BML) modeling
## theoretical manuscript: https://rdcu.be/bhhJp

set afni_ver = 'runs_MNI_3ord_v6'
set cond_list = ( 'Fst' 'Snd' 'Trd' 'any.stim' \
	'1.and.2' '2.and.3' '1.vs.2' '3.vs.2' '1.vs.3' '1.2.vs.3' '2.3.vs.1' '1.vs.2.3' '3.vs.1.2' )

# set afni_ver = 'runs_MNI_3ord_v5'
# set cond_list = ( 'Fst' 'Snd' 'Trd' '1+2+3' '1+2' '2+3' '1-2' '3-2' '1-3' )

switch ( $1 )
	case '0':
		set reml = ''
		breaksw
	case '1':
		set reml = '_REML'
		breaksw
endsw

switch ( $2 )
	case '0':
		set output_ID = model${reml}_basic
		set dist = 'gaussian'
		set model = 1
		set eoi_opt = 'Intercept'
		set eoi_list = ( Intercept ) # effects of interest
		set opt_add = ""
		breaksw
	case '1':
		set output_ID = model${reml}_StudY
		set dist = 'student'
		set model = 1
		set eoi_opt = 'Intercept'
		set eoi_list = ( Intercept )
		set opt_add = ""
		breaksw
	# case '2':
		# set output_ID = model${reml}_Score
		# set dist = 'gaussian'
		# set model = '1+Score'
		# set eoi_opt = 'Intercept,Score'
		# set eoi_list = ( Intercept Score )
		# set opt_add = "-qVars 'Score'"
		# breaksw
endsw

set bml_dir = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/RBA
set data_dir = $bml_dir/$afni_ver/dataSet${reml}

set out_dir = $bml_dir/$afni_ver/$output_ID
if ( ! -d $out_dir ) mkdir -p $out_dir
mkdir -p $out_dir/PDF_images
mkdir -p $out_dir/ridge_images

foreach x ( `seq 1 ${#cond_list}` )
	set cond = ${cond_list[$x]}
	
	foreach run ( `seq -f "%02g" 2 9` )
		set desc = ${cond}_run-${run} 
	
		RBA -overwrite          \
			-StanPath "/home/aclexp/.cmdstan/cmdstan-2.32.2" \
			-dataTable $data_dir/data_${desc}.txt            \
			-prefix $out_dir/${afni_ver}_${desc}             \
			-chains 4 -WCP 6    \
			-iterations 1000    \
			-model $model       \
			-distY $dist        \
			-EOI $eoi_opt       \
			$opt_add            \
			-PDP 7 4			\
			-ridgePlot 6 12
		
		foreach eoi ( ${eoi_list[*]} )
			mv ${eoi}_PDF.pdf ${eoi}_${desc}_PDF.pdf
			mv ${eoi}_ridge.pdf ${eoi}_${desc}_ridge.pdf
		end
	end
end

mv *PDF.pdf $out_dir/PDF_images
mv *ridge.pdf $out_dir/ridge_images