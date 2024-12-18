# source(".R")

rm(list = ls())
top_dir <- file.path("C:", "Users", "PinWei", "my_VSL_fMRI")
setwd(top_dir)

library(reshape2)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plyr)
library(broom)
library(stringr) 
source("plotting_funcs.R")

## NOTE: *_cormat_*.csv is output from python file "Corr_with_Behav"

################################### setup ######################################

mask_no_sig <- c(T, F)[
  as.integer(readline("Not to color non-significant values? [1] True [2] False "))
]

learner_only <- c(T, F)[
  as.integer(readline("Learner only? [1] True [2] False "))
]

number_of_rois <- 2

roi_list <- list(
  
  c("Pre_Central",                                                                          # Frontal 
    "Inf_Pari", "Para_Central", "Post_Central", "Pre_Cuneus", "Sup_Pari", "Supra_Marginal", # Parietal
    "Isth_Cingulate", "Insula", "Post_Cingulate",                                           # Limbic
    "Caudate", "Putamen",                                                                   # Striatum
    "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hippocampus",                     # Hippocampus
    "PHC", "PRC", "ERC", "MTL",                                                             # MTL
    "Inf_Temp", "Mid_Temp", "Sup_Temp", "Trans_Temp",                                       # Temporal
    "Peri_Calcarine", "Fusiform", "Cuneus", "High-Vis", "V3", "V2", "V1", "Lingual",        # Occipital   
    "CBM"), 
  
  c("lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC", 
    "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", 
    "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-Sub", "rh-Hipp-Sub", 
    "lh-Caudate", "rh-Caudate", "lh-Putamen", "rh-Putamen"),
  
  c("V1", "V2", "V3", "High-Vis", "Fusiform", "Inf_Temp", 
    "PHC", "PRC", "ERC", "Hippocampus", 
    "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", 
    "Caudate", "Putamen"),   
  
  c("V1", "V2", "V3", "High-Vis", "Fusiform", "Inf_Temp", 
    "PHC", "PRC", "ERC", "Hippocampus"), 

  c("High-Vis", "Hippocampus")
  
)[[number_of_rois]]

my_color_range <- c(-1, 1)
# my_colors <- c("blue", "cyan", "green", "yellow", "orange", "red")

fw <- c(20, 12, 10, 8, 6)[number_of_rois]
fh <- 6

# ==============================================================================

which_dataset <- as.integer(readline("For which dataset? \
  [1] Behav x PyMVPA: Odd-Even Similarity                \
  [2] Behav x Univariate Activity                        \
  [3] The corr of above two (not behav)"))

if ( which_dataset == 1 ) { # Behav x PyMVPA: Odd-Even Similarity --------------
  
  ver <- as.integer(readline("which version of MVPA data? (runs_v?) "))
  ap_MVPA <- paste0("runs_v", ver)
  
  ask_me <- as.integer(readline("[1] Individual shapes or [2] Triplets? "))
  stim_type <- c("tpl_sorted", "triplets")[ask_me]
  cond_list <- list(
    c("Fst", "Snd", "Trd", "All"), 
    c("Tpl")
  )[[ask_me]]
  
  ask_me2 <- as.integer(readline("[1] Each single or [2] Binded runs? "))
  runs_type <- c("each", "binded")[ask_me2]
  run_list <- list(
    sprintf("run-%02g", seq(2, 9, 1)),
    sprintf("R%s%s", seq(2, 8, 2), seq(3, 9, 2))
  )[[ask_me2]]
  
  data_top <- file.path(top_dir, "PyMVPA", "odd_even_trials_similarity", ap_MVPA, 
                        "Corr_with_behav", paste0(stim_type, "_", runs_type))  

} else if ( which_dataset == 2 ) { # Behav x Univariate Activity ---------------
    
  ver <- as.integer(readline("which version of Univariate data? (runs_MNI_3ord_v?) "))
  reml <- c("", "_REML")[2]
  ap_ver <- paste0("runs_MNI_3ord_v", ver, reml)
  
  anat_or_gfunc <- as.integer(readline("what ROI? [1] anat or [2] gfunc "))

  data_top <- file.path(top_dir, "ROI_analysis", ap_ver, 
    ifelse(anat_or_gfunc == 2, "Corr_with_behav (gfunc)", "Corr_with_behav"))
  
  cond_list <- c("Fst", "Snd", "Trd")
  # if ( ver == 6 ) { cond_list <- c("Fst", "Snd", "Trd", "any.stim", "1.and.2", "2.and.3", "1.vs.2", "3.vs.2", "1.vs.3", "1.2.vs.3", "2.3.vs.1", "1.vs.2.3", "3.vs.1.2")
  # } else if ( ver == 5 ) { cond_list <- c("Fst", "Snd", "Trd", "1+2+3", "1+2", "2+3", "1-2", "3-2", "1-3") }
  
  run_list <- sprintf("run-%02g", seq(2, 9, 1))

} else { # The corr of above two (not with behav) ------------------------------

  data_top <- file.path(top_dir, "Intensity_x_Stability") 
    # "Activation_corr_OESim"
    
  cond_list <- c("Fst", "Snd", "Trd", "All")
  
  run_list <- sprintf("run-%02g", seq(2, 9, 1))  
  
} # finally --------------------------------------------------------------------

data_dir <- file.path(data_top, paste0(length(roi_list), "_ROIs"))
data_dir <- ifelse(learner_only, paste0(data_dir, " (learner_only)"), data_dir)

out_dir <- file.path(data_dir, "plot_with_R (Heatmap)")
out_dir <- ifelse(mask_no_sig, out_dir, file.path(out_dir, "include_no_sig"))

if ( ! file.exists(out_dir) ) { dir.create(out_dir, recursive=TRUE) }

##################################### MAIN #####################################

for ( cond in cond_list ) {
  
  coef_data <- read.table(file.path(data_dir, paste0("R_cormat_", cond, ".csv")), 
                          header = T, sep = ",")
  colnames(coef_data) <- c("ROI", run_list)
  coef_data <- reshape2::melt(coef_data, 
                              id = "ROI", 
                              variable.name = "Run",
                              value.name = "coef")
  
  stat_data <- read.table(file.path(data_dir, paste0("pVal_cormat_", cond, ".csv")), 
                          header = T, sep = ",")
  colnames(stat_data) <- c("ROI", run_list)
  stat_data <- reshape2::melt(stat_data, 
                              id = "ROI", 
                              variable.name = "Run",
                              value.name = "p_val")
  
  DF_summ <- merge(coef_data, stat_data)
  
  DF_summ <- subset(DF_summ, DF_summ$ROI %in% roi_list)
  DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
  
  # DF_summ$sign_p <- unlist(mapply("*", sign(DF_summ$coef), DF_summ$p_val, SIMPLIFY = FALSE))
  
  P <- ggplot(DF_summ, aes(x = ROI, 
                           y = Run, 
                           fill = coef)) + 
    
    geom_tile(color = "white", lwd = 1, linetype = 1) + 
    
    coord_fixed()
  
  if ( mask_no_sig == T ) {
    P <- P + 
      geom_tile(data = subset(DF_summ, DF_summ$p_val > .05), fill = "white") 
  } 
  
  P <- P + 
    # scale_fill_gradientn(colors = my_colors, 
    #                      limits = my_color_range) + 
    
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                         midpoint = 0, 
                         limits = my_color_range) + 
    
    geom_text(data = DF_summ, 
              aes(x = ROI, 
                  y = Run, 
                  label = round(coef, 2)), 
              size = 4, 
              na.rm = TRUE, 
              show.legend = FALSE) + 
    
    labs(x = NULL, 
         y = NULL, 
         fill = "R value", 
         title = cond) +
    
    theme(text = element_text(size = 20), 
          axis.text.x = element_text(angle = 45, # 90, 
                                     vjust = 1, # .5, 
                                     hjust = 1), 
          panel.background = element_rect(fill = NA))
  
  ggsave(file = file.path(out_dir, paste0(cond, ".jpg")), 
         width = fw, height = fh)
  
  print(paste("Done!", cond, "is saved."))
}
