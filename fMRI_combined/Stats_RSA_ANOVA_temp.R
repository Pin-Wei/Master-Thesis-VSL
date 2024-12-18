# source(".R") 

# setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))
setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))

rm(list = ls())
fid <- c("local", "remote")[1]
if ( fid == "local" ) {
  grp_out <- "."
  behav_folder <- "Familiarity_test_performance"  
  
} else { # remote
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
  grp_out <- file.path(top_dir, "derivatives")
  behav_folder <- file.path(top_dir, "code") 
}

library(dplyr)   # a grammar of data manipulation
library(tidyr)   # describes a standard way of storing data
library(rstatix)
library(ggplot2)
library(ggpubr)

################################### setup ######################################

ap_folder <- "ap-runs_v7.5"
stim_type <- "tpl_sorted"

meas <- c("correlation", "euclidean", "hamming")[as.integer(readline(
  "What measure? [1] correlation [2] euclidean [3] hamming "))]

# learner_only <- c(T, F)[2]
learner_only <- c(T, F)[
  as.integer(readline("Learner only? ([1]: Yes [2]: No) "))]
learner.thresh <- c(21.33, 27)[2]

rois_is_paired  <- c(F, F, F, T, T)
roi_select_list <- list(
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "Hippocampus"),              # 1
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", 
    "PHC", "PRC", "ERC", "Hippocampus"),                                    # 2
  c("Hipp-DG+CA4","Hipp-CA2+3", "Hipp-CA1", "Hipp-Sub"),                    # 3
  c("lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC", 
    "lh-Hippocampus", "rh-Hippocampus"),                                    # 4
  c("lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", 
    "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-Sub", "rh-Hipp-Sub")             # 5
)
rois_name_list <- c("Vis.Hipp", "Vis.MTL.Hipp", "Hipp_sub", "MTL.Hipp_LR", "Hipp_sub_LR")
print(rois_name_list)

# roi_select_idx <- as.integer(readline("Which ROIs set? (index) "))
roi_select_idx <- 1
roi_select     <- roi_select_list[roi_select_idx][[1]]
rois_name      <- rois_name_list[roi_select_idx]
rois_paired    <- rois_is_paired[roi_select_idx]

pwc.adj.method <- c("holm", "bonferroni")[1]

## Load data =============================================

data_dir <- file.path(grp_out, "PyMVPA")
data_fn <- "long_DF.csv"
all_DF <- read.csv(file.path(data_dir, data_fn), header=T)
sub_DF <- subset(all_DF, ROI %in% roi_select)

AOV.3w<- sub_DF %>% 
  rstatix::anova_test(dv = Avg_SMC, wid = index, 
                      within = c(ROI, Targ), between = Group, 
                      data=.) %>% 
  get_anova_table(.)

write.csv(data.frame(AOV.3w), 
          file = file.path(data_dir, "ANOVA.3W.csv"))
