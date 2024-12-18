# #!/usr/bin/bash

# case $1 in
	# vsl ) subj_list=`cat subjList_1.txt` ;;
	# slowVSL ) subj_list=`cat subjList_2.txt` ;;
# esac
# afni_dir=$2
# script_dir=$3

# attr_fn='all-stim_attrs.txt'
# tpl_attr_fn='all-stim_Triplets_attrs.txt'

# for reml in '' '_REML' ; do
	# for estm in 'Betas' 'Tstats' ; do
		# script_name=extract_single-runs-trial_${estm}${reml}_script.sh
		# script_file=$script_dir/$script_name
		
		# stats_fn='stats.'${subj}${reml}'+orig'
		# out_fn='all-stim_all'${estm}${reml}'.nii'
		
		# if [ -f $script_file ]; then rm $script_file; fi
		# echo '#!/bin/bash' >> $script_file
		# echo >> $script_file
		# echo 'afni_dir='$afni_dir >> $script_file
		# echo >> $script_file

		# for subj in ${subj_list[*]} ; do
			# echo '#' $subj >> $script_file
			# echo 'stats_dir=$afni_dir/'${subj}'.results' >> $script_file
			# stats_dir=$afni_dir/${subj}.results
			# stim_dir=$stats_dir/stimuli
			
			# stats_file=$stats_dir/$stats_fn		
			# out_file=$stats_dir/$out_fn
			# attr_file=$stats_dir/$attr_fn
			# tpl_attr_file=$stats_dir/$tpl_attr_fn
			
			# # Initialize:
			# case $estm in
				# Betas ) t2=-1 ;;
				# Tstats ) t2=0 ;;
			# esac
			# if [ -f $attr_file ]; then rm $attr_file ; fi
			# if [ -f $tpl_attr_file ]; then rm $tpl_attr_file ; fi
			
			# # for each condition:
			# for cond in ${cond_list[*]} ; do
				
				# # start point of the sub-brick:
				# t1=`expr ${t2} + 2`
				# eval ${cond}_1=$t1   
				
				# # number of sub-brick:
				# n_t=`cat $stim_dir/offset_${cond}_exposure-runs.1D | wc -w`	
				
				# # end point of the sub-brick:
				# t2=`expr ${n_t} \* 2 + ${t1} - 1`
				# eval ${cond}_2=$t2
				
				# # write attribute file(s):
				# for count in `seq 1 8` ; do
					# run=`expr ${count} + 1`
					
					# # number of condition for each run:
					# n_c=`awk -v c=${count} 'NR==c {print NF}' $stim_dir/offset_${cond}_exposure-runs.1D`
					
					# for ((i=0; i<$n_c; i++)); do
						# echo $cond $run >> $attr_file
						
						# Tpl_ID=`echo ${cond} | sed 's/[0-9]//g'`
						# echo $Tpl_ID $run >> $tpl_attr_file
					# done
				# done
			# done
			
			# # extract sub-bricks:
			# echo '3dTcat -overwrite -prefix '${out_file}' \' >> $script_file
			# echo '	'${stats_file}"'[" \
				# ${A1_1}'-'${A1_2}'(2), ' \
				# ${A2_1}'-'${A2_2}'(2), ' \
				# ${A3_1}'-'${A3_2}'(2), ' \
				# ${B1_1}'-'${B1_2}'(2), ' \
				# ${B2_1}'-'${B2_2}'(2), ' \
				# ${B3_1}'-'${B3_2}'(2), ' \
				# ${C1_1}'-'${C1_2}'(2), ' \
				# ${C2_1}'-'${C2_2}'(2), ' \
				# ${C3_1}'-'${C3_2}'(2), ' \
				# ${D1_1}'-'${D1_2}'(2), ' \
				# ${D2_1}'-'${D2_2}'(2), ' \
				# ${D3_1}'-'${D3_2}"(2)]'" >> $script_file		
			# echo >> $script_file
		# done

		# bash $script_file
	# done
# done