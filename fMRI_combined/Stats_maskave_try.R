# source("Stats_maskave_ANOVA.R") 

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
library(ggExtra)

################################### setup ######################################

roi_select <- list(
  c("High-Vis", "Hippocampus"), # 1
  c("Fusiform", "Hippocampus"), # 2
  c("Inf_Temp", "Hippocampus"), # 3
  c("Hippocampus", "Inf_Temp", "Fusiform", "LOC-V12", "V1+2"), # 4
  c("Hippocampus", "Inf_Temp", "Fusiform", "High-Vis", "V3", "V2", "V1"), # 5
  c("HPC-head", "HPC-body", "HPC-tail"), # 6
  c("PHC", "PRC", "ERC", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hipp-Sub"), # 7
  c("lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC", 
    "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", 
    "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-Sub", "rh-Hipp-Sub"), # 8
  c("Inf_Temp", "Fusiform", "LOC-V12", "V1+2") # 9
)[7][[1]]

rois_name <- c(
  paste(roi_select, collapse = ", "),  # default
  paste0(length(roi_select), " ROIs"), # number of rois
  ""                                   # specified
)[2]

Visual   <- c("Inf_Temp", "Fusiform", "High-Vis", "LOC-V12", "V3", "V1+2", "V2", "V1")
Hippo    <- c("Hippocampus", "HPC-head", "HPC-body", "HPC-tail", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hipp-Sub", 
            "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-Sub", "rh-Hipp-Sub")
MTL      <- c("PHC", "PRC", "ERC", "lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC")
rois_map <- data.frame(Raw = c(Visual, Hippo, MTL), 
                       New = c(rep("Visual", length(Visual)), 
                               rep("Hippocampal", length(Hippo)), 
                               rep("MTL", length(MTL))))

cond_list <- c("Fst", "Snd", "Trd")

learner.thresh <- c(21.33, 27)[2]

pwc.adj.method <- c("holm", "bonferroni")[1]

## Data version (asking input): ================================================

dtype <- as.integer(readline("PPI or ordinary stats? [1 or 2] "))

if ( dtype == 1 ) {
  
  seed_list <- c("HPC-head", "HPC-body", "HPC-tail", "Hippocampus")
  print(seed_list)
  seed_roi <- seed_list[as.integer(readline("Which seed? [index] "))]
  
  ap_ver <- file.path("runs_MNI_3ord_v6.PPI_REML", seed_roi)
  gfunc <- c("", "_gfunc")[1]
  
} else {
  
  ap_ver <- "runs_MNI_3ord_v6_REML"
  # ap_ver <- paste0("runs_MNI_3ord_v", 
  #   readline("which afni_proc version? (runs_MNI_3ord_v?) "), 
  #   c("", "_REML")[2])
  
  # gfunc <- c("", "_gfunc")[2]
  gfunc <- c("", "_gfunc")[
    as.integer(readline("What kind of ROIS? ([1]: anat [2]: gfunc) "))]
}

learner_only <- F
# learner_only <- c(T, F)[
#   as.integer(readline("Learner only? ([1]: Yes [2]: No) "))]

## Output folder: ==============================================================

folder_name <- paste0(rois_name, " (", paste(cond_list, collapse = " & "), ")")

folder_name <- ifelse(nchar(rois_name) >= 100, 
                      paste0(length(roi_select), " ROIs", 
                             " (", paste(cond_list, collapse = " & "), ")"), folder_name)

folder_name <- ifelse(gfunc == "_gfunc", 
                      paste0("[gfunc] ", folder_name), folder_name)

folder_name <- ifelse(learner_only, 
                      paste0(folder_name, " (learner only)"), folder_name)

out_dir <- file.path(grp_out, "ROI_analysis", ap_ver, "ANOVA", folder_name)
if ( ! file.exists(out_dir) ) { dir.create(out_dir, recursive=TRUE) }

fig_dir <- file.path(grp_out, "ROI_analysis", ap_ver, 
                     ifelse(gfunc == "_gfunc", 
                            "Corr_with_behav (gfunc)", "Corr_with_behav"), 
                     paste0(length(roi_select), "_ROIs"))
if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }

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
# all_DF$Run  <- sprintf("run-%02d", as.integer(all_DF$Run))
all_DF$Run  <- as.integer(all_DF$Run) - 1

sub_DF           <- subset(all_DF, ROI %in% roi_select & Cond %in% cond_list)
sub_DF$ROI       <- factor(sub_DF$ROI, levels = roi_select)
sub_DF$hemi      <- ifelse(grepl("rh-", sub_DF$ROI), "R", 
                           ifelse(grepl("lh-", sub_DF$ROI), "L", "Uni"))
sub_DF$ROI_group <- rois_map$New[match(sub_DF$ROI, rois_map$Raw)]
# sub_DF$Y.sign    <- ifelse(sub_DF$Y > 0, "Pos", "Neg")

if ( learner_only ) { sub_DF <- subset(sub_DF, Group == "L") }

bin.n <- 5
if ( bin.n == 4 ) {
  sub_DF$Score.bin <- cut(sub_DF$Score, 
                          breaks = c(0, 21.33, 27, 27+sd(behav$Score), 60), 
                          labels = c(paste0("guess (", dim(subset(behav, Score <= 21.33))[1], ")"), 
                                     paste0("mid.guess (", dim(subset(behav, Score > 21.33 & Score <= 27))[1], ")"), 
                                     paste0("learn (", dim(subset(behav, Score > 27 & Score <= 27+sd(behav$Score)))[1], ")"), 
                                     paste0("high.learn (", dim(subset(behav, Score > 27+sd(behav$Score)))[1], ")")))
  bin.ranges <- sort(unique(cut(sub_DF$Score, breaks = c(0, 21.33, 27, 27+sd(behav$Score), 60))))
  
} else if ( bin.n == 5 ) {
  sub_DF$Score.bin <- cut(sub_DF$Score, 
                          breaks = c(0, 21.33, 27, 27+sd(behav$Score), 27+2*sd(behav$Score), 60), 
                          labels = c(paste0("guess (", dim(subset(behav, Score <= 21.33))[1], ")"), 
                                     paste0("mid.guess (", dim(subset(behav, Score > 21.33 & Score <= 27))[1], ")"), 
                                     paste0("learn (", dim(subset(behav, Score > 27 & Score <= 27+sd(behav$Score)))[1], ")"), 
                                     paste0("learn+sd (", dim(subset(behav, Score > 27+sd(behav$Score) & Score <= 27+2*sd(behav$Score)))[1], ")"), 
                                     paste0("learn+2sd (", dim(subset(behav, Score > 27+2*sd(behav$Score)))[1], ")")))
  bin.ranges <- sort(unique(cut(sub_DF$Score, breaks = c(0, 21.33, 27, 27+sd(behav$Score), 27+2*sd(behav$Score), 60))))
}

data_means <- sub_DF %>% group_by(ROI, Cond, Run) %>% 
  summarise_at("Y", .funs = mean)

## =============================================================================
corr.lm.and.score   <- c(T, F)[1]
corr.diff.and.score <- c(T, F)[2]
plot.2way.per.subj  <- c(T, F)[1]
plot.3way.per.subj  <- c(T, F)[1]
plot.2way.bin.subj  <- c(T, F)[1]
plot.3way.bin.subj  <- c(T, F)[1]

## =============================================================================
if ( corr.lm.and.score ) {
  fit_per_cond <- sub_DF %>% group_by(ROI, Cond, Subj) %>% 
    do(broom::tidy(lm(formula = Y ~ Run, data = .))) 
  
  fit_overall <- sub_DF %>% group_by(ROI, Subj) %>% 
    do(broom::tidy(lm(formula = Y ~ Run, data = .))) 
  
  fit_overall$Cond <- "overall"
  
  fit_out       <- rbind(fit_per_cond, fit_overall)
  fit_out       <- subset(fit_out, term == "Run")
  fit_out$Score <- behav$Score[match(fit_out$Subj, behav$Subj)] 
  
  write.csv(fit_out, file.path(out_dir, "Linear_fit_Run_per-Subj.csv"))
  
  for ( roi in roi_select ) { 
    # for ( cond in c(cond_list, "overall") ) {
    for ( cond in cond_list ) {
      
      if ( cond == "overall" ) {
        sub_data <- subset(fit_out, ROI == roi)
      } else {
        sub_data <- subset(fit_out, ROI == roi & Cond == cond) }
      
      # <- cor.test(sub_data$estimate, sub_data$Score, method = "pearson")
      
      P <- ggscatter(sub_data, x = "estimate", y = "Score",
                     add = "reg.line", 
                     conf.int = TRUE, 
                     cor.coef = TRUE, 
                     cor.method = "pearson", 
                     cor.coef.size = 5) + 
        ylim(c(0, 60)) + 
        theme(text = element_text(size = 20))
      
      P <- ggpar(P, 
                 xlab = "Slope (Y ~ Run)", 
                 caption = paste0("N = ", length(sub_data$Subj)),
                 title = paste0(roi, ", ", cond)) 
      
      P <- ggMarginal(P, type="histogram") 
      
      ggsave(P, file = file.path(fig_dir, paste0(roi, "_", cond, ".jpg")), 
             width = 6, height = 6, dpi = 200) 
    }
  } 
}

if ( corr.diff.and.score ) {
  
  for ( roi in roi_select ) { 
    for ( cond in cond_list ) {
      
      # data.R2 <- subset(sub_DF, ROI == roi & Cond == cond & Run == 2)
      # data.R3 <- subset(sub_DF, ROI == roi & Cond == cond & Run == 3)
      # data.R5 <- subset(sub_DF, ROI == roi & Cond == cond & Run == 5)
      data.comp <- data.frame(Subj   = data.R5$Subj, 
                              Score  = data.R5$Score, 
                              Y.comp = data.R5$Y - data.R3$Y)
                              # Y.comp = data.R5$Y - data.R2$Y)
      
      P <- ggscatter(data.comp, x = "Y.comp", y = "Score",
                     add = "reg.line", 
                     conf.int = TRUE, 
                     cor.coef = TRUE, 
                     cor.method = "pearson", 
                     cor.coef.size = 5) + 
        ylim(c(0, 60)) + 
        theme(text = element_text(size = 20))
      
      P <- ggpar(P, 
                 xlab = "Intensity increase (4th - 2nd)", 
                 # xlab = "Intensity increase (4th - 1st)", 
                 caption = paste0("N = ", length(data.comp$Subj)),
                 title = paste0(roi, ", ", cond)) 
      
      P <- ggMarginal(P, type="histogram") 
      
      fig_dir <- file.path(out_dir, "Figure (corr with behav)")
      if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }
      
      ggsave(P, file = file.path(fig_dir, paste0(roi, "_", cond, ".jpg")), 
             width = 6, height = 6, dpi = 200) 
    }
  } 
}

if ( plot.2way.per.subj ) {
  for ( roi in roi_select ) {
    for ( sidx in behav$Subj ) {
      subj_df <- subset(sub_DF, Subj == sidx & ROI == roi)
      subj_score <- subj_df$Score[1]
      
      P <- ggerrorplot(subj_df, x = "Run", y = "Y", color = "Cond", 
                       palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                       desc_stat = "mean", 
                       position = position_dodge(.8), alpha = .8, 
                       font.label = list(size = 20),
                       short.panel.labs = FALSE) + 
        
        stat_summary(aes(group = Cond, color = Cond), fun = mean, geom = "line", 
                     position = position_dodge(width = .8), 
                     linewidth = 1, alpha = .8) + 
        
        geom_vline(xintercept = seq(1.5, 7.5), 
                   linetype = "dashed", color = "gray", alpha = .5) + 
        
        ylim(c(min(subset(sub_DF, ROI == roi)$Y)-.01, 
               max(subset(sub_DF, ROI == roi)$Y)+.01)) + 
        
        theme(text = element_text(size = 20), 
              legend.position = "right") 
      
      P <- ggpar(P, xlab = "Exposure runs", ylab = "Intensity", 
                 subtitle = roi,
                 title = paste0("Subj. ", sidx, ", score = ", subj_score)) 
      
      fig_dir <- file.path(out_dir, "Figure Cond_x_Run (per subj)", roi)
      if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }
      
      fig_name <- paste0(subj_score, "_s", sidx, ".jpg")
      
      ggsave(P, file = file.path(fig_dir, fig_name), width = 8, height = 6, dpi = 200) 
    }
  }
}

if ( plot.3way.per.subj ) {
  sub_DF$ROI <- reorder(sub_DF$ROI, sub_DF$Y, FUN = mean, decreasing = T)
  
  for ( sidx in behav$Subj ) {
    subj_df <- subset(sub_DF, Subj == sidx)
    subj_score <- subj_df$Score[1]
    
    P <- ggerrorplot(subj_df, x = "Run", y = "Y", facet.by = "Cond", color = "ROI", 
                     desc_stat = "mean", 
                     position = position_dodge(width = .8), alpha = .5,
                     font.label = list(size = 20),
                     short.panel.labs = FALSE) +
    
      stat_summary(aes(group = ROI, color = ROI), fun = mean, geom = "line", 
                   position = position_dodge(width = .8), 
                   linewidth = 1, alpha = .8) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5) + 
      
      ylim(c(min(sub_DF$Y)-.01, max(sub_DF$Y)+.01)) + 
      
      theme(text = element_text(size = 20))
    
    P <- ggpar(P, xlab = "Exposure runs", ylab = "Intensity", 
               title = paste0("Subj. ", sidx, ", score = ", subj_score)) 
    
    fig_dir <- file.path(out_dir, "Figure Cond_x_Run_x_ROI (per subj)")
    if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }
    
    fig_name <- paste0(subj_score, "_s", sidx, ".jpg")
    
    ggsave(P, file = file.path(fig_dir, fig_name), 
           width = 10, height = 6, dpi = 200) 
  }
}

if ( plot.2way.bin.subj ) {
  
  for ( roi in roi_select ) {
    P <- ggerrorplot(subset(sub_DF, ROI == roi), 
                     x = "Run", y = "Y", facet.by = "Cond", 
                     group = "Score.bin", color ="Score.bin", 
                     # palette = c("#3300CC", "#9900FF", "#FF0066", "#FF0033", "#CC0033"), 
                     desc_stat = "mean_se", 
                     position = position_dodge(width = .8), alpha = .5, 
                     short.panel.labs = FALSE) +
      
      stat_summary(aes(group = Score.bin, color = Score.bin), 
                   fun = mean, geom = "line", 
                   position = position_dodge(width = .8),
                   linewidth = 1, alpha = .5) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5) + 

      theme(text = element_text(size = 20))
    
    P <- ggpar(P, xlab = "Exposure runs", ylab = "Intensity", title = roi) 
    
    fig_dir <- file.path(out_dir, "Figure Cond_x_Run (per subj)")
    if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }
    
    fig_name <- paste0(roi, " (", bin.n, " bins).jpg")
    
    ggsave(P, file = file.path(fig_dir, fig_name), 
           width = 15, height = 6, dpi = 200) 
  }
}

if ( plot.3way.bin.subj ) {
  sub_DF$ROI <- reorder(sub_DF$ROI, sub_DF$Y, FUN = mean, decreasing = T)
  
  count <- 1
  for ( score.bin.label in sort(unique(sub_DF$Score.bin)) ) {
    subb_df <- subset(sub_DF, Score.bin == score.bin.label)

    P <- ggerrorplot(subb_df, x = "Run", y = "Y", 
                     facet.by = "Cond", color = "ROI", 
                     desc_stat = "mean_se", 
                     position = position_dodge(width = .8), alpha = .5,
                     font.label = list(size = 20),
                     short.panel.labs = FALSE) +
      
      stat_summary(aes(group = ROI, color = ROI), fun = mean, geom = "line", 
                   position = position_dodge(width = .8), 
                   linewidth = 1, alpha = .8) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5) + 
      
      ylim(c(min(sub_DF$Y)-.01, max(sub_DF$Y)+.01)) + 
      
      theme(text = element_text(size = 20))
    
    P <- ggpar(P, xlab = "Exposure runs", ylab = "Intensity", 
               title = score.bin.label) 
    
    fig_dir <- file.path(out_dir, "Figure Cond_x_Run_x_ROI (per subj)", paste0(bin.n, " bins"))
    if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }
    
    bin.range <- bin.ranges[count]
    count <- count + 1
    fig_name <- paste0(bin.range, " ", score.bin.label, ".jpg")
    
    ggsave(P, file = file.path(fig_dir, fig_name), 
           width = 15, height = 6, dpi = 200) 
  }
}