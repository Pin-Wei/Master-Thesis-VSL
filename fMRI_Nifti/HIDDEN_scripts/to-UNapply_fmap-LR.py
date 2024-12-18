import json
import os
import glob
os.path.join

bids = '/media/data2/pinwei/SL_hippocampus/Nifti'

subs = glob.glob(os.path.join(bids,'sub-??'))
bids_json = bids+'/sub*/fmap/*.json'
os.chmod(bids, 0o0777)

for sub in subs:
    fmaps_jsons = glob.glob(sub+'/fmap/*LR_phasediff.json')

    for file in fmaps_jsons:
        with open(file, 'r') as f:
            oldfile = json.load(f)
        try:
            del oldfile["IntendedFor"]
            del oldfile["B0FieldIdentifier"]
        except KeyError:
            pass
	
        with open(file, 'w') as outfile:
            json.dump(oldfile, outfile, indent=2, sort_keys=True)

