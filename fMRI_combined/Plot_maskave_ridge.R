# source("Plot_maskave_ridge.R") 

setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))
# setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))

rm(list = ls())
fid <- c('local', 'remote')[2]

if ( fid == 'local' ) {
  grp_out <- '.'
  behav_folder <- "Familiarity_test_performance"
  
} else {
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
  grp_out <- file.path(top_dir, "derivatives")
  behav_folder <- file.path(top_dir, "code")
  # behav_folder <- file.path("/media", "data2", "pinwei", "SL_hippocampus", "behavioral_data", )
}

library(data.table)
library(ggplot2)
library(ggridges)
library(dplyr)
library(tidyr)
library(scales)
source("plotting_funcs.R")

################################### setup ######################################

re_plot <- c(T, F)[2]

ver <- 6
reml <- c("", "_REML")[2]
ap_ver <- paste0("runs_MNI_3ord_v", ver, reml)

gfunc <- c("", "_gfunc")[1]

## Load data
data_folder <- file.path(grp_out, paste0("ROIstats", gfunc), ap_ver)

load(file.path(data_folder, "maskave.all_ROI_Run_Cond.Rdata")) # all_DF
cond_list <- unique(all_DF$Cond)

roi_list <- unique(all_DF$ROI)
roi_list <- roi_list[roi_list != "CBM_ex"]

thres <- 0
alt <- c("greater", "two.sided")[2]

learner_only <- c(T, F)[2]
learner_list <- read.table(file.path(behav_folder, "subjList_learner.txt"), 
                           header = F, col.names = c("Subj"))

## Setup output folder: --------------------------------------------------------

fig_top <- file.path(grp_out, "ROI_analysis", ap_ver, 
                     ifelse(gfunc == "_gfunc", "Ridge (gfunc)", "Ridge"))

fig_top <- ifelse(learner_only, paste0(fig_top, " (learner only)"), fig_top)
                     
## Setup figure parameters: ----------------------------------------------------

color_list <- c("blue","#0099ff","cyan","gray","yellow","#ff9900","red")
color_breaks <- c(-1, -.99, -.95, -.9, .9, .95, .99, 1)
c_break_names <- c("-.001","-.05","-.01","0",".01",".05",".001")
c_label_names <- c("-.001","-.05","-.01",".01",".05",".001")

size_y.ax <- 25 
size_x.ax <- 25 
size_p.val <- 25 
size_title <- 30
wi <- 8
hi <- 8
fig_type <- ".png" 

##################################### MAIN #####################################

all_DF <- subset(all_DF, ROI %in% roi_list)

if ( learner_only ) {
  all_DF <- subset(all_DF, Subj %in% learner_list$Subj)
}

for ( cond in cond_list ) {
  
  fig_folder <- file.path(fig_top, cond)
  
  if ( ! file.exists(fig_folder) ) { dir.create(fig_folder, recursive=TRUE) }
  
  in_data <- subset(all_DF, Cond == cond)
  
  DF_summ <- my_1sampleT(in_data, "Run", "ROI", "Y", thres, alt)
  
  long_DF <- merge(x = in_data, 
                   y = DF_summ %>% 
                     select(all_of(c("ROI", "Run", "statistic", "p.value"))), 
                   by = c("ROI", "Run"), 
                   all.x = TRUE) # left join
  
  long_DF$flip_p <- ifelse(long_DF$statistic < 0,
                           long_DF$p.value - 1, # negative
                           1 - long_DF$p.value) # positive
  
  long_DF$flip_p_cut <- cut(long_DF$flip_p,
                            labels = c_break_names,
                            breaks = color_breaks)
  
  long_DF$run_stat <- paste0("R", long_DF$Run, ", p=", 
                             ifelse(long_DF$p.value < .001, "< .001", 
                                    round(long_DF$p.value, 3)))
  
  for ( roi in roi_list ) {
    
    fig_name <- paste0(roi, "_", cond, fig_type)

    if ( ! file.exists(file.path(fig_folder, fig_name)) | re_plot ) {

      sub_df <- subset(long_DF, ROI == roi)
      
      ggplot(sub_df, aes(x = Y, 
                         y = run_stat, 
                         fill = flip_p_cut,
                         group = Run)) +
        
        stat_density_ridges(quantile_lines = TRUE, # divide into two quantiles
                            quantiles = 2, 
                            quantile_fun = median,
                            size = .6,
                            alpha = .8,
                            scale = 2, 
                            linetype = "dashed", 
                            color = "white") + 
        
        stat_density_ridges(quantile_lines = TRUE, 
                            quantile_fun = mean,
                            size = .6,
                            alpha = .8,
                            scale = 2,
                            color = "black", 
                            fill = NA) + 
        
        theme_ridges(font_size = size_y.ax, 
                     grid = TRUE, 
                     center_axis_labels = TRUE) + 
        
        geom_vline(xintercept = thres,
                   linetype="solid",
                   alpha = 1,
                   size = 1,
                   color = "green") +
        
        scale_fill_manual(name = "p.value",
                          values = color_list, 
                          limits = c_break_names, 
                          labels = c_label_names) +
        
        guides(fill = guide_coloursteps(barwidth = 1, 
                                        barheight = 20, 
                                        frame.colour = "black", 
                                        frame.linewidth = 1.5, 
                                        ticks.colour = "black", 
                                        title.position = "top", 
                                        title.hjust = 0.5)) +
        
        # scale_x_continuous(limits = range(sub_df$Y, na.rm = T)) +
        coord_cartesian(xlim = range(sub_df$Y, na.rm = T)) + 
        
        labs(x = "Intensity", y = NULL) +
        
        ggtitle(paste(roi, cond)) + 
        
        theme(plot.title = element_text(vjust = -0.5, size = size_title),
              axis.text.y.left = element_text(size = size_y.ax), 
              axis.text.y.right = element_text(size = size_p.val), 
              axis.text.x = element_text(size = size_x.ax), 
              legend.title.align = 5,
              legend.title = element_text(size = 15)) 
      
      ggsave(file = file.path(fig_folder, fig_name), 
             width = wi, height = hi, dpi = 120)
      
      print(paste("Done!", fig_name, "is saved."))
      
    } else {
      
      print(paste(fig_name, "exist, do not replot."))
    }
  }
}
