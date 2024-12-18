#!/usr/bin/env tcsh

set top_dir = /media/data2/pinwei/SL_hippocampus
set pfx = PW
set task = vsl
set fn = Nifti

sudo chmod 777 -R ..

# foreach sid ( `seq -f "%02g" $1 1 $2` )
	# set ssid = 0$sid
foreach subj ( `cat subjList.txt` )
	set sid = `echo ${subj:s/sub-//}`
	set ssid = `echo ${subj:s/sub-/0/}`
	set fn_prefix = $top_dir/behavioral_data/logs/${pfx}${ssid}/sub-${sid}_task-${task}
	
	python HIDDEN_scripts/generate_eventfiles.py $ssid
		
	cp -R ${fn_prefix}_run-??_events.tsv $top_dir/$fn/sub-${sid}/func/
	
	set event_v2_dir = $top_dir/$fn/derivatives/event.v2
	if ( ! -d $event_v2_dir ) mkdir $event_v2_dir	
	cp -R ${fn_prefix}_run-??_events.v2.tsv $event_v2_dir
	
	set event_v3_dir = $top_dir/$fn/derivatives/event.v3
	if ( ! -d $event_v3_dir ) mkdir $event_v3_dir
	foreach suffix ( 'events.v3' 'targets' 'Hit' 'miss' 'FA' )
		cp ${fn_prefix}_run-??_${suffix}.tsv $event_v3_dir
	end
end

