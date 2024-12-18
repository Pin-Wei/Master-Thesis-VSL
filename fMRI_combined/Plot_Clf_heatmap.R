# source("Plot_Clf_heatmap.R")
rm(list = ls())
setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))

# install.packages("")
library(reshape2)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plyr)
library(broom)
library(stringr) 
source("plotting_funcs.R")
source("roi_2_region.R") 

re_plot <- T
do_aov <- T
mask_no_sig <- F
  
my_colors <- c("blue", "cyan", "green", "yellow", "orange", "red")
# my_colors <- c("green", "yellow", "orange", "darkred")
# no_sig_colors <- c("#003399", "#3399FF", "cyan", "green")

ap_ver <- c(
  "runs_v5", "runs_v4.3", "runs_v4.2", "runs_v4", "runs_v+", "runs_v2", "runs"
)[1]
estm_ver <- c(
  "*", "LSS.Betas", "Betas", "Betas_REML", "Tstats", "Tstats_REML"
)[2]
# targ_ver <- c(
#   "shapes", "Tpls"
# )[2]
clf_ver <- c(
  "*", "LinearCSVMC", "RbfCSVMC", "10NN", "SMLR"
)[1]
runs_groupby <- c(
  "single_run", "run_windows", "exposure_runs", "all_10_runs"
)[2]
file_name <- c(
  "Allmasks_*-fold.csv", "mask-*_*-fold.csv"
)[1]

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
  "Hipp.Sub", "Hipp.CA1", "Hipp.CA2+3", "Hipp.DG.CA4",
  "Caudate", "Putamen", 
  "Insula", "Post_Cingulate", "Isth_Cingulate"
)

# ==============================================================================
for ( targ_ver in c("shapes", "Tpls") ) {
  out_dir <- file.path(out_top, targ_ver, runs_groupby, "heatmap")
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
        gsub("Allmasks_", "",                   # remove uninformative components     
        gsub(paste0(targ_ver, "_model-"), "",   # already state by output folder   
        gsub(paste0(runs_groupby, "/"), "",     # already state by output folder
        gsub(paste0(clf_top, "/"), "",          # remove top address
      file_path)))))))

    out_path <- file.path(out_dir, fig_name) 
    if ( ! file.exists(out_path) || re_plot ) { # skip if file already exist, EXCEPT RE-PLOT
      
      in_data <- read.csv(file_path, header=T)
      # COLUMNS: "SID", "mask_size", "Run_type", "ACC", "ROI"
      
      in_data <- subset(in_data, in_data$ACC >= 0)
      
      Nclass <- ifelse(grepl("shapes", file_path), 12, 
                       ifelse(grepl("Tpl", file_path), 4, 
                              as.integer(readline("How many class? "))))
      run_types <- unique(in_data$Run_type)
      
      ## Plot: -----------------------------------------------------------------
      tryCatch({ 
        
        DF_summ <- my_1sampleT(in_data, "ROI", "Run_type", "ACC", 1/Nclass, "greater")
        DF_summ <- subset(DF_summ, DF_summ$ROI %in% roi_list)
        DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
        # DF_summ$Region <- factor(sapply(DF_summ$ROI, roi_2_region), levels = region_list)
        
        if ( do_aov ) {
          DF_anova <- in_data %>%
            group_by(ROI) %>%
            do(tidy(aov(ACC ~ Run_type, data = .), na.rm = TRUE)) %>% 
            subset(term == "Run_type") %>% 
            mutate(
              aov_stat_sign = ifelse(p.value < .05, "*", "n.s."),
              aov_stat = paste0(
                "F = ", round(statistic, 2), " (p = ", round(p.value, 3), ")")
            ) %>% select(all_of(c("ROI", "aov_stat", "aov_stat_sign"))) 
          
          DF_summ <- join(DF_summ, DF_anova, type = "left", by = "ROI")
        }
        
        P <- ggplot(DF_summ, aes(x = ROI, 
                                 y = Run_type, 
                                 fill = mean)) + 
          geom_tile()
          
        if ( mask_no_sig == T ) {
          P <- P + 
            geom_tile(data = subset(DF_summ, DF_summ$p_Nsig == "n.s."), 
                      fill = "white") + 
            scale_fill_gradientn(colors = my_colors, 
                                 limits = c(1/Nclass, .7))
            
        } else {
          P <- P + 
            # scale_fill_gradient(low = "yellow", high = "red") +
            scale_fill_gradientn(colors = my_colors)
        }
        
        P <- P + 
          labs(x = NULL, # x = "ROIs"
               y = NULL, # y = "Runs"
               fill = "mean ACC",
               title = paste(gsub("_", "  ", gsub(".jpg", "", fig_name)), "--", targ_ver)) +
          
          theme(text = element_text(size = 14), 
                axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1))
        
        if ( do_aov ) {
          P <- P + 
            geom_text(data = subset(DF_summ, DF_summ$Run_type == run_types[length(run_types)]),
                      aes(label = aov_stat, 
                          x = ROI, 
                          color = aov_stat_sign), 
                      size = 3, angle = 90, hjust = "inward", 
                      check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE) +
            
            scale_color_manual(values = c("red", "black"), 
                               limits = c("*", "n.s."))
        }
        
        ggsave(file = out_path, width=10, height=5)
        print(paste("Done!", targ_ver, fig_name, "is saved."))
        
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