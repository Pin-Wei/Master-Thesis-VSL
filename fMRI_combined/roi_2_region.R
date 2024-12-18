roi_2_region <- function(roi) {
  
  if ( roi %in% c('Pre_Central', 'Para_Central') ) {
    region <- "Frontal"
  } else if ( roi %in% c('Post_Central', 'Supra_Marginal', 'Sup_Pari', 'Inf_Pari', 'Pre_Cuneus') ) {
    region <- "Parietal"
  } else if ( roi %in% c('Lingual', 'Peri_Calcarine', 'Cuneus') ) {
    region <- "Occipital"
  } else if ( roi %in% c('V1', 'V2', 'V3', 'High.Vis', 'High-Vis') ) { # Lat_Occi
    region <- "Visual"
  } else if ( roi %in% c('Sup_Temp', 'Mid_Temp', 'Inf_Temp', 'Trans_Temp', 'Fusiform') ) {
    region <- "Temporal"
  } else if ( roi %in% c('PHC', 'PRC', 'ERC', 'MTL') ) {
    region <- "MTL"
  } else if ( roi %in% c(
    'Hipp.Sub', 'Hipp.CA1', 'Hipp.CA2.3', 'Hipp.DG.CA4', 
    "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", 'Hippocampus') ) {
    # 'DG', 'CA3', 'CA1', 'Sub', 'HPC'
    region <- "Hippocampal"
  } else if ( roi %in% c('Caudate', 'Putamen') ) {
    region <- "Striatal"
  } else { # 'Insula', 'Post_Cingulate', 'Isth_Cingulate', 'CBM'
    region <- "Others"
  } 
  return(region)
}

region_list <- c(
  "Frontal", "Parietal", "Occipital", "Visual", "Temporal", 
  "MTL", "Hippocampal", "Striatal", "Others"
)

roi_list <- c(
  "Pre_Central", "Para_Central", 
  "Post_Central", "Supra_Marginal", "Sup_Pari", "Inf_Pari", "Pre_Cuneus", 
  "Lingual", "Peri_Calcarine", "Cuneus", 
  "V1", "V2", "V3", "High.Vis", # "Lat_Occi", 
  "Sup_Temp", "Mid_Temp", "Inf_Temp", "Trans_Temp", "Fusiform",
  "PHC", "PRC", "ERC", "MTL", 
  "Hipp.Sub", "Hipp.CA1", "Hipp.CA2.3", "Hipp.DG.CA4", 
  "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hippocampus", 
  # "DG", "CA3", "CA1", "Sub", "HPC", 
  "Caudate", "Putamen", 
  "Insula", "Post_Cingulate", "Isth_Cingulate", "CBM"
)