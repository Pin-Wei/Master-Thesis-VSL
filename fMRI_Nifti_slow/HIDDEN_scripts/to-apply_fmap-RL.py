import json
import os
import glob
os.path.join

# bids = '/mnt/d/VSL_fMRI_slowEvent/Nifti/'
bids = '/media/data2/pinwei/SL_hippocampus/Nifti_slow'
# bids = 'D:/VSL_fMRI_slowEvent/Nifti/'

subs = glob.glob(os.path.join(bids,'sub-???'))
bids_json = bids+'/sub*/fmap/*.json'
os.chmod(bids, 0o0777)

for sub in subs:
    func_niis = [x.replace(sub+'/','') for x in glob.glob(os.path.join(sub,'func/*.nii*'))]
    fmaps_jsons = glob.glob(sub+'/fmap/*RL_phasediff.json')

    for file in fmaps_jsons:
        with open(file) as f:
            oldfile = json.load(f)
        new_meta = {"IntendedFor": func_niis, "B0FieldIdentifier": "phasediff_fmap0"}
        oldfile.update(new_meta)
        
        with open(file, 'w') as outfile:
            json.dump(oldfile, outfile, indent=2, sort_keys=True)

