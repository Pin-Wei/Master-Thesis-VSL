# source("Plot_RBA_ridge.R")
setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))

library(data.table)
library(ggplot2)
library(ggridges)
library(dplyr)
library(tidyr)
library(scales)

rm(list = ls())
load("roiList_RBA.Rdata")

fid <- c('local', 'remote')[2]
if ( fid == 'local' ) {
  setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))
  top_dir <-"RBA"
  
} else { # remote
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus", 
                       "Combined_group", "derivatives", "RBA")
  setwd(top_dir)
}

################################### setup ######################################

ver <-  as.integer(readline("which afni_proc version? (runs_MNI_3ord_v?) "))
ap_ver <- paste0("runs_MNI_3ord_v", ver)

if ( ver == 6 ) {
  cond_list <- c("Fst", "Snd", "Trd", 
                 "any.stim", "1.and.2", "2.and.3", "1.vs.2", "3.vs.2", "1.vs.3", "1.2.vs.3", "2.3.vs.1", "1.vs.2.3", "3.vs.1.2")
} else if ( ver == 5 ) {
  cond_list <- c("Fst", "Snd", "Trd", 
                 "1+2+3", "1+2", "2+3", "1-2", "3-2", "1-3")
} else {
  print("Not exist, exit...")
  q()
}

reml <- as.integer(readline("REML? ([1]: Yes [2]: No) "))
id0 <- c("REML_", "")[reml]

model_idx <- as.integer(readline("model ID ([1]: basic [2]: StudY [3]: Score)? "))
id1 <- c("basic", "StudY", "Score")[model_idx]

model_id <- paste0(id0, id1)
print(model_id)

# eoi_idx <- as.integer(readline("Effect of interest: [1]: Intercept [2]: Intercept + Score"))
if ( model_idx == 3 ) {
  eoi_list <- c("", "Score_")
  lab_list <- c("Intercept", "Score")
} else {
  eoi_list <- c("")
  lab_list <- c("Intercept")
}

## Setup figure parameters: ----------------------------------------------------

gradient.colors <- c(
  "blue","cyan","gray","gray","yellow","#C9182B"
  )  # change gradient color

Column.label.size <- 25 # adjust ROI and probability y-axis font size
P.label.size <- 25      
title.size <- 30        # adjust graph title size
x.axis.size <- 25       # adjust x-axis label sizes
file.type <- ".png"     # can be ".jpeg",".pdf",".png",".bmp",".tiff",etc
units <- "in"           # can be "in", "cm", or "mm"
wi <- 8                 # width
hi <- 8                 # height

##################################### MAIN #####################################

data_dir <- file.path(top_dir, ap_ver, paste0("model_", model_id), "Posteriors_per_ROI")

for ( cond in cond_list ) {
  
  for ( xi in seq(length(eoi_list)) ) {
    eoi <- eoi_list[xi]
    labx <- lab_list[xi]
    
    load(file.path(data_dir, paste0(eoi, ap_ver, "_", cond, ".RData")))
    
    for ( roi in roi_list ) {
      data <- get(roi)
      xlim <- range(data)
      
      data$X <- NULL
      nobj <- dim(data)[1]
      
      run_list <- dimnames(data)[[2]]
      data_stats <- data.frame(1:length(run_list))
      
      data_stats$Run <- run_list
      data_stats$mean <- colMeans(data)  # median: quantile(x, probs=.5)
      data_stats$P <- colSums(data > 0)/nobj
      data_stats$Pn <- ifelse(data_stats$P < .5, 1-data_stats$P, data_stats$P)
      data_stats <- data_stats[order(data_stats$mean),]
      
      data_trans <- as.data.frame(t(as.matrix(data)))
      data_trans <- tibble::rownames_to_column(data_trans, "Run")
      data_trans$X <- 1:nrow(data_trans)
      
      # Merge values & stats into one table by Run
      data_merge <- merge(data_stats, data_trans, by = "Run")
      data_merge <- data_merge[order(data_merge$X),]
      
      # Transform data into long form: Melt dataframe by Run
      data_long <- reshape2::melt(data_trans, id=c("Run", "X"))
      data_long <- data_long[order(data_long$X),]
      
      # Clunky, but for now stats by ensuring orders are all the same 
      #   and repeating each value nobj times. no success for alternatives.
      data_long$mean <- rep(data_merge$mean, each = nobj)
      data_long$P <- rep(data_merge$P, each = nobj)
      data_long$Pn <- rep(data_merge$Pn, each = nobj)
      data_long$gray.vals <- rep(data_merge$gray.vals, each = nobj)
      
      ## GRAPHING VARIABLES ##
      # Set your labels here, 
      #   so you don't have to change within the plot below :)
      y.axis.labs <- data_stats$Run             # y axis labels
      sec.y.axis.labs <- round(data_stats$P,2)  # second y axis labels (probabilities) - Rounded to 2 decimals
      
      # X-axis labels need to change to correspond to data set !!!
      #   Uncomment whichever matches !!!
      x.axis.labs <- NULL                       # x axis labels  INTERACTION, not sure what to put.
      x.labs.pos <- NULL                        # a axis position INTERACTION, change when labels decided
      
      # Set title:
      graph.title <- paste(as.name(roi), cond)  # graph title
      legend.title <- "P+"                      # legend title
      y.axis.title <- NULL                      # for now ...
      x.axis.title <- "% signal change"         # for now ...
      
      # Graph data:
      dataset <- data_long
      x.values <- data_long$value               # x values
      # y.values <- data_long$Run                 # y values
      y.values <- paste(data_long$Run, round(data_long$P, 2), sep=", P=")
      y.values.RO <- data_long$value            # values to reorder Y by
      distrib.fill <- data_long$P               # fill graph with probabilities
      group <- data_long$Run
      
      ggplot(dataset, aes(x = x.values,
                          y = y.values,
                          # y = as.numeric(gsub("run-", "", y.values))-1,
                          # y = as.numeric(reorder(y.values, y.values.RO)),
                          fill = distrib.fill,
                          group = group)) +
        
        guides(fill = guide_colorbar(barwidth = 1, # legend characteristics
                                     barheight = 20,
                                     nbin = 100,   # can change # bins to play around with color gradient
                                     frame.colour = "black",
                                     frame.linewidth = 1.5,
                                     ticks.colour = "black",
                                     title.position = "top",
                                     title.hjust = 0.5)) +
        
        # geom_density_ridges() + # scale = spacing, alpha = transparency
        stat_density_ridges(quantile_lines = TRUE,         # divide into two quantiles (show mean)
                            quantiles = 2,
                            size = .6,
                            alpha = .8,
                            scale = 2,
                            color = "black") +
        
        geom_vline(xintercept = 0,   # create line at X = 0
                   linetype="solid",
                   alpha = 1,
                   size = 1,
                   color = "green") +
        
        scale_fill_gradientn(
          colors = gradient.colors,  # set gradient
          limits = c(0,1),           # scale size
          name = legend.title,
          breaks = c(0,0.05,0.1,0.9,0.95,1),
          expand = expansion(0),
          labels = c("0","0.05","0.1","0.9", "0.95","1")) +
        
        # A VERY HACK-Y WAY TO HAVE TWO Y AXES W DISCRETE DATA:
        # scale_y_continuous(breaks = 1:length(run_list),
        # labels = y.axis.labs,          # Trick ggplot into thinking data is continuous...
        # sec.axis = sec_axis(~.,        # Second axis to show probabilities
        #                     breaks = 1:length(run_list),
        #                     labels = sec.y.axis.labs)) +

        theme_ridges(font_size = Column.label.size,    # theme info
                     grid = TRUE, center_axis_labels = TRUE) +
        
        ggtitle(graph.title) + # graph title
        
        annotate("text", x=0.06, y=1.5, label=labx, size=5.5) +
        
        theme(
          plot.title = element_text(vjust = -0.5, size = title.size),  # plot title size and position
          # axis.title.x = element_text(vjust=0, hjust=0.5),
          axis.text.y.left = element_text(size=Column.label.size),        # y-axis text size
          axis.text.y.right = element_text(size = P.label.size),       # y-axis info for right axis
          axis.text.x = element_text(size = x.axis.size),              # x-axis text size/face
          # axis.text.x = element_text(size = x.axis.size, face = "bold"), # x-axis text size/face
          legend.title.align = 5,
          # legend.text = element_text(face = "bold"),
          legend.title = element_text(size = 15)) + 
        
        # legend.title = element_text(face = "bold", size = 15)) + 
        
        labs(
          # x = 'interaction (% signal change)', # Add or not add X and Y labels
          x = NULL,
          y = NULL) +
        
        scale_x_continuous(limits = xlim) + xlab(labx)
      
      ### save -----------------------------------------------------------------
      
      figure_name <- paste0(roi, "_", cond, file.type)
      # figure_name <- paste0(labx, "_", roi, "_", cond, file.type)
      
      figure_dir <- file.path(data_dir, "Figures", paste0("v", ver, "_", cond))
      if ( ! file.exists(figure_dir) ) { dir.create(figure_dir, recursive=TRUE) }
      
      ggsave(file = file.path(figure_dir, figure_name), 
             width = wi, height = hi, dpi = 120)
    }
  }
}
