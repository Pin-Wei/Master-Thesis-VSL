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

runs_type <- c("each", "binded")[1]

meas <- c("correlation", "euclidean", "hamming")[as.integer(readline(
  "What measure? [1] correlation [2] euclidean [3] hamming "))]

# design_select <- as.integer(readline(
#   "Slow or Rapid only? ([0]: No (all) [1]: Slow [2]: Rapid) "))
# if ( design_select == 1 ) {
#   slow_only    <- c(T, F)[1]
#   rapid_only   <- c(T, F)[2]
# } else if ( design_select == 2 ) {
#   slow_only    <- c(T, F)[2]
#   rapid_only   <- c(T, F)[1]
# } else { # all
  slow_only    <- c(T, F)[2]
  rapid_only   <- c(T, F)[2]
# }

compare_design <- c(T, F)[as.integer(readline(
  "Compare Slow vs. Rapid? ([1]: Yes [2]: No) "))]
  
# learner_only <- c(T, F)[2]
learner_only <- c(T, F)[
  as.integer(readline("Learner only? ([1]: Yes [2]: No) "))]
learner.thresh <- c(21.33, 27)[2]

cond_select_idx <- 1
cond_select     <- list(
  c("Fst", "Snd", "Trd"),
  c("Fst", "Snd", "Trd"),
  c("All"), 
  c("Snd", "Trd"), 
  c("Trd")
)[cond_select_idx][[1]]

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
roi_select_idx <- as.integer(readline("Which ROIs set? (index) "))
# roi_select_idx <- 1
roi_select     <- roi_select_list[roi_select_idx][[1]]
rois_name      <- rois_name_list[roi_select_idx]
rois_paired    <- rois_is_paired[roi_select_idx]

pwc.adj.method <- c("holm", "bonferroni")[1]

## Load data + combine with behav: =============================================

data_dir <- file.path(
  grp_out, "PyMVPA", "odd_even_trials_similarity", ap_folder, meas
)
data_fn <- paste0(
  "allROI_allRlist_allCond_allSubj_", stim_type, "_", runs_type, ".csv"
)
all_DF      <- read.csv(file.path(data_dir, data_fn), header=T)
all_DF$Subj <- as.numeric(gsub("sub-", "", all_DF$Subj))
if ( runs_type == "each") {
  all_DF$Run  <- as.integer(gsub("run-", "", all_DF$Runs)) - 1
} else if ( runs_type == "binded" ) { 
  all_DF$Run  <- as.integer(gsub("R23", 1, 
                                 gsub("R45", 2, 
                                      gsub("R67", 3, 
                                           gsub("R89", 4, all_DF$Runs)))))
}
run_list <- unique(all_DF$Run)

behav <- read.table(
  file.path(behav_folder, "familiarity_test_score.txt"), 
  header = T, row.names = NULL, 
)
colnames(behav) <- c("Subj", "ACC", "Score", "Vio")
behav$Subj      <- as.numeric(behav$Subj)
behav$Group     <- ifelse(behav$Score > learner.thresh, "L", "N")
behav$Design    <- ifelse(behav$Subj > 100, "slow", "rapid")

all_DF <- dplyr::left_join(all_DF, behav, by="Subj")

all_DF$Subj <- as.factor(all_DF$Subj)
all_DF$Runs <- factor(all_DF$Runs, levels = sort(unique(all_DF$Runs)))

sub_DF      <- subset(all_DF, ROI %in% roi_select & Cond %in% cond_select)
if ( cond_select_idx != 1 ) {
  sub_DF <- sub_DF %>% 
    group_by(Run, ROI, Subj) %>% 
    summarise_at(., .vars = "Similarity", .funs = mean) %>% 
    as.data.frame(.)
}
sub_DF$ROI  <- factor(sub_DF$ROI, levels = roi_select)
sub_DF$hemi <- ifelse(grepl("rh-", sub_DF$ROI), "R", 
                      ifelse(grepl("lh-", sub_DF$ROI), "L", "Uni"))

Visual   <- c("Inf_Temp", "Fusiform", "High-Vis", "LOC-V12", "V3", "V1+2", "V2", "V1")
Hippo    <- c("Hippocampus", "HPC-head", "HPC-body", "HPC-tail", "Hipp-CA1", "Hipp-CA2+3", "Hipp-DG+CA4", "Hipp-Sub", 
              "lh-Hipp-CA1", "rh-Hipp-CA1", "lh-Hipp-CA2+3", "rh-Hipp-CA2+3", "lh-Hipp-DG+CA4", "rh-Hipp-DG+CA4", "lh-Hipp-Sub", "rh-Hipp-Sub")
MTL      <- c("PHC", "PRC", "ERC", "lh-PHC", "rh-PHC", "lh-PRC", "rh-PRC", "lh-ERC", "rh-ERC")
rois_map <- data.frame(Raw = c(Visual, Hippo, MTL), 
                       New = c(rep("Visual", length(Visual)), 
                               rep("Hippocampal", length(Hippo)), 
                               rep("MTL", length(MTL))))

sub_DF$ROI_group <- rois_map$New[match(sub_DF$ROI, rois_map$Raw)]

if ( slow_only ) {
  sub_DF <- subset(sub_DF, Design == "slow")
} else if ( rapid_only ) {
  sub_DF <- subset(sub_DF, Design == "rapid") 
} 
if ( learner_only ) {
  sub_DF <- subset(sub_DF, Group == "L") 
}

## Output folder: ==============================================================

folder_name <- paste0(rois_name, " (", paste(cond_select, collapse = " & "), ")")
folder_name <- ifelse(slow_only, paste0(folder_name, " # slow"), folder_name)
folder_name <- ifelse(rapid_only, paste0(folder_name, " # rapid"), folder_name)
folder_name <- ifelse(learner_only, paste0(folder_name, " # learner"), folder_name)

out_dir <- file.path(data_dir, paste0("ANOVA (", runs_type, " run)"), folder_name)
if ( ! file.exists(out_dir) ) { dir.create(out_dir, recursive=TRUE) }

fig_dir <- file.path(out_dir, "Figures")
if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }

lm_fig_dir <- file.path(out_dir, "Figures (lm)")
if ( ! file.exists(lm_fig_dir) ) { dir.create(lm_fig_dir, recursive=TRUE) }

## To-do (asking input): =======================================================

pairwise.tt.only <- c(T, F)[as.integer(readline(
  "Do pairwise t-test only? ([1]: Yes [2]: No) "))]

if ( pairwise.tt.only ) { ## --- skip following many questions ---
  do.pairwise.tt <- T
  
} else {
  do.every.anova  <- c(T, F)[as.integer(readline(
    "Do all ANOVA tests? ([1]: Yes [2]: No) "))]
  
  if ( do.every.anova ) { 
    do.3way.anova <- T
    do.2way.anova <- T
    do.1way.anova <- T
    
  } else { ## specify to do which ANOVA (or none of all)
    
    if ( cond_select_idx == 1 ) {
      do.3way.anova <- c(T, F)[as.integer(readline(
        "Do 3-way ANOVA? ([1]: Yes [2]: No) "))] 
    } else {
      do.3way.anova <- F
    }
    do.2way.anova <- c(T, F)[
      as.integer(readline("Do 2-way ANOVA? ([1]: Yes [2]: No) "))] 
    
    do.1way.anova <- c(T, F)[
      as.integer(readline("Do 1-way ANOVA? ([1]: Yes [2]: No) "))]
  } 

  ## --- default settings about plotting (otherwise will stats!) ---
  plot.3way.anova    <- c(T, F)[2]
  aov3.plot.1way     <- c(T, F)[2]
  plot.2way.run.cond <- c(T, F)[2]
  plot.2way.ROI.cond <- c(T, F)[2]
  aov2.plot.1way     <- c(T, F)[2]
  
  plot.aov.figs  <- c(T, F)[as.integer(readline(
    "Plot all ANOVA figures? ([1]: Yes [2]: No) "))]
  
  if ( plot.aov.figs ) {
    aov2.plot.1way <- c(T, F)[1] ## always do it, as it doesn't hurt :)
    
    if ( cond_select_idx == 1 ) {
      plot.3way.anova    <- c(T, F)[1]
      aov3.plot.1way     <- c(T, F)[as.integer(readline(
        "Plot 3-way ANOVA with main effect of run? ([1]: Yes [2]: No) "))]
      
      plot.2way.run.cond <- c(T, F)[1]
      plot.2way.ROI.cond <- c(T, F)[1]
    } 

  } else if ( cond_select_idx == 1 ) { # perhaps not all plot, only certain plots
    
    plot.3way.anova <- c(T, F)[as.integer(readline(
      "Plot 3-way ANOVA? ([1]: Yes [2]: No) "))] 
    if ( plot.3way.anova ) {
      aov3.plot.1way <- c(T, F)[as.integer(readline(
        "Plot 3-way ANOVA with main effect of run? ([1]: Yes [2]: No) "))]
    }
    
    plot.2way.run.cond <- c(T, F)[as.integer(readline(
      "Plot 2-way ANOVA for Cond x Run interaction per ROI? ([1]: Yes [2]: No) "))]
    if ( plot.2way.run.cond ) {
      aov2.plot.1way  <- c(T, F)[1]
    }
  }

  if ( cond_select_idx == 1 ) {
    do.lm   <- c(T, F)[2]
    plot.lm <- c(T, F)[2]
    
  } else {
    do.lm   <- c(T, F)[as.integer(readline(
      "Check linear relationship between Similarity and Run? ([1]: Yes [2]: No) "))]
    
    plot.lm <- c(T, F)[as.integer(readline(
      "Plot linear relationship between Similarity and Run? ([1]: Yes [2]: No) "))]
  }
  
  do.pairwise.tt <- c(T, F)[as.integer(readline(
    "Do pair-wise t-test? ([1]: Yes [2]: No) "))]
}

## if do.pairwise.tt:
if (( cond_select_idx != 1 ) & do.pairwise.tt ) { # ----------------------------
  
  do.pairwise.for <- c("ROI", "Run")[as.integer(readline(
    "Do pair-wise t-test among? ([1]: ROIs [2]: Runs) "))]
  
  if ( do.pairwise.for == "ROI" ) { 
    r_idx <- as.integer(readline(
      "What run? [0]: AVERAGE, otherwise ?-th exposure run: "))
    focus_run <- ifelse(r_idx == "0", "AVERAGE", r_idx)
    
    PWC.name  <- paste0("Pairwise_ROI_Run.", focus_run)
    
  } else if ( do.pairwise.for == "Run" ) {
    print(roi_select)
    roi_idx <- as.integer(readline(
      "What region? [0]: AVERAGE, otherwise roi_select[index] "))
    focus_roi <- ifelse(roi_idx == 0, "AVERAGE", roi_select[roi_idx])
    
    PWC.name <- paste0("Pairwise_Run_", focus_roi)
  } 
}

if (( cond_select_idx == 1 ) & do.pairwise.tt ) { 
  
  do.pairwise.for <- c("ROI", "Run", "Cond")[
    as.integer(readline("Do pair-wise t-test among? ([1]: ROIs [2]: Runs [3]: Conditions) "))]
  
  if ( do.pairwise.for == "ROI" ) { # ------------------------------------------
    
    print(cond_list)
    c_idx <- as.integer(readline("What cond? [0]: AVERAGE, otherwise cond_list[index] "))
    focus_cond <- ifelse(c_idx == 0, "AVERAGE", cond_list[c_idx]) ###
    
    r_idx <- as.integer(readline("What run? [0]: AVERAGE, otherwise ?-th exposure run: "))
    focus_run <- ifelse(r_idx == "0", "AVERAGE", r_idx) ###
    
    PWC.name <- paste0("Pairwise_ROI__", focus_cond, "_Run.", focus_run)
    
  } else if ( do.pairwise.for == "Run" ) { # -----------------------------------
    
    print(roi_select)
    roi_id <- as.integer(readline("What region? [0]: AVERAGE, [-1] DIFF, otherwise roi_select[index] "))
    focus_roi <- ifelse(roi_id == 0, "AVERAGE", 
                        ifelse(roi_id == -1, "ROI-DIFF", 
                               roi_select[roi_id])) ###
    print(cond_list)
    c_idx <- as.integer(readline("What cond? [0]: AVERAGE, otherwise cond_list[index] "))
    focus_cond <- ifelse(c_idx == 0, "AVERAGE", cond_list[c_idx]) ###
    
    PWC.name <- paste0("Pairwise_Run__", focus_roi, "_", focus_cond)
    
  } else { # do.pairwise.for == "Cond" # ---------------------------------------
    
    print(roi_select)
    roi_id <- as.integer(readline("What region? [0]: AVERAGE, [-1] DIFF, otherwise roi_select[index] "))
    focus_roi <- ifelse(roi_id == 0, "AVERAGE", 
                        ifelse(roi_id == -1, "ROI-DIFF", 
                               roi_select[roi_id])) ###
    
    r_idx <- as.integer(readline("What run? [0]: AVERAGE, otherwise ?-th exposure run: "))
    focus_run <- ifelse(r_idx == "0", "AVERAGE", r_idx) ###
    
    PWC.name <- paste0("Pairwise_Cond__", focus_roi, "_Run.", focus_run)
  } 
}

## Plotting parameters: ========================================================

aov3.element.text.size <- 20
aov3.fig.width         <- 15
aov3.fig.height        <- 6

aov2.element.text.size <- 16
aov2.fig.width         <- 8
aov2.fig.height        <- 6

lm.text.size           <- 16
lm.fig.width           <- 8
lm.fig.height          <- 6

pwc.label.size         <- 20
if ( do.pairwise.tt ) { 
  print("Setting the size of figure for pairwise comparisons: ")
  pwc.fig.width  <- as.integer(readline("\t+ width: (usual: 6 or 8) ")) # c(6, 8)[1]
  pwc.fig.height <- as.integer(readline("\t+ height: (usual: 6) ")) # c(6, 16)[1]
}

#################################### Stats #####################################

if ( ! pairwise.tt.only ) {
  
  ## Discriptive: ==============================================================
  if ( cond_select_idx == 1 ) {
    summ_stat <- sub_DF %>% group_by(Run, ROI, Cond) %>%
      rstatix::get_summary_stats(Similarity, type = "mean_sd")

    write.csv(data.frame(summ_stat), file = file.path(out_dir, "Summary.stats.csv"), )
    
  } else {
    summ_stat <- sub_DF %>% group_by(Run, ROI) %>%
      rstatix::get_summary_stats(Similarity, type = "mean_sd")

    write.csv(data.frame(summ_stat), file = file.path(out_dir, "Summary.stats.csv"), )
    
  }

  ## Three-way ANOVA: ==========================================================
  if (( cond_select_idx == 1 ) & ( do.3way.anova | plot.3way.anova )) {
    AOV.3w.cond <- sub_DF %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, 
                          within = c(ROI, Run, Cond), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(AOV.3w.cond), 
              file = file.path(out_dir, "ANOVA.3W_ROI_x_Run_x_Cond.csv"))
  }
  
  ## AOV.3w.design:
  if ( compare_design ) {
    AOV.3w.design <- sub_DF %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, 
                          between = Design, within = c(ROI, Run), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(AOV.3w.design), 
              file = file.path(out_dir, "ANOVA.3W_ROI_x_Run_x_Design.csv"))
  }
  
  ## Two-way ANOVA: ============================================================
  if (( cond_select_idx != 1 ) & ( do.2way.anova | plot.aov.figs )) { 
    
      aov2.ROI.x.Run <- sub_DF %>% 
        rstatix::anova_test(dv = Similarity, wid = Subj, within = c(ROI, Run), data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(aov2.ROI.x.Run), 
                file = file.path(out_dir, "ANOVA.2w_ROI_x_Run.csv"))
  }

  if (( cond_select_idx == 1 ) & ( do.2way.anova )) { 
    
    aov2.ROI.x.Run <- sub_DF %>% 
      group_by(Cond) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = c(ROI, Run), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(aov2.ROI.x.Run), 
              file = file.path(out_dir, "Interaction_ROI_x_Run.csv"))
    
    aov2.ROI.x.Cond <- sub_DF %>% 
      group_by(Run) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = c(ROI, Cond), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(aov2.ROI.x.Run), 
              file = file.path(out_dir, "Interaction_ROI_x_Cond.csv"))
    
    aov2.Cond.x.Run <- sub_DF %>% 
      group_by(ROI) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = c(Cond, Run), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(aov2.ROI.x.Run), 
              file = file.path(out_dir, "Interaction_Cond_x_Run.csv"))
  }
  
  ## One-way ANOVA: ============================================================
  if (( cond_select_idx != 1 ) & ( do.1way.anova | plot.aov.figs )) {
    
    ## main effect of ROI, per Run:
    SME.roi <- sub_DF %>% group_by(Run) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = ROI, data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(SME.roi), file = file.path(out_dir, "Main.effect_ROI.csv"))
    
    ## main effect of Run, per ROI:
    SME.run <- sub_DF %>% group_by(ROI) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = Run, data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(SME.run), file = file.path(out_dir, "Main.effect_Run.csv"))
  } 
  
  if (( cond_select_idx == 1 ) & ( do.1way.anova | aov3.plot.1way | aov2.plot.1way )) {
    
    ## main effect of ROI:
    SME.roi <- sub_DF %>% group_by(Cond, Run) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = ROI, data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(SME.roi), 
              file = file.path(out_dir, "Main_effect_ROI.csv"))
    
    ## main effect of Cond:
    SME.cond <- sub_DF %>% group_by(ROI, Run) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = Cond, data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(SME.cond), 
              file = file.path(out_dir, "Main_effect_Cond.csv"))
    
    ## main effect of Run:
    SME.run <- sub_DF %>% group_by(ROI, Cond) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = Run, data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(SME.run), 
              file = file.path(out_dir, "Main_effect_Run.csv"))
  }
  
  ## linear regression: ========================================================
  if (( cond_select_idx != 1 ) & ( do.lm )) { 
    ###
    slope_per_subj <- sub_DF %>% group_by(ROI, Subj) %>% 
      do(broom::tidy(lm(formula = Similarity ~ Run, data = .))) %>% 
      subset(., term == "Run") %>% 
      as.data.frame(.)
    
    write.csv(slope_per_subj, file.path(out_dir, "Slope_per_Subj.csv"))
    
    ###
    slope_roi_means <- slope_per_subj %>% group_by(ROI) %>% 
      summarise_at("estimate", .funs = mean)

    write.csv(slope_roi_means, file.path(out_dir, "Slope_ROI_means.csv"))
    
    ###
    AOV.slope <- slope_per_subj %>%
      rstatix::anova_test(dv = estimate, wid = Subj, within = ROI, data=.) %>%
      get_anova_table(.)
    
    write.csv(AOV.slope, file.path(out_dir, "Slope_ANOVA.1w.csv"))
    
    ###
    PWC.slope <- slope_per_subj %>% 
      rstatix::pairwise_t_test(estimate ~ ROI, paired = TRUE, p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(PWC.slope, file.path(out_dir, "Slope_ROI_pairwise.csv"))
  }
}

## Pair-wise t-test: ===========================================================
if (( cond_select_idx != 1 ) & do.pairwise.tt ) {
  
  ## compare among ROIs:
  if ( do.pairwise.for == "ROI" ) { 
    
    if ( focus_run == "AVERAGE" ) {
      PWC.data <- sub_DF
    } else { 
      PWC.data <- subset(sub_DF, Run == focus_run) }
    
    if ( length(unique(PWC.data$hemi)) != 2 ) {
      PWC.data$ROI <- reorder(PWC.data$ROI, PWC.data$Similarity, FUN = mean, decreasing = T)
    } else {
      PWC.data$ROI <- factor(PWC.data$ROI, levels = roi_select)
    }
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Similarity ~ ROI, paired = TRUE, p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
  ## compare among Runs:
  if ( do.pairwise.for == "Run" ) {
      
    if ( focus_roi == "AVERAGE" ) { 
      PWC.data <- sub_DF
    } else {
      PWC.data <- subset(sub_DF, ROI == focus_roi) }
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Similarity ~ Run, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
}

if (( cond_select_idx == 1 ) &  do.pairwise.tt ) {
  
  ## compare among ROIs: -------------------------------------------------------
  if ( do.pairwise.for == "ROI" ) { 
    
    if ( focus_cond == "AVERAGE" & focus_run == "AVERAGE" ) {
      PWC.data <- sub_DF
      
    } else if ( focus_cond == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, Run == focus_run) 
      
    } else if ( focus_run == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, Cond == focus_cond) 
      
    } else { # default
      PWC.data <- subset(sub_DF, Cond == focus_cond & Run == focus_run) }
    
    if ( length(unique(PWC.data$hemi)) != 2 ) {
      PWC.data$ROI <- reorder(PWC.data$ROI, PWC.data$Similarity, FUN = mean, decreasing = T)
    } else {
      PWC.data$ROI <- factor(PWC.data$ROI, levels = roi_select)
    }
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Similarity ~ ROI, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
  ## compare among Runs: -------------------------------------------------------
  if ( do.pairwise.for == "Run" ) {
    
    if ( focus_roi == "ROI-DIFF" ) { 
      sub_DF_1 <- subset(sub_DF, ROI == roi_select[1])
      sub_DF_2 <- subset(sub_DF, ROI == roi_select[2])
      sub_DF_comp      <- data.frame("Similarity" = sub_DF_1$Similarity - sub_DF_2$Similarity)
      sub_DF_comp$ROI  <- paste(roi_select, collapse = "-")
      sub_DF_comp$Run  <- sub_DF_1$Run
      sub_DF_comp$Cond <- sub_DF_1$Cond
      
      if ( focus_cond == "AVERAGE" ) {
        PWC.data <- sub_DF_comp
        
      } else {
        PWC.data <- subset(sub_DF_comp, Cond == focus_cond)
      }
      
    } else if ( focus_cond == "AVERAGE" & focus_roi == "AVERAGE" ) { 
      PWC.data <- sub_DF
      
    } else if ( focus_cond == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, ROI == focus_roi) 
      
    } else if ( focus_roi == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, Cond == focus_cond) 
      
    } else { # default
      PWC.data <- subset(sub_DF, Cond == focus_cond & ROI == focus_roi) }
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Similarity ~ Run, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
  ## compare among Conds: ------------------------------------------------------
  if ( do.pairwise.for == "Cond" ) {
    
    if ( focus_roi == "ROI-DIFF" ) { 
      sub_DF_1 <- subset(sub_DF, ROI == roi_select[1])
      sub_DF_2 <- subset(sub_DF, ROI == roi_select[2])
      sub_DF_comp      <- data.frame("Similarity" = sub_DF_1$Similarity - sub_DF_2$Similarity)
      sub_DF_comp$ROI  <- paste(roi_select, collapse = "-")
      sub_DF_comp$Run  <- sub_DF_1$Run
      sub_DF_comp$Cond <- sub_DF_1$Cond
      
      if ( focus_run == "AVERAGE" ) {
        PWC.data <- sub_DF_comp
        
      } else {
        PWC.data <- subset(sub_DF_comp, Run == focus_run)
      } 
    }
    
    if ( focus_run == "AVERAGE" & focus_roi == "AVERAGE" ) { 
      PWC.data <- sub_DF
      
    } else if ( focus_run == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, ROI == focus_roi) 
      
    } else if ( focus_roi == "AVERAGE" ) { 
      PWC.data <- subset(sub_DF, Run == focus_run) 
      
    } else { # default
      PWC.data <- subset(sub_DF, Run == focus_run & ROI == focus_roi) }
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Similarity ~ Cond, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
}

#################################### Plots #####################################
if (( cond_select_idx != 1 ) & ( ! pairwise.tt.only )) {
  
  ## 2-way (Run x ROI) + main effect of ROI (per Run): =========================
  if ( plot.aov.figs ) {
    
    sub_DF$ROI <- reorder(sub_DF$ROI, sub_DF$Similarity, 
                          FUN = mean, decreasing = T)
    
    P <- ggerrorplot(sub_DF, x = "Run", y = "Similarity", 
                     color = "ROI", 
                     palette = ifelse(rois_paired, "Paired", "ColorBrewer"), 
                     desc_stat = "mean_se", 
                     position = position_dodge(.8), 
                     size = 1, alpha = .5, 
                     short.panel.labs = FALSE) + 
      
      stat_summary(aes(group = ROI, color = ROI), 
                   fun = mean, geom = "line", 
                   position = position_dodge(width = .8), linewidth = 1) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5)
    
    ## main effect of ROI (per Run):
    if ( aov2.plot.1way ) {
      P <- P + 
        geom_text(data = SME.roi, 
                  aes(x = Run, y = max(summ_stat$mean) + .01, 
                      label = ifelse(p < .001, "p < .001**", 
                                     ifelse(p < .05, paste0("p = ", round(p, 3), "*"), ""))), 
                  size = 5, angle = 30, fontface = "italic", show.legend = FALSE)
    }
    
    P <- P + 
      coord_cartesian(ylim = c(min(summ_stat$mean) - .01, 
                               max(summ_stat$mean) + .02)) + 
      
      labs(x = "Exposure runs", y = "Stability", 
           # y = paste0("1 - ", meas, "-based distance"), 
           subtitle = get_test_label(aov2.ROI.x.Run, detailed = TRUE)) + 
      
      theme(text = element_text(size = aov2.element.text.size)) 
    
    ###
    aov2.fig.name <- paste0("ANOVA.2w_Cond_x_Run.jpg")
    
    ggsave(file = file.path(fig_dir, aov2.fig.name), 
           width = aov3.fig.width, height = aov3.fig.height, dpi = 200)  
  } 
  
  ## Linear fit (between Similarity & Run, per ROI): ===========================
  if ( plot.lm ) {
    
    for ( roi in roi_select ) { 
      run_data <- subset(sub_DF, ROI == roi)
      
      ggplot(run_data, aes(x = Run, y = Similarity)) + 
        
        stat_summary(fun = mean, geom = "point", 
                     color = "red", size = 3, alpha = .5) + 
        
        stat_summary(aes(group = 1), fun = mean, geom = "line", 
                     color = "red", linewidth =.5, alpha =.5, linetype = "dashed") + 
        
        stat_smooth(method = lm, formula = y ~ x) + 
        
        stat_summary(fun.data = mean_se, geom = "errorbar", 
                     color = "red", width = 0.1) + 
        
        stat_cor(label.x.npc = "left",
                 label.y = min(summ_stat$mean) - .01,
                 hjust = "inward", vjust = "inward", 
                 color = "black", size = 5) +
        
        stat_regline_equation(label.x.npc = "right",
                              label.y = max(summ_stat$mean) + .01,
                              hjust = "inward", vjust = "inward", 
                              color = "blue", size = 5) + 
        
        coord_cartesian(ylim = c(min(summ_stat$mean) - .01,
                                 max(summ_stat$mean) + .01)) +
        
        labs(x = "Exposure runs", y = "Similarity", title = roi) + 
        
        theme(text = element_text(size = lm.text.size)) 
      
      ggsave(file = file.path(lm_fig_dir, paste0(roi, ".jpg")), 
             width = lm.fig.width, height = lm.fig.height, dpi = 200) 
    } 
  }
}

if (( cond_select_idx == 1 ) & ( ! pairwise.tt.only )) {
  
  ## 3-way (Run x ROI X Cond) + main effect of Run: ============================
  if ( plot.3way.anova ) {
    
    sub_DF$ROI <- reorder(sub_DF$ROI, sub_DF$Similarity, FUN = mean, decreasing = T)
    
    P <- ggerrorplot(sub_DF, x = "Run", y = "Similarity", facet.by = "Cond", 
                     color = "ROI", 
                     desc_stat = "mean_se", 
                     position = position_dodge(width = .8), 
                     # size = 1, alpha = .5,
                     short.panel.labs = FALSE) + 
      
      stat_summary(aes(group = ROI, color = ROI), fun = mean, geom = "line", 
                   position = position_dodge(width = .8), 
                   linewidth = 1, alpha = .8) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5)
    
    ## one-way ANOVA of Run: -----------------------------------------------------
    if ( aov3.plot.1way ) {
      # y.step <- sd(summ_stat$mean)
      y.step <- .02
      
      if ( length(roi_select) == 2 ) {
        P <- P + 
          stat_anova_test(aes(group = ROI, color = ROI), group.by = "legend.var", 
                          method = "one_way_repeated", wid = "Subj", 
                          label = "italic(p) = {p.format} {p.signif}",
                          label.y = c(max(summ_stat$mean) + y.step, 
                                      min(summ_stat$mean) - y.step), 
                          hjust = -.1, size = 5.5)
        
      } else { # more than two ROI
        P <- P +
          stat_anova_test(aes(group = ROI, color = ROI), group.by = "legend.var",
                          method = "one_way_repeated", wid = "Subj",
                          label = "italic(p) = {p.format} {p.signif}", 
                          label.y = seq(from = max(summ_stat$mean) + y.step*length(roi_select), 
                                        to = max(summ_stat$mean) + y.step, 
                                        length.out = length(roi_select)), 
                          hjust = -.1, vjust = "inward", size = 5.5) 
      }
    } # --------------------------------------------------------------------------
    
    P <- P + 
      labs(x ="Exposure runs", y = "Stability", 
           subtitle = get_test_label(AOV.3w.cond, detailed = TRUE)) + 
      
      theme(text = element_text(size = aov3.element.text.size))
    
    aov3.fig.name <- ifelse(aov3.plot.1way, 
                            "ANOVA.3W_ROI_x_Run_x_Cond (with stats).jpg", 
                            "ANOVA.3W_ROI_x_Run_x_Cond.jpg")
    
    if ( length(roi_select) > 5 ) {
      P <- P + theme(legend.position = "right")
      
      ggsave(P, file = file.path(fig_dir, aov3.fig.name), 
             width = 15, height = 6, dpi = 200)
             # width = aov3.fig.width, height = aov3.fig.height, dpi = 200)
    } else {
      P <- P + theme(legend.position = "top")
      
      ggsave(P, file = file.path(fig_dir, aov3.fig.name), 
             width = 10, height = 6, dpi = 200)
    }
  }
  
  ## 2-way (Run X Cond) + main effect of Cond (per ROI): =======================
  if ( plot.2way.run.cond ) {
    
    for ( roi in c(roi_select, "AVERAGE") ) { 
      
      if ( roi == "AVERAGE" ) {
        roi_data <- sub_DF %>% 
          group_by(Run, Cond, Subj) %>% 
          summarise_at(., .vars = "Similarity", .funs = mean) %>% 
          as.data.frame(.)
        
        roi_summ <- summ_stat 
        
        roi_smec <- roi_data %>% 
          group_by(Run) %>% 
          rstatix::anova_test(dv = Similarity, wid = Subj, within = Cond, data=.) %>% 
          get_anova_table(.)
          
      } else {
        roi_data <- subset(sub_DF, ROI == roi)
        roi_summ <- subset(summ_stat, ROI == roi) 
        roi_smec <- subset(SME.cond, ROI == roi)
      }

      AOV.2w <- roi_data %>% 
        rstatix::anova_test(dv = Similarity, wid = Subj, 
                            within = c(Cond, Run), data=.) %>% 
        get_anova_table(.)
      
      P <- ggerrorplot(roi_data, x = "Run", y = "Similarity", color = "Cond", 
                       palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                       desc_stat = "mean_se", 
                       position = position_dodge(.8), 
                       size = 1, alpha = .8, 
                       short.panel.labs = FALSE) + 
        
        stat_summary(aes(group = Cond, color = Cond), 
                     fun = mean, geom = "line", 
                     position = position_dodge(width = .8), linewidth = 1) + 
        
        geom_vline(xintercept = seq(1.5, 7.5), 
                   linetype = "dashed", color = "gray", alpha = .5)
      
      ## one-way ANOVA of Cond: 
      if ( aov2.plot.1way ) {
        P <- P + 
          geom_text(data = roi_smec, 
                    aes(x = Run, y = max(roi_summ$mean) + .01, 
                        label = ifelse(p < .001, "p < .001**", 
                                       ifelse(p < .05, paste0("p = ", round(p, 3), "*"), 
                                              ""))), 
                    size = 4, angle = 15, fontface = "bold", show.legend = FALSE)
      }
      
      P <- P + 
        coord_cartesian(ylim = c(min(roi_summ$mean) - .01, 
                                 max(roi_summ$mean) + .01)) + 
        
        labs(x = "Exposure runs", y = "Stability", title = roi, 
             subtitle = get_test_label(AOV.2w, detailed = TRUE))
      
      ###
      aov2.fig.name <- paste0("Interaction_Cond_x_Run__", roi, ".jpg")

      if ( roi == "AVERAGE" ) {
        P <- P + 
          theme(text = element_text(28), 
                legend.position = "top")
        
        ggsave(file = file.path(fig_dir, aov2.fig.name), width = 6, height = 6, dpi = 200) 
        
      } else {
        P <- P + 
          theme(text = element_text(size = aov2.element.text.size), 
                legend.position = "right")
        
        ggsave(file = file.path(fig_dir, aov2.fig.name), 
               width = aov2.fig.width, height = aov2.fig.height, dpi = 200) 
      }
    }
  }
  
  ## 2-way (ROI X Cond) + main effect of Cond (per ROI): =======================
  if ( plot.2way.ROI.cond ) { 
    
    run_avg_DF <- sub_DF %>% 
      group_by(ROI, Cond, Subj) %>% 
      summarise_at(., .vars = "Similarity", .funs = mean) %>% 
      as.data.frame(.)
    
    cond_smec <- run_avg_DF %>% 
      group_by(ROI) %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, within = Cond, data=.) %>% 
      get_anova_table(.)
    
    AOV.2w <- run_avg_DF %>% 
      rstatix::anova_test(dv = Similarity, wid = Subj, 
                          within = c(Cond, ROI), data=.) %>% 
      get_anova_table(.)
    
    P <- ggbarplot(run_avg_DF, x = "ROI", y = "Similarity", 
                   fill = "Cond", 
                   palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                   add = "mean_se", 
                   position = position_dodge(.8), 
                   short.panel.labs = FALSE) + 
      
      geom_text(data = cond_smec, 
                aes(x = ROI, y = max(summ_stat$mean) + .01, 
                    label = ifelse(p < .001, "p < .001**", 
                                   ifelse(p < .05, paste0("p = ", round(p, 3), "*"), 
                                          ""))), 
                size = 4, angle = 30, fontface = "bold", show.legend = FALSE) + 
      
      coord_cartesian(ylim = c(min(summ_stat$mean) - .01, 
                               max(summ_stat$mean) + .01)) + 
      
      labs(x = NULL, y = "Similarity", title = "Average across runs", 
           subtitle = get_test_label(AOV.2w, detailed = TRUE)) + 
      
      theme(text = element_text(28), legend.position = "right", 
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    
    ###
    aov2.fig.name <- paste0("Interaction_ROI_x_Cond.jpg")
    
    ggsave(P, file = file.path(fig_dir, aov2.fig.name), 
           width = 6, height = 6, dpi = 200) 
    
    
  }
}

## specified pair-wise t-tests: ================================================
if (( cond_select_idx != 1 ) & do.pairwise.tt ) {
  
  PWC.plot <- PWC %>% 
    add_xy_position(x = do.pairwise.for, fun = "mean_se")
  
  if ( do.pairwise.for == "ROI" ) { # ------------------------------------------
    
    if ( length(unique(PWC.data$hemi)) == 2 ) {
      P <- ggbarplot(PWC.data, 
                     aes(color = ROI_group), 
                     x = do.pairwise.for, 
                     y = "Similarity", 
                     fill = "hemi", color = "ROI_group", 
                     add = "mean_se", 
                     short.panel.labs = FALSE) 
    } else {
      P <- ggbarplot(PWC.data, 
                     x = do.pairwise.for, 
                     y = "Similarity", 
                     fill = "ROI", 
                     # fill = "ROI_group", 
                     add = "mean_se", 
                     short.panel.labs = FALSE) 
    }
    
    P <- P + 
      labs(x = NULL) + 
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    
    fig.title <- paste0("Run stage: ", focus_run) ###
    
  } else if ( do.pairwise.for == "Run" ) { # -----------------------------------
    
    dat_mean <- PWC.data %>% group_by(Run) %>% 
      summarise_at("Similarity", .funs = mean) 
    
    dat_sign <- data.frame(
      Run = unique(PWC.data$Run), 
      Y.sign = ifelse(dat_mean$Similarity > 0, "Pos", "Neg"))
    
    PWC.data$Y.sign <- dat_sign$Y.sign[match(PWC.data$Run, dat_sign$Run)]
    PWC.data$Y.sign <- factor(PWC.data$Y.sign, levels = c("Pos", "Neg"))
    
    P <- ggbarplot(PWC.data, 
                   x = do.pairwise.for, 
                   y = "Similarity", 
                   fill = "Y.sign", 
                   palette = c("red", "blue"), 
                   alpha = .5,
                   add = "mean_se", 
                   short.panel.labs = FALSE) + 
      
      stat_summary(fun = mean, geom ="point", 
                   color = "black", size = 3, alpha = .5) +
      
      stat_summary(aes(group = 1), fun = mean, geom = "line",
                   color = "black", linewidth = .5, linetype = "dashed") + 
      
      labs(x = "Exposure runs")
    
    fig.title <- paste0(focus_roi) ###
    
  } 
  
  P <- P + 
    stat_pvalue_manual(PWC.plot, 
                       hide.ns = T, tip.length = .005, label.size = 5.5) + 
    
    labs(y = "Similarity", title = fig.title, 
         caption = get_pwc_label(PWC)) + 
    
    theme(text = element_text(size = 16))
  
  ggsave(file = file.path(fig_dir, paste0(PWC.name, ".jpg")),
         width = pwc.fig.width, height = pwc.fig.height, dpi = 200)
}

if (( cond_select_idx == 1 ) & do.pairwise.tt ) {
  
  if ( length(unique(PWC.data$hemi)) != 2 & do.pairwise.for == "ROI" ) {
    PWC.data$ROI <- reorder(PWC.data$ROI, PWC.data$Similarity, FUN = mean, decreasing = T)
  } else {
    PWC.data$ROI <- factor(PWC.data$ROI, levels = roi_select)
  }
  
  PWC.plot <- PWC %>% add_xy_position(x = do.pairwise.for, fun = "mean_se")
  
  if ( do.pairwise.for == "ROI" ) { # ------------------------------------------

    if ( length(unique(PWC.data$hemi)) == 2 ) {
      P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Similarity", 
                     fill = "hemi", color = "ROI_group", 
                     add = "mean_se", 
                     short.panel.labs = FALSE) 
    } else {
      P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Similarity", 
                     fill = "ROI_group", 
                     add = "mean_se", 
                     short.panel.labs = FALSE) 
    }
    
    P <- P + labs(x = NULL) + 
      
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    
    fig.title <- paste0(focus_cond, ", Run ", focus_run) ###
    
  } else if ( do.pairwise.for == "Run" ) { # -----------------------------------
    
    dat_mean <- PWC.data %>% group_by(Run) %>% summarise_at("Similarity", .funs = mean) 
    dat_sign <- data.frame(Run = unique(PWC.data$Run), 
                           Y.sign = ifelse(dat_mean$Similarity > 0, "Pos", "Neg"))
    PWC.data$Y.sign <- dat_sign$Y.sign[match(PWC.data$Run, dat_sign$Run)]
    PWC.data$Y.sign <- factor(PWC.data$Y.sign, levels = c("Pos", "Neg"))
    
    P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Similarity", 
                   fill = "Y.sign", palette = c("red", "blue"), alpha = .5,
                   add = "mean_se", 
                   short.panel.labs = FALSE) + 
      
      stat_summary(fun = mean, geom ="point", 
                   color = "black", size = 3, alpha = .5) +
      
      stat_summary(aes(group = 1), fun = mean, geom = "line",
                   color = "black", linewidth = .5, linetype = "dashed") + 

      labs(x = "Exposure runs")
    
    fig.title <- paste0(focus_roi, ", ", focus_cond) ###
    
  } else { # do.pairwise.for == "Cond" # ---------------------------------------
    
    dat_mean <- PWC.data %>% group_by(Cond) %>% summarise_at("Similarity", .funs = mean) 
    dat_sign <- data.frame(Cond = cond_list, 
                           Y.sign = ifelse(dat_mean$Similarity > 0, "Pos", "Neg"))
    PWC.data$Y.sign <- dat_sign$Y.sign[match(PWC.data$Cond, dat_sign$Cond)]
    PWC.data$Y.sign <- factor(PWC.data$Y.sign, levels = c("Pos", "Neg"))
    
    P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Similarity", 
                   fill = "Y.sign", palette = c("red", "blue"), alpha = .5, 
                   add = "mean_se", 
                   short.panel.labs = FALSE) + 
      
      labs(x = NULL)
    
    fig.title <- paste0(focus_roi, ", Run ", focus_run) ###
  }
  
  P <- P + 
    stat_pvalue_manual(PWC.plot, hide.ns = T, tip.length = .005, label.size = 5.5) + 
    
    labs(y = "Stability", title = fig.title, caption = get_pwc_label(PWC)) + 
    
    theme(text = element_text(size = 16))
  
  ggsave(file = file.path(fig_dir, paste0(PWC.name, ".jpg")),
         width = pwc.fig.width, height = pwc.fig.height, dpi = 200)
}