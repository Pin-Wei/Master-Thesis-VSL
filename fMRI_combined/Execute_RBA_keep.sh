# #!/usr/bin/env tcsh
# # tcsh Execute_RBA.sh $reml

# # Region-Based Analysis (RBA) through Bayesian multilevel (BML) modeling
# # theoretical manuscript: https://rdcu.be/bhhJp

# set afni_ver = 'runs_MNI_3ord_v5'

# switch ( $1 )
	# case '0':
		# set reml = ''
		# breaksw
	# case '1':
		# set reml = '_REML'
		# breaksw
# endsw

# set bml_dir = /media/data2/pinwei/SL_hippocampus/Combined_group/derivatives/RBA
# set data_dir = $bml_dir/$afni_ver/dataSet${reml}

# set out_dir = $bml_dir/$afni_ver/$output_ID
# if ( ! -d $out_dir ) mkdir -p $out_dir
# mkdir -p $out_dir/PDF_images
# mkdir -p $out_dir/ridge_images

# set desc = 'allCond'
	
# RBA -overwrite \
	# -StanPath "/home/aclexp/.cmdstan/cmdstan-2.32.2" \
	# -dataTable $data_dir/data_${desc}.txt            \
	# -prefix $out_dir/${afni_ver}_${desc}             \
	# -chains 4 -WCP 6    \
	# -iterations 1000    \
	# -model              \
	# -distY $dist        \
	# -EOI $eoi_opt       \
	# $opt_add            \
	# -PDP 7 4			\
	# -ridgePlot 6 12

# foreach eoi ( ${eoi_list[*]} )
	# mv ${eoi}_PDF.pdf ${eoi}_${desc}_PDF.pdf
	# mv ${eoi}_ridge.pdf ${eoi}_${desc}_ridge.pdf
# end

# mv *PDF.pdf $out_dir/PDF_images
# mv *ridge.pdf $out_dir/ridge_images