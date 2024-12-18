# source("Plot_eoSimi_heatmap.R")

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
library(stringr) 
library(rstatix)
library(ggplot2)
library(ggpubr)
source("plotting_funcs.R")

# library(reshape2)
# library(plyr)
# library(broom)

################################### setup ######################################

dtype <- as.integer(readline("PPI or ordinary stats? [1 or 2] "))

if ( dtype == 1 ) {
  roi_select_idx <- 10
  tt.side <- c("1pos", "2side")[2]
  alt <- c("greater", "two.sided")[2]
} else {
  roi_select_idx <- 11
  tt.side <- c("1pos", "2side")[1]
  alt <- c("greater", "two.sided")[1]
}

roi_select <- list(
  # 1:
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp"),
  # 2: 
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "Hippocampus"),
  # 3:
  c("PHC", "PRC", "ERC"), 
  # 4:
  c("PHC", "PRC", "ERC", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hipp-Sub"), 
  # 5: 
  c("lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC", 
    "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-Sub", "rh-Hipp-Sub"),
  # 6:
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "PHC", "PRC", "ERC"), 
  # 7:
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "PHC", "PRC", "ERC", "Hippocampus"), 
  # 8:
  c("Putamen", "Caudate"), 
  # 9:
  c("Putamen", "Caudate", "Hippocampus"), 
  # 10:
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "PHC", "PRC", "ERC", "Putamen", "Caudate"), 
  # 11:
  c("V1+2", "LOC-V12", "Fusiform", "Inf_Temp", "PHC", "PRC", "ERC", "Hippocampus", "Caudate", "Putamen")
)[roi_select_idx][[1]]

# rois_name <- paste(roi_select, collapse = ", ")
# rois_name <- paste0(length(roi_select), " ROIs")
rois_name <- c(
  "Visual", 
  "Vis_Hipp", 
  "MTL", 
  "MTL_Hipp.sub", 
  "L.R_MTL_Hipp.sub", 
  "Vis_MTL", 
  "Vis_MTL_Hipp", 
  "Striatum", 
  "Stria_Hipp", 
  "Vis_MTL_Stria", 
  "Vis_MTL_Hipp_Stria"
)[roi_select_idx]

learner.thresh <- c(21.33, 27)[2]

## Data version (asking input): ================================================

if ( dtype == 1 ) {
  seed_roi <- "Hippocampus"
  ap_ver <- file.path("runs_MNI_3ord_v6.PPI_REML", seed_roi)
  
  gfunc <- c("", "_gfunc")[
    as.integer(readline("What kind of ROIS? ([1]: anat [2]: gfunc) "))]
  
} else {
  ap_ver <- "runs_MNI_3ord_v6_REML"
  # ap_ver <- paste0("runs_MNI_3ord_v", 
  #   readline("which afni_proc version? (runs_MNI_3ord_v?) "), 
  #   c("", "_REML")[2])

  gfunc <- c("", "_gfunc")[
    as.integer(readline("What kind of ROIS? ([1]: anat [2]: gfunc) "))]
}

learner_only <- F
# learner_only <- c(T, F)[
#   as.integer(readline("Learner only? ([1]: Yes [2]: No) "))]

## Output folder: ==============================================================

folder_name <- ifelse(gfunc == "_gfunc", 
                      paste0("[gfunc] ", rois_name), rois_name)

folder_name <- ifelse(learner_only, 
                      paste0(folder_name, " (learner only)"), folder_name)

out_dir <- file.path(grp_out, "ROI_analysis", ap_ver, "Heatmap", folder_name)
if ( ! file.exists(out_dir) ) { dir.create(out_dir, recursive=TRUE) }

## Load & modify data: =========================================================

data_folder <- file.path(grp_out, paste0("ROIstats", gfunc), ap_ver)
load(file.path(data_folder, "maskave.all_ROI_Run_Cond.Rdata")) # all_DF

behav <- read.table(file.path(behav_folder, "familiarity_test_score.txt"), 
                    header = T, row.names = NULL)
colnames(behav) <- c("Subj", "ACC", "Score", "Vio")
behav$Subj  <- as.numeric(behav$Subj)
behav$Group <- ifelse(behav$Score > learner.thresh, "L", "N")

all_DF$Subj <- as.numeric(gsub("sub-", "", all_DF$Subj))
all_DF      <- dplyr::left_join(all_DF, behav, by="Subj")
all_DF$Subj <- as.factor(all_DF$Subj)
all_DF$Run  <- as.integer(all_DF$Run) - 1
# all_DF$Run  <- sprintf("run-%02d", as.integer(all_DF$Run))

runs_list   <- unique(all_DF$Run)
cond_list <- c("Fst", "Snd", "Trd")
# cond_list <- unique(all_DF$Cond)
roi_list <- rev(roi_select)

sub_DF           <- subset(all_DF, ROI %in% roi_list & Cond %in% cond_list)
sub_DF$ROI       <- factor(sub_DF$ROI, levels = roi_list)

if ( learner_only ) { sub_DF <- subset(sub_DF, Group == "L") }

## Setup figure parameters: ====================================================

if ( tt.side == "2side" ) {
  color_list <- c("blue","#0099ff","cyan","white","yellow","#ff9900","red")
  color_breaks <- c(-1, -.99, -.95, -.9, .9, .95, .99, 1)
  c_break_names <- c("-.001","-.05","-.01","0",".01",".05",".001")
  c_label_names <- c("-.001","-.05","-.01","n.s.",".01",".05",".001")

  } else if ( tt.side == "1pos" ) {
  color_list <- c("white","yellow","#ff9900","red")
  color_breaks <- c(-.9, .9, .95, .99, 1)
  c_break_names <- c("0",".01",".05",".001")
  c_label_names <- c("n.s.",".01",".05",".001")
}

print("Setting the size of figure for pairwise comparisons: ")
fh <- as.integer(readline("\t+ height: "))
fh <- ifelse(is.null(fh), 4, fh) # default
fw <- as.integer(readline("\t+ width: "))
fw <- ifelse(is.null(fw), 8, fw) # default

##################################### MAIN #####################################

for ( cond in cond_list ) {
  DF_sub <- subset(sub_DF, Cond == cond) 
  
  DF_summ <- my_1sampleT(DF_sub, "ROI", "Run", "Y", 0, alt)
  DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
  DF_summ$Run <- as.character(DF_summ$Run)
  
  DF_summ$flip_p <- ifelse(DF_summ$statistic < 0,
                           DF_summ$p.value - 1, # negative
                           1 - DF_summ$p.value) # positive
  
  DF_summ$flip_p_cut <- cut(DF_summ$flip_p,
                            labels = c_break_names,
                            breaks = color_breaks)
  
  P <- ggplot(DF_summ, aes(x = Run, 
                           y = ROI, 
                           fill = flip_p_cut)) + 
    
    geom_tile(color = "white", lwd = 1, linetype = 1) + 
    
    # coord_fixed() + 
    coord_fixed(ratio = 0.6) + 
    
    scale_fill_manual(name = "p.value",
                      values = color_list, 
                      limits = c_break_names, 
                      labels = c_label_names) + 

    geom_text(data = DF_summ,
              aes(label = round(mean, 2), x = Run, y = ROI), 
              size = 6, color = "white", 
              na.rm = TRUE, show.legend = FALSE) + 

    labs(x = NULL, y = NULL, fill = "Intensity", title = cond) +
    
    theme(text = element_text(size = 24), 
          # axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1), 
          panel.background = element_rect(fill = NA))
  
  ggsave(file = file.path(out_dir, paste0(cond, ".jpg")), 
         width = fw, height = fh)
  
  print(paste("Done!", cond, "is saved."))
}
