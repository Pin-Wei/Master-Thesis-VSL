#!/usr/bin/env python
# coding: utf-8

import os
import argparse
import pandas as pd
import numpy as np

parser = argparse.ArgumentParser(description="")
parser.add_argument("--table_path", type=str, required=True)
parser.add_argument("--atlas", type=str, default=, 
                    help="")
args = parser.parse_args()

clust_table_path = args.table_path
clust_table = pd.read_csv(clust_table_path, delim_whitespace=True, comment="#", 
                          index_col=0, header=None)
column_names = [
    "Volume", "CM_LR", "CM_PA", "CM_IS", 
    "minLR", "maxLR", "minPA", "maxPA"  "minIS"  "maxIS", 
    "Mean", "SEM", "Max_Int", "MI_LR", "MI_PA", "MI_IS"
] # see details: https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/alpha/3dclust_sphx.html#ahelp-3dclust

report_table = {
    "Voxels": clust_table[column_names.index("Volume")], 
    # Center of mass: 
    "CM_LR": clust_table[column_names.index("Volume")], 
    "CM_PA": clust_table[column_names.index("Volume")], 
    "CM_IS": clust_table[column_names.index("Volume")], 
    # Maximum Intensity (i.e., peak):
    "Max_Int": clust_table[column_names.index("Volume")], 
    "MI_LR": clust_table[column_names.index("Volume")], 
    "MI_PA": clust_table[column_names.index("Volume")], 
    "MI_IS": clust_table[column_names.index("Volume")], 

}