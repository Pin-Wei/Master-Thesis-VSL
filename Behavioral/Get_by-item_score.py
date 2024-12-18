
import os
import re
import glob
import numpy as np
import pandas as pd

file_list = glob.glob(os.path.join("familarity_test", "???_test_result.xlsx"))

ACC, subj_list = {}, []
for file_path in sorted(file_list, key=lambda s: int(re.search(r'\d+', s).group())):
    file_name = file_path.split("/")[-1]
    sid = int(file_name[:3])
    subj = "sub-{:03d}".format(sid) if sid > 100 else "sub-{:02d}".format(sid)
    subj_list.append(subj)

    Behav_data = pd.read_excel(file_path, engine='openpyxl')
    Scores = np.zeros(shape=(4, 3))
    Basis  = np.zeros(shape=(4, 3))

    for q, score in enumerate(Behav_data["correct"]):
        tpl = Behav_data["Triplet_ID"][q] - 1

        if Behav_data["Triplet_Pair"][q] == "Triplet":
            for ord in [0, 1, 2]:
                Scores[tpl][ord] += score
                Basis[tpl][ord] += 1
        elif (Behav_data["Triplet_Pair"][q][0] == '1') or (Behav_data["Question_type"][q][-1] == '1'):
            for ord in [0, 1]:
                Scores[tpl][ord] += score
                Basis[tpl][ord] += 1
        else:
            for ord in [1, 2]:
                Scores[tpl][ord] += score
                Basis[tpl][ord] += 1

    ACC[sid] = [ round(acc, 2) for acc in (Scores/Basis).flatten() ]

outfile = pd.DataFrame(ACC).T
outfile.columns = ["A-1st", "A-2nd", "A-3rd", "B-1st", "B-2nd", "B-3rd", "C-1st", "C-2nd", "C-3rd", "D-1st", "D-2nd", "D-3rd"]
outfile.to_csv(os.path.join("familarity_test", "by-item_score.csv"))

for subj in subj_list:
    sid = int(subj.replace("sub-", ""))
    event_files = glob.glob(os.path.join("/media", "data2", "pinwei", "SL_hippocampus", "*", "derivatives", "event.v2", 
                                         "{:}_task-*_run-??_events.v2.tsv".format(subj)))
    for event_file in event_files:
        event_df = pd.read_csv(event_file, sep="\t")
        event_df.insert(
            loc=2, column="amplitude", 
            value=event_df["trial_type"].apply(lambda x: outfile.T[sid][x])
        )
        out_path = event_file.replace("event.v2", "event.AM")
        out_dir = "/".join(out_path.split("/")[:-1])
        if not os.path.exists(out_dir):
            os.makedirs(out_dir)

        event_df.to_csv(out_path, sep="\t", index=False)


