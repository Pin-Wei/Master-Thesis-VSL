#!/usr/bin/env python
# coding: utf-8

import os
import argparse
import pandas as pd
import numpy as np

top_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus")
stat_dir = os.path.join(top_dir, "Combined_group", "derivatives", "Group_analysis")

ap_folder = "ap.runs_MNI_3ord_v6" # default
stat_folder = "MVM" # default
file_dir = os.path.join(stat_dir, ap_folder, stat_folder, "files_ClustSim")

parser = argparse.ArgumentParser(description="")
parser.add_argument("--file_dir", type=str, default=file_dir)
parser.add_argument("--csim_prefix", type=str, required=True)
parser.add_argument("--NN", type=int, default=3)
parser.add_argument("--side", type=str, default="bisided")
parser.add_argument("--p_val", type=float, default=0.001)
parser.add_argument("--alpha", type=float, default=0.05, 
                    help="cluster level alpha value = Prob(Cluster >= given size)")
args = parser.parse_args()

file_dir = args.file_dir
csim_prefix = args.csim_prefix
nn = args.NN
side = args.side
p_val = args.p_val
alpha = args.alpha
default_alpha_list = np.round(np.arange(0.1, 0, -0.01, dtype=float), 2).tolist()
default_alpha_list.insert(0, "pthr") # ['pthr', .10, .09, .08, .07, .06, .05, .04, .03, .02, .01]

### Read the cluster threshold from the ClustSim output file:
# - colnames: corrected (whole volume) alpha-values
# - indexs: uncorrected (per voxel) p-values 
clustsim_fn = "{:}.NN{:}_{:}.1D".format(csim_prefix, nn, side)
thresholds = pd.read_csv(os.path.join(file_dir, clustsim_fn), 
                         delim_whitespace=True, 
                         comment="#", 
                         index_col=0, header=None)

col = default_alpha_list.index(alpha)
n_vox = np.ceil(thresholds[col][p_val]) # cluster threshold
print(int(n_vox))