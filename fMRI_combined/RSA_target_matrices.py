#!/usr/bin/env python
# coding: utf-8

# conda activate pymvpa # --> to run with python2
# python RSA_target_matrices.py --plot_out

import os
import numpy as np
PLOT = False

# import argparse
# parser = argparse.ArgumentParser(description="")
# parser.add_argument("--plot_out", action='store_true', default=False)
# args = parser.parse_args()
# PLOT = args.plot_out

stim_list = ['A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','D3']
n_C = len(stim_list)

if PLOT:
    # from MVPA_functions import plot_mtx_Py3 as plot_mtx
    from MVPA_functions import plot_mtx_Py2 as plot_mtx

    out_dir = os.path.join("/media", "data2", "pinwei", "SL_hippocampus", 
                        "Combined_group", "derivatives", "PyMVPA", 
                        "RSA_target_matrices")
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)


## 1. Items that always appears together (i.e., within triplets):
within_tpl = np.zeros([n_C, n_C])
for x in range(4):
    within_tpl[3*x:3*x+3, 3*x:3*x+3] = 1
for y in range(n_C):
    within_tpl[y, y] = 0

if PLOT:
    title = 'within-triplet items'
    plot_mtx(within_tpl, stim_list, title, 
             fd=out_dir, fn="within_tpl.png",
             cmin=1, cmax=0, cmap='gray_r')
   

## 1.1 The 'first pairs' within each triplet:
fst_pairs = np.zeros([n_C, n_C])
for x in range(4):
    fst_pairs[3*x, 3*x+1] = 1
    fst_pairs[3*x+1, 3*x] = 1

if PLOT:
    title = 'The 1-st pairs\nwithin each triplets'
    plot_mtx(fst_pairs, stim_list, title, 
             fd=out_dir, fn="fst_pairs.png",
             cmin=1, cmax=0, cmap='gray_r')


## 1.2 The 'second pairs' within each triplet:
snd_pairs = np.zeros([n_C, n_C]) 
for x in range(4):
    snd_pairs[3*x+1, 3*x+2] = 1
    snd_pairs[3*x+2, 3*x+1] = 1

if PLOT:
    title = 'The 2-nd pairs\nwithin each triplets'
    plot_mtx(snd_pairs, stim_list, title, 
             fd=out_dir, fn="snd_pairs.png",
             cmin=1, cmax=0, cmap='gray_r')


## 1.3 Items that didn't adjcent but within same triplets:
tpl_nonadj = np.subtract(within_tpl, fst_pairs)
tpl_nonadj = np.subtract(tpl_nonadj, snd_pairs)

if PLOT:
    title = 'non-adjcent items\nwithin same triplets'
    plot_mtx(tpl_nonadj, stim_list, title, 
             fd=out_dir, fn="tpl_nonadj.png",
             cmin=1, cmax=0, cmap='gray_r')


## 2. Items that occationally appears together (i.e., across boundaries)
rare_connect = np.zeros([n_C, n_C])
for x in range(4):
    tpls = [0, 1, 2, 3]
    tpls.remove(x)    
    for t in tpls:
        rare_connect[3*x, 3*t+2] = 1
        rare_connect[3*x+2, 3*t] = 1

if PLOT:
    title = 'across-boundaries items'
    plot_mtx(rare_connect, stim_list, title, 
             fd=out_dir, fn="rare_connect.png",
             cmin=1, cmax=0, cmap='gray_r')
    

## 3. Items that never appears together:
irrelvant = np.ones([n_C, n_C])
for x in range(4):
    irrelvant[3*x:3*x+3, 3*x:3*x+3] = 0
    tpls = [0, 1, 2, 3]
    tpls.remove(x)
    for t in tpls:
        irrelvant[3*x, 3*t+2] = 0
        irrelvant[3*x+2, 3*t] = 0    
for y in range(n_C):
    irrelvant[y, y] = 0

if PLOT:
    title = 'irrelvant items'
    plot_mtx(irrelvant, stim_list, title, 
             fd=out_dir, fn="irrelvant.png",
             cmin=1, cmax=0, cmap='gray_r')


## 1.0 different triplets:
diff_tpl = np.ones([n_C, n_C])
for x in range(4):
    diff_tpl[3*x:3*x+3, 3*x:3*x+3] = 0

if PLOT:
    title = 'not within the same triplet '
    plot_mtx(diff_tpl, stim_list, title, 
             fd=out_dir, fn="diff_tpl.png",
             cmin=1, cmax=0, cmap='gray_r')
    

## Each triplet: 
tpl_A = within_tpl.copy()
tpl_A[3:, 3:] = 0

tpl_B = within_tpl.copy()
tpl_B = tpl_B - tpl_A
tpl_B[6:, 6:] = 0

tpl_C = within_tpl.copy()
tpl_C = tpl_C - tpl_B - tpl_A
tpl_C[9:, 9:] = 0

tpl_D = within_tpl.copy()
tpl_D = tpl_D - tpl_C - tpl_B - tpl_A

if PLOT:
    plot_mtx(tpl_A, stim_list, "Triplet rank-1", 
             fd=out_dir, fn="Triplet rank-1.png",
             cmin=1, cmax=0, cmap='gray_r')
    plot_mtx(tpl_B, stim_list, "Triplet rank-2", 
             fd=out_dir, fn="Triplet rank-2.png",
             cmin=1, cmax=0, cmap='gray_r')
    plot_mtx(tpl_C, stim_list, "Triplet rank-3", 
             fd=out_dir, fn="Triplet rank-3.png",
             cmin=1, cmax=0, cmap='gray_r')
    plot_mtx(tpl_D, stim_list, "Triplet rank-4", 
             fd=out_dir, fn="Triplet rank-4.png",
             cmin=1, cmax=0, cmap='gray_r')

## Each order: 
matrices = [np.zeros([n_C, n_C]), np.zeros([n_C, n_C]), np.zeros([n_C, n_C])]
for ord in range(3):
    for x in np.arange(ord, 12, 3, dtype=int):
        matrices[ord][np.arange(ord, 12, 3, dtype=int), x] = 1
    matrices[ord][np.arange(ord, 12, 3, dtype=int), np.arange(ord, 12, 3, dtype=int)] = 0

Fst, Snd, Trd = matrices

if PLOT:
    plot_mtx(Fst, stim_list, "First", 
             fd=out_dir, fn="First.png",
             cmin=1, cmax=0, cmap='gray_r')
    plot_mtx(Snd, stim_list, "Second", 
             fd=out_dir, fn="Second.png",
             cmin=1, cmax=0, cmap='gray_r')
    plot_mtx(Trd, stim_list, "Third", 
             fd=out_dir, fn="Third.png",
             cmin=1, cmax=0, cmap='gray_r')