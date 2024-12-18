# source("Plot_eoSimi_heatmap.R")

rm(list = ls())
fid <- c('local', 'remote')[1]

if ( fid == 'local' ) {
  setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))
  grp_out <- '.'
  behav_folder <- "Familiarity_test_performance"
  
} else {
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
  setwd(file.path(top_dir, "code"))
  grp_out <- file.path(top_dir, "derivatives")
  # behav_folder <- file.path("/media", "data2", "pinwei", "SL_hippocampus", )
}

library(reshape2)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plyr)
library(broom)
library(stringr) 
source("plotting_funcs.R")

################################### setup ######################################

ver <- 6                    ###
reml <- c("", "_REML")[2]
ap_ver <- paste0("runs_MNI_3ord_v", ver, reml)

learner_only  <- c(T, F)[2] ###

gfunc <- c("", "_gfunc")[2] ###

number_of_rois <- 3         ### see below

thres <- 0
alt <- c("greater", "two.sided")[2]

# do_aov <- c(T, F)[2]

## Load data: ------------------------------------------------------------------

data_folder <- file.path(grp_out, paste0("ROIstats", gfunc), ap_ver)
load(file.path(data_folder, "maskave.all_ROI_Run_Cond.Rdata")) # all_DF

runs_list <- unique(all_DF$Run)

cond_list <- unique(all_DF$Cond)

roi_list <- list(
  
  unique(all_DF$ROI)[ unique(all_DF$ROI) != "CBM_ex" ],
  
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

all_DF <- subset(all_DF, all_DF$ROI %in% roi_list)
all_DF$ROI <- factor(all_DF$ROI, levels = roi_list)

## Setup output folder: --------------------------------------------------------

out_dir <- file.path(grp_out, "ROI_analysis", ap_ver, 
                     ifelse(gfunc == "_gfunc", "Heatmap (gfunc)", "Heatmap"), 
                     paste0(length(roi_list), "_ROIs"))

out_dir <- ifelse(learner_only, paste0(out_dir, " (learner only)"), out_dir)

if ( ! file.exists(out_dir) ) { dir.create(out_dir, recursive=TRUE) } 

## Setup figure parameters: ----------------------------------------------------

color_list <- c("blue","#0099ff","cyan","white","yellow","#ff9900","red")
color_breaks <- c(-1, -.99, -.95, -.9, .9, .95, .99, 1)
c_break_names <- c("-.001","-.05","-.01","0",".01",".05",".001")
c_label_names <- c("-.001","-.05","-.01","n.s.",".01",".05",".001")

fw <- c(30, 20, 12, 10, 8, 6)[number_of_rois]
fh <- 6

##################################### MAIN #####################################

if ( learner_only ) {
  all_DF <- subset(all_DF, Group == "L")
}

for ( cond in cond_list ) {
  DF_sub <- subset(all_DF, Cond == cond) 
  
  DF_summ <- my_1sampleT(DF_sub, "ROI", "Run", "Y", thres, alt)
  
  DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
  
  DF_summ$Run <- sprintf("run-%02d", as.integer(DF_summ$Run))
  
  DF_summ$flip_p <- ifelse(DF_summ$statistic < 0,
                           DF_summ$p.value - 1, # negative
                           1 - DF_summ$p.value) # positive
  
  DF_summ$flip_p_cut <- cut(DF_summ$flip_p,
                            labels = c_break_names,
                            breaks = color_breaks)
  
  # if ( do_aov ) { # ------------------------------------------------------------
  #   
  #   DF_anova <- DF_sub %>%
  #     group_by(ROI) %>%
  #     do(tidy(aov(Similarity ~ Run, data = .), na.rm = TRUE)) %>% 
  #     subset(term == "Run") %>% 
  #     mutate(
  #       aov_stat_sign = ifelse(p.value < .05, "*", "n.s."),
  #       aov_stat = paste0(
  #         "F = ", round(statistic, 2), " (p = ", round(p.value, 3), ")")
  #     ) %>% select(all_of(c("ROI", "aov_stat", "aov_stat_sign"))) 
  #   
  #   DF_summ <- join(DF_summ, DF_anova, type = "left", by = "ROI")
  #   
  # } # --------------------------------------------------------------------------
  
  P <- ggplot(DF_summ, aes(x = ROI, 
                           y = Run, 
                           fill = flip_p_cut)) + 
    
    geom_tile(color = "white", lwd = 1, linetype = 1) + 
    
    coord_fixed() +
    
    scale_fill_manual(name = "p.value",
                      values = color_list, 
                      limits = c_break_names, 
                      labels = c_label_names) 
  
  # if ( do_aov ) { # ------------------------------------------------------------
  #   
  #   P <- P +   
  #     geom_text(data = subset(DF_summ, 
  #                             Run == runs_list[length(runs_list)]), # last one
  #               aes(label = aov_stat, x = ROI, color = aov_stat_sign), 
  #               angle = 90,
  #               size = 4, hjust = "inward", 
  #               check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE) +
  #     
  #     scale_color_manual(values = c("red", "black"), 
  #                        limits = c("*", "n.s."))
  #   
  # } else { # -------------------------------------------------------------------
    
    P <- P +   
      geom_text(data = DF_summ,
                aes(label = round(mean, 2), 
                    x = ROI, y = Run), 
                size = 4, na.rm = TRUE, show.legend = FALSE) 
  # }
  
  P <- P + 
    labs(x = NULL, y = NULL, fill = "Intensity", title = cond) +
    
    theme(text = element_text(size = 20), 
          axis.text.x = element_text(angle = 45, 
                                     vjust = 1, 
                                     hjust = 1), 
          panel.background = element_rect(fill = NA))
    
  ggsave(file = file.path(out_dir, paste0(cond, ".jpg")), 
         width = fw, height = fh)
  
  print(paste("Done!", cond, "is saved."))
}
