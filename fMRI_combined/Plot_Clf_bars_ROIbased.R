# source("Plot_Clf_bars_ROIbased.R")
rm(list = ls())
setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))

library(reshape2)
library(dplyr)
library(stringr) 
library(ggplot2)
source("plotting_funcs.R")
source("roi_2_region.R") # region_list = c("Frontal", "Parietal", "Occipital", "Visual", "Temporal", "MTL", "Hippocampal", "Striatal", "Others"))

re_plot <- T

ap_ver <- c(
  "runs_v5", "runs_v4.3", "runs_v4.2", "runs_v4", "runs_v+", "runs_v2", "runs"
)[1]
estm_ver <- c(
  "*", "LSS.Betas", "Betas", "Betas_REML", "Tstats", "Tstats_REML"
)[2]
# targ_ver <- c(
#   "shapes", "Tpls"
# )[1]
clf_ver <- c(
  "*", "LinearCSVMC", "RbfCSVMC", "10NN", "SMLR"
)[1]
runs_groupby <- c(
  "exposure_runs", "all_10_runs"
)[1]

file_name <- "ROIs_*.csv"
top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus")
clf_top <- file.path(top_dir, "Combined_group", "derivatives", "PyMVPA", "classification_out")
out_top <- gsub("classification_out", "classification_plots", clf_top)

roi_list <- c(
  "Pre_Central", "Para_Central", 
  "Post_Central", "Supra_Marginal", "Sup_Pari", "Inf_Pari", "Pre_Cuneus", 
  "Lingual", "Peri_Calcarine", "Cuneus", 
  "V1", "V2", "V3", "High-Vis", "High.Vis",
  "Sup_Temp", "Mid_Temp", "Inf_Temp", "Trans_Temp", "Fusiform",
  "PHC", "PRC", "ERC", 
  "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4",
  "Hipp.Sub", "Hipp.CA1", "Hipp.CA2.3", "Hipp.DG.CA4", 
  "Caudate", "Putamen", 
  "Insula", "Post_Cingulate", "Isth_Cingulate"
)

# ==============================================================================
for ( targ_ver in c("shapes", "Tpls") ) {
  out_dir <- file.path(out_top, targ_ver, runs_groupby)
  if ( ! file.exists(out_dir) ) { 
    dir.create(out_dir, recursive=TRUE)
  }
  
  file_path_list <- Sys.glob(
    file.path(clf_top, paste0("ap-", ap_ver), estm_ver, 
              paste0(targ_ver, "_model-", clf_ver), runs_groupby, file_name))
  
  for ( file_path in file_path_list ) {
    fig_name <- gsub(".csv", ".jpg", 
        gsub("/", "_",                          # connect remaining addresses with underscore 
        gsub("_", ".",                          # substitute underscores to dots 
        gsub("ROIs_", "",                       # remove uninformative components 
        gsub(paste0(targ_ver, "_model-"), "",   # already state by output folder    
        gsub(paste0(runs_groupby, "/"), "",     # already state by output folder
        gsub(paste0(clf_top, "/"), "",          # remove top address
      file_path)))))))
    
    out_path <- file.path(out_dir, fig_name) 
    if ( ! file.exists(out_path) || re_plot ) { # skip if file already exist, EXCEPT RE-PLOT
      
      in_data <- read.csv(file_path, header=T)
      in_data <- melt(in_data, 
                      id = colnames(in_data)[1], 
                      variable.name = "ROI", 
                      value.name = "clf_ACC")
      
      Nclass <- ifelse(grepl("shapes", file_path), 12, 
                       ifelse(grepl("Tpl", file_path), 4, 
                              as.integer(readline("How many class? "))))
      
      ## Plot: -----------------------------------------------------------------
      tryCatch({
        
        in_data$X <- 0
        DF_summ <- my_1sampleT(in_data, "ROI", "X", "clf_ACC", 1/Nclass, "greater")
        DF_summ <- subset(DF_summ, DF_summ$ROI %in% roi_list)
        DF_summ$Region <- factor(sapply(DF_summ$ROI, roi_2_region), levels = region_list)
        
        P <- ggplot(DF_summ, aes(x = ROI, 
                                 y = mean, 
                                 fill = Region, 
                                 color = Region)) +
          
          geom_bar(stat = "identity", 
                   position = "dodge2", 
                   width = .6,
                   alpha =.5) + 
          # show.legend = FALSE) + 
          
          geom_linerange(aes(ymin = mean - sd, 
                             ymax = mean + sd), 
                         position = position_dodge(.9)) +
          
          geom_hline(aes(yintercept = 1/Nclass), 
                     color = "red", linetype = 2, linewidth =.5, alpha =.7) +
          
          coord_cartesian(ylim = c(0, 1)) + 
          # scale_fill_viridis(discrete = TRUE) + 
          # scale_color_viridis(discrete = TRUE) + 
          
          labs(x = NULL, y = "ACC", 
               title = gsub("_", "  ", gsub(".jpg", "", fig_name))) +
          
          theme(text = element_text(size = 14), 
                axis.text.y = element_text(size = 12),
                axis.text.x = element_text(size = 14, angle = 90, vjust = .5, hjust = 1))
        
        my_addSig2Plt(P, P_PRINT=F, P_SIG=T, P_NSIG=F)
        ggsave(file = out_path, width=10, height=5)
        print(paste("Done!", fig_name, "is saved."))
        
        ## ---------------------------------------------------------------------
        
      }, error = function(e) {
        message(paste(":'( -- Failed --", fig_name))
        print(e)
      })
      
    } else {
      print(paste("SKIP:", fig_name, "already exist!"))
    }
  }
}