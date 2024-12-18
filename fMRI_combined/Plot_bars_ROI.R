# source("Plot_bars_ROI.R")
rm(list = ls())
setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))

library(ggplot2)
library(reshape2)
library(dplyr)
library(stringr) 
source("plotting_funcs.R")
source("roi_2_region.R") # region_list = c("Frontal", "Parietal", "Occipital", "Visual", "Temporal", "MTL", "Hippocampal", "Striatal", "Others"))

re_plot <- T
do_stat <- F
thres <- 0

top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus")
grp_out <- file.path(top_dir, "Combined_group", "derivatives")
clf_top <- file.path(grp_out, "PyMVPA", "classification_out")
ana_top <- file.path(grp_out, "Group_analysis")

quantity <- "Size"
data_name <- "long_ROI_sizes.csv"
data_path <- file.path(clf_top, data_name)

fig_name <- gsub(".csv", ".jpg", data_name)
fig_path <- gsub(".csv", ".jpg", data_path)
# fig_path <- file.path(clf_top, fig_name)
# if ( ! file.exists(fig_path) ) { 
#   dir.create(fig_path, recursive=TRUE)
# }

roi_list <- c(
  "Pre_Central", "Para_Central", 
  "Post_Central", "Supra_Marginal", "Sup_Pari", "Inf_Pari", "Pre_Cuneus", 
  "Lingual", "Peri_Calcarine", "Cuneus", 
  "V1", "V2", "V3", "High.Vis", "High-Vis",
  "Sup_Temp", "Mid_Temp", "Inf_Temp", "Trans_Temp", "Fusiform",
  "PHC", "PRC", "ERC", 
  "Hipp.Sub", "Hipp.CA1", "Hipp.CA2.3", "Hipp.DG.CA4", 
  "Hipp-Sub", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4",
  "Caudate", "Putamen", 
  "Insula", "Post_Cingulate", "Isth_Cingulate"
)

# ==============================================================================
in_data <- read.csv(data_path, header=T)
y_min <- 0 # min(in_data[quantity])
y_max <- max(in_data[quantity]) + 1000

if ( do_stat ) {
  in_data$X <- 0
  DF_summ <- my_1sampleT(in_data, "ROI", "X", quantity, thres, "greater")
  
} else {
  DF_summ <- in_data %>% 
    group_by(ROI) %>%
    summarise_at(
      vars(quantity),
      list(mean = ~ mean(., na.rm = TRUE), 
           sd = ~ sd(., na.rm = TRUE), 
           max = ~ max(., na.rm = TRUE))
      )  
}

DF_summ <- subset(DF_summ, DF_summ$ROI %in% roi_list)
DF_summ$ROI <- factor(DF_summ$ROI, levels = roi_list)
DF_summ$Region <- factor(sapply(DF_summ$ROI, roi_2_region), levels = region_list)

P <- ggplot(DF_summ, aes(x = ROI, y = mean, fill = Region, color = Region)) +
  
  geom_bar(stat = "identity", position = "dodge2", width = .6, alpha =.5) +
  
  geom_linerange(aes(ymin = mean - sd, 
                     ymax = mean + sd), position = position_dodge(.9)) + 
  
  geom_text(aes(label = round(mean, 0), y = mean), 
            colour = "gray", 
            position = position_dodge(.9), 
            angle = 90, hjust = -.5, vjust = .5, 
            # angle = 15, hjust = .5, vjust = 0,
            check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE) +

if ( do_stat ) {
  P <- P +
    geom_hline(aes(yintercept = thres),
               color = "red", linetype = 2, linewidth =.5, alpha =.7)
} 

P <- P +
  coord_cartesian(ylim = c(y_min, y_max)) +
  
  labs(x = NULL, y = quantity, 
       title = gsub("_", " ", gsub(".jpg", "", fig_name))) +
  
  theme(text = element_text(size = 14), 
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 14, angle = 90, hjust = 1, vjust = .5))

if ( do_stat ) {
  my_addSig2Plt(P, P_PRINT=F, P_SIG=T, P_NSIG=F)
  
} else {
  P
}

ggsave(file = fig_path, width=10, height=5)
print(paste("Done!", fig_name, "is saved."))
