#!/usr/bin/env python
# coding: utf-8

from MVPA_functions import get_the_mask

space = 'T1w'
roi_list_uni = [
	"Pre_Central", "Para_Central", "Post_Central", "Post_Cingulate", 
	"Supra_Marginal", "Sup_Pari", "Inf_Pari", "Pre_Cuneus", "Isth_Cingulate", 
	"PHC", "PRC", "ERC", "Hippocampus", 
    "Hipp-DG+CA4", "Hipp-CA2+3", "Hipp-CA1", "Hipp-Sub", 
    "Caudate", "Putamen", "Insula", "Trans_Temp", "Sup_Temp", "Mid_Temp", 
	"Inf_Temp", "Fusiform", "Lat_Occi", "LOC-V12",  
    "Cuneus", "Lingual", "V1+2", "Peri_Calcarine"
]
roi_list_LR = [
    'lh-Hipp-DG+CA4', 'rh-Hipp-DG+CA4', 
    'lh-Hipp-CA2+3',  'rh-Hipp-CA2+3',     
    'lh-Hipp-CA1',    'rh-Hipp-CA1',     
    'lh-Hipp-Sub',    'rh-Hipp-Sub', 
    'lh-Hippocampus', 'rh-Hippocampus', 
    'lh-PHC',         'rh-PHC', 
    'lh-PRC',         'rh-PRC', 
    'lh-ERC',         'rh-ERC'
]
roi_list = roi_list_uni + roi_list_LR
mask_types = [ 'a' for x in roi_list ]
m_name_list = [ get_the_mask(space, m_type, roi)[0] for m_type, roi in zip(mask_types, roi_list) ]
