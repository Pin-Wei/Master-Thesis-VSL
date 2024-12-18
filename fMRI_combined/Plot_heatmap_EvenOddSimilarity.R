# source("Plot_eoSimi_heatmap.R")
rm(list = ls())

# install.packages("")
library(reshape2)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plyr)
library(broom)
library(stringr) 

fw <- 6
fh <- 6

thres <- 0
alt <- c("greater", "two.sided")[2]
mask_no_sig <- F
do_aov <- F

ap_folder <- "ap-runs_v5"
stim_type <- c("tpl_sorted", "triplets")[1]
runs_type <- c("each", "binded")[1]
data_fn <- paste0("allROI_allRlist_allCond_allSubj_",stim_type,"_",runs_type,".csv")

fid <- c('local', 'remote')[1]
if ( fid == 'local' ) {
  top_dir <- file.path("C:", "Users", "PinWei", "my_VSL_fMRI")
  setwd(top_dir)
  data_dir <- file.path(top_dir, "PyMVPA", "odd_even_trials_similarity", ap_folder)
  
} else {
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus")
  setwd(file.path(top_dir, "Combined_group", "code"))
  mvpa_dir <- file.path(top_dir, "Combined_group", "derivatives", "PyMVPA")
  data_dir <- file.path(mvpa_dir, "odd_even_trials_similarity", ap_folder)
}
source("plotting_funcs.R")

out_dir <- file.path(data_dir, "Plot_heatmap", paste0(stim_type,"_",runs_type))
if ( ! file.exists(out_dir) ) { 
  dir.create(out_dir, recursive=TRUE)
} 

DF_all <- read.csv(file.path(data_dir, data_fn), header=T)
# roi_list <- unique(DF_all$ROI)
cond_list <- unique(DF_all$Cond)
runs_list <- unique(DF_all$Runs)

select_roi_list <- 2

fw <- c(15, 10, 8, 6)[select_roi_list]
fh <- 6

roi_list <- list(
  c("Pre_Central", "Para_Central",
    "Post_Central", "Supra_Marginal", "Sup_Pari", "Inf_Pari", "Pre_Cuneus",
    "Lingual", "Peri_Calcarine", "Cuneus",
    "V1", "V2", "V3", "High-Vis",
    "Sup_Temp", "Mid_Temp", "Inf_Temp", "Trans_Temp", "Fusiform",
    "PHC", "PRC", "ERC",
    "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4",
    "Caudate", "Putamen",
    "Insula", "Post_Cingulate", "Isth_Cingulate"), 
  
  c("V1", "V2", "V3", "High-Vis", "Fusiform", "Inf_Temp", 
    "PHC", "PRC", "ERC", "Hippocampus", 
    "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", 
    "Caudate", "Putamen"),   
  
  c("V1", "V2", "V3", "High-Vis", "Fusiform", "Inf_Temp", 
    "PHC", "PRC", "ERC", "Hippocampus"), 
  
  c("High-Vis", "Hippocampus")
  
)[[select_roi_list]]

if ( stim_type == "triplets") {
  my_color_range <- c(-.5, .5)
  my_colors <- c("blue", "cyan", "green", "yellow", "orange", "red")
  
} else {
  my_color_range <- c(0, .2)
  my_colors <- c("green", "yellow", "orange", "red", "darkred")
}

# no_sig_colors <- c("#003399", "#3399FF", "cyan", "green")

################################################################################

for ( cond in cond_list ) {
  DF_sub <- subset(DF_all, Cond == cond) 
  DF_summ <- my_1sampleT(DF_sub, "ROI", "Runs", "Similarity", thres, alt)
  DF_summ <- subset(DF_summ, DF_summ$ROI %in% roi_list)
  DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
  
  if ( do_aov ) {
    DF_anova <- DF_sub %>%
      group_by(ROI) %>%
      do(tidy(aov(Similarity ~ Runs, data = .), na.rm = TRUE)) %>% 
      subset(term == "Runs") %>% 
      mutate(
        aov_stat_sign = ifelse(p.value < .05, "*", "n.s."),
        aov_stat = paste0(
          "F = ", round(statistic, 2), " (p = ", round(p.value, 3), ")")
      ) %>% select(all_of(c("ROI", "aov_stat", "aov_stat_sign"))) 
    
    DF_summ <- join(DF_summ, DF_anova, type = "left", by = "ROI")
  }
  
  # ----------------------------------------------------------------------------
  P <- ggplot(DF_summ, aes(x = ROI, y = Runs, fill = mean)) + 
    
    geom_tile(color = "white", lwd = 1, linetype = 1) + 
    coord_fixed()
  
  if ( mask_no_sig == T ) {
    P <- P + 
      geom_tile(data = subset(DF_summ, DF_summ$p_Nsig == "n.s."), 
                fill = "white") 
  } else {
    P <- P + 
      # scale_fill_gradient(low = "yellow", high = "red")
      scale_fill_gradientn(colors = my_colors, limits = my_color_range)
  }
  
  if ( do_aov ) {
    P <- P + 
      geom_text(data = subset(DF_summ, 
                              Runs == runs_list[length(runs_list)]), # last one
                aes(label = aov_stat, x = ROI, color = aov_stat_sign), 
                angle = 90,
                size = 4, hjust = "inward", 
                check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE) +
      
      scale_color_manual(values = c("red", "black"), 
                         limits = c("*", "n.s."))
  } else {
    P <- P + 
      geom_text(data = DF_summ,
                aes(label = round(mean, 2), 
                    x = ROI, y = Runs), 
                size = 4, na.rm = TRUE, show.legend = FALSE) 
  }
  
  P <- P + 
    labs(x = NULL, y = NULL, fill = "Similarity", title = cond) +
    
    theme(text = element_text(size = 20), 
          axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1), 
          panel.background = element_rect(fill = NA))
  
  fig_name <- paste0(cond," (",length(roi_list),").jpg")
  ggsave(file = file.path(out_dir, fig_name), width=fw, height=fh)
  print(paste("Done!", fig_name, "is saved."))
}
