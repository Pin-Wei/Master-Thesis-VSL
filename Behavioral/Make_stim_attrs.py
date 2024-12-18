
import os
import re
import glob
import pandas as pd

file_list = glob.glob(os.path.join("logs", "*", '???_jigg_task.xlsx'))
for file_path in sorted(file_list, key=lambda s: int(re.search(r'\d+', s).group())):
    file_name = file_path.split("/")[-1]
    sid = int(file_name[:3])
    subj = "sub-{:03d}".format(sid) if sid > 100 else "sub-{:02d}".format(sid)
    
    # subj = re.findall(r'(sub-[\d]+).csv', file_name)[0]
    # sid = subj.replace("sub-", "")
    top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus", 
                           "Nifti_slow" if sid > 100 else "Nifti")

    sheet_list = ['RUN_{:}'.format(run) for run in range(1,11)]
    R = 1
    for sheet in sheet_list:
        Data = pd.read_excel(file_path, sheet_name=sheet, engine='openpyxl')
        Data = Data[Data.Task != 1]
        Data["Run"] = " {:02d}".format(R)
        Triplet_IDs = Data.Triplet.apply(lambda x: {1:"A", 2:"B", 3:"C", 4:"D"}[x])

        out_dir = os.path.join(top_dir, "derivatives", "afni_out", "SS_results_runs_v4.2", 
                               "{:}_r{:02d}.results".format(subj, R))
        
        tpls = list(Triplet_IDs + Data.Run)
        with open(os.path.join(out_dir, "LSS.all-stim_Triplets_attrs.txt"), "w") as f:
            f.write("\n".join(tpls))

        stims = list(Triplet_IDs + Data.Label.astype('str') + Data.Run)      
        with open(os.path.join(out_dir, "LSS.all-stim_attrs.txt"), "w") as f:
            f.write("\n".join(stims))

        R += 1
