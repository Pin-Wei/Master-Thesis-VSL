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

fig_dir <- file.path(out_dir, "Figures")
if ( ! file.exists(fig_dir) ) { dir.create(fig_dir, recursive=TRUE) }

lm_fig_dir <- file.path(out_dir, "Figures (lm)")
if ( ! file.exists(lm_fig_dir) ) { dir.create(lm_fig_dir, recursive=TRUE) }

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

sub_DF           <- subset(all_DF, ROI %in% roi_select & Cond %in% cond_list)
sub_DF$ROI       <- factor(sub_DF$ROI, levels = roi_select)
sub_DF$hemi      <- ifelse(grepl("rh-", sub_DF$ROI), "R", 
                           ifelse(grepl("lh-", sub_DF$ROI), "L", "Uni"))
sub_DF$ROI_group <- rois_map$New[match(sub_DF$ROI, rois_map$Raw)]
# sub_DF$Y.sign    <- ifelse(sub_DF$Y > 0, "Pos", "Neg")

if ( learner_only ) { sub_DF <- subset(sub_DF, Group == "L") }

data_summ <- sub_DF %>% group_by(ROI, Cond, Run) %>% 
  summarise_at("Y", list(mean = ~ mean(., na.rm = TRUE), 
                         sd = ~ sd(., na.rm = TRUE)))

## To-do (asking input): =======================================================

pairwise.tt.only <- c(T, F)[
  as.integer(readline("Do pairwise t-test only? ([1]: Yes [2]: No) "))] 

if ( ! pairwise.tt.only ) { 
  
  check.assumptions <- F
  # check.assumptions <- c(T, F)[
  #   as.integer(readline("Check assumptions? ([1]: Yes [2]: No) "))]
  
  do.every.anova  <- c(T, F)[
    as.integer(readline("Do all ANOVA tests? ([1]: Yes [2]: No) "))]
  
  if ( do.every.anova ) { # ----------------------------------------------------
    do.3way.anova <- T
    do.2way.anova <- T
    do.2way       <- 0
    do.1way.anova <- T
    do.1way       <- 0
    
  } else {
    do.3way.anova <- c(T, F)[
      as.integer(readline("Do 3-way ANOVA? ([1]: Yes [2]: No) "))]
    
    do.2way.anova <- c(T, F)[
      as.integer(readline("Do 2-way ANOVA? ([1]: Yes [2]: No) "))] 
    
    if ( do.2way.anova ) {
      do.2way <- as.integer(readline("See interaction between? \
        [0]: Everything                       \
        [1]: Cond x Run interaction (per ROI) \
        [2]: ROI x Run interaction (per Cond) \
        [3]: ROI x Cond interaction (per Run) ")) 
    } else { 
      do.2way <- "Nope" 
    }
    
    do.1way.anova <- c(T, F)[
      as.integer(readline("Do 1-way ANOVA? ([1]: Yes [2]: No) "))]
    
    if ( do.1way.anova ) {
      do.1way <- as.integer(readline("See main effect of? \
        [0]: Everything           \
        [1]: ROI (per Cond x Run) \
        [2]: Cond (per ROI x Run) \
        [3]: Run (per ROI x Cond) ")) 
    } else { 
      do.1way <- "Nope" 
    } 
  }
  
  plot.main.figs  <- c(T, F)[
    as.integer(readline("Plot all main figures? ([1]: Yes [2]: No) "))]  
  
  if ( plot.main.figs ) { # ----------------------------------------------------
    plot.3way.anova     <- T 
    aov3.plot.1way.run  <- c(T, F)[1]
    plot.2way.anova     <- T
    aov2.plot.fixed.y   <- c(T, F)[2]
    aov2.plot.1way.cond <- T
    
  } else { 
    plot.3way.anova <- c(T, F)[
      as.integer(readline("Plot 3-way ANOVA? ([1]: Yes [2]: No) "))] 
    
    if ( plot.3way.anova ) {
      aov3.plot.1way.run <- c(T, F)[
        as.integer(readline("Plot 3-way ANOVA with main effect of run? ([1]: Yes [2]: No) "))]
    }
    
    plot.2way.anova <- c(T, F)[
      as.integer(readline("Plot 2-way ANOVA for Cond x Run interaction per ROI? ([1]: Yes [2]: No) "))] 
    
    if ( plot.2way.anova ) {
      aov2.plot.fixed.y <- c(T, F)[
        as.integer(readline("Plot 2-way ANOVA with fixed y scale? ([1]: Yes [2]: No) "))]

      aov2.plot.1way.cond <- c(T, F)[
        as.integer(readline("Plot 2-way ANOVA with main effect of cond? ([1]: Yes [2]: No) "))]
      }
  }

  do.lm.y.run <- c(T, F)[
    as.integer(readline("Check linear relationship between Y and Run? ([1]: Yes [2]: No) "))]

  plot.lm.y.run <- c(T, F)[
    as.integer(readline("Plot linear relationship between Y and Run? ([1]: Yes [2]: No) "))]
  
  do.pairwise.tt <- c(T, F)[
      as.integer(readline("Do pair-wise t-test? ([1]: Yes [2]: No) "))]
  
} else { do.pairwise.tt <- T } # <-- pairwise.tt.only

if ( do.pairwise.tt ) { 
  
  do.pairwise.for <- c("ROI", "Run", "Cond")[
    as.integer(readline("Do pair-wise t-test among? ([1]: ROIs [2]: Runs [3]: Conditions) "))]
  
  if ( do.pairwise.for == "ROI" ) { # ------------------------------------------
    
    print(cond_list)
    c_idx <- as.integer(readline("What cond? [0]: AVERAGE, otherwise cond_list[index] "))
    focus_cond <- ifelse(c_idx == 0, "AVERAGE", cond_list[c_idx]) ###
    
    r_idx <- readline("What run? [0]: AVERAGE, otherwise run-0[?] ")
    focus_run <- ifelse(r_idx == "0", "AVERAGE", paste0("run-0", r_idx)) ###
    
    PWC.name <- paste0("Pairwise_ROI__", focus_cond, "_", focus_run)
    
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
    
    r_idx <- readline("What run? [0]: AVERAGE, otherwise run-0[?] ")
    focus_run <- ifelse(r_idx == "0", "AVERAGE", paste0("run-0", r_idx)) ###
    
    PWC.name <- paste0("Pairwise_Cond__", focus_roi, "_", focus_run)
  } 
}

## Plotting parameters: ========================================================

# change.run.labels <- c("run-02" = "1", 
#                        "run-03" = "2", 
#                        "run-04" = "3", 
#                        "run-05" = "4", 
#                        "run-06" = "5", 
#                        "run-07" = "6", 
#                        "run-08" = "7", 
#                        "run-09" = "8")

# aov3.label.size        <- 20
aov3.element.text.size <- 20
aov3.fig.width         <- 10
aov3.fig.height        <- 6

# aov2.label.size        <- 20
aov2.element.text.size <- 16
aov2.fig.width         <- 8
aov2.fig.height        <- 6

lm.text.size           <- 16
lm.fig.width           <- 8
lm.fig.height          <- 6

pwc.label.size         <- 20
if ( do.pairwise.tt ) { 
  if ( do.pairwise.for == "Run" ) { 
    pwc.fig.width  <- 8
    pwc.fig.height <- 6
    
  } else if ( do.pairwise.for == "Cond" ) {
    pwc.fig.width  <- 4
    pwc.fig.height <- 6
    
  } else { # ROI
    print("Setting the size of figure for pairwise comparisons: ")
    pwc.fig.width  <- as.integer(readline("\t+ width: (usual: 6 or 8) ")) # c(6, 8)[1]
    pwc.fig.height <- as.integer(readline("\t+ height: (usual: 6) ")) # c(6, 16)[1]
  }
}

#################################### Stats #####################################

if ( ! pairwise.tt.only ) {
  
  ## Check assumptions: ========================================================
  if ( check.assumptions ) {
    
    Outliers <- sub_DF %>% group_by(Cond, Run, ROI) %>% 
      rstatix::identify_outliers(Y)
    write.csv(data.frame(Outliers), file = file.path(out_dir, "Outliers.csv"))
    
    Normality <- sub_DF %>% group_by(Cond, Run, ROI) %>% 
      rstatix::shapiro_test(Y) 
    write.csv(data.frame(Normality), file = file.path(out_dir, "Norm_Shapiro.csv"))
    
    ggpubr::ggqqplot(sub_DF, "Y", ggtheme = theme_bw()) + 
      facet_grid(Cond + ROI ~ Run, labeller = "label_both")
    
    ggsave(file = file.path(out_dir, "Normality.jpg"), 
           width = 10, height = 10, dpi = 200) 
  }
  
  ## Three-way Within-subjects ANOVA: ==========================================
  if ( do.3way.anova | plot.3way.anova | plot.main.figs ) { 
    
    AOV.3w <- sub_DF %>% 
      rstatix::anova_test(dv = Y, wid = Subj, within = c(Cond, Run, ROI), data=.) %>% 
      get_anova_table(.)
    
    write.csv(data.frame(AOV.3w), file = file.path(out_dir, "3W_ws_ANOVA.csv"))
  } 
  
  ## Two-way ANOVA: ============================================================
  if ( do.2way.anova ) { 
    
    ## Cond x Run interaction: ---------------------------------------------------
    if ( do.2way == 1 | do.2way == 0 ) { 
      
      AOV.2w <- sub_DF %>% group_by(ROI) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = c(Cond, Run), data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(AOV.2w), 
                file = file.path(out_dir, "Interaction_Cond_x_Run.csv")) }
    
    ## ROI x Run interaction: ----------------------------------------------------
    if ( do.2way == 2 | do.2way == 0 ) { 
      
      AOV.2w <- sub_DF %>% group_by(Cond) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = c(ROI, Run), data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(AOV.2w), 
                file = file.path(out_dir, "Interaction_ROI_x_Run.csv")) }
    
    ## ROI x Cond interaction: ---------------------------------------------------
    if ( do.2way == 3 | do.2way == 0 ) { 
      
      AOV.2w <- sub_DF %>% group_by(Run) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = c(ROI, Cond), data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(AOV.2w), 
                file = file.path(out_dir, "Interaction_ROI_x_Cond.csv")) }
    
  }
  
  ## One-way ANOVA: ============================================================
  if ( do.1way.anova | plot.2way.anova | plot.main.figs ) {
    
    ## main effect of ROI: -------------------------------------------------------
    if ( do.1way == 1 | do.1way == 0 ) { 
      
      SME.roi <- sub_DF %>% group_by(Cond, Run) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = ROI, data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(SME.roi), 
                file = file.path(out_dir, "Main_effect_ROI.csv")) }
    
    ## main effect of Cond: ------------------------------------------------------
    if ( do.1way == 2 | do.1way == 0 | plot.2way.anova | plot.main.figs ) { 
      
      SME.cond <- sub_DF %>% group_by(ROI, Run) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = Cond, data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(SME.cond), 
                file = file.path(out_dir, "Main_effect_Cond.csv")) }
    
    ## main effect of Run: -------------------------------------------------------
    if ( do.1way == 3 | do.1way == 0 ) { 
      
      SME.run <- sub_DF %>% group_by(ROI, Cond) %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = Run, data=.) %>% 
        get_anova_table(.)
      
      write.csv(data.frame(SME.run), 
                file = file.path(out_dir, "Main_effect_Run.csv")) }
  } 
  
  ## linear regression: ========================================================
  if ( do.lm.y.run | plot.lm.y.run ) { 
    
    lm_DF     <- sub_DF
    lm_DF$Run <- as.integer(gsub("run-", "", sub_DF$Run))
    
    fit_out_1 <- lm_DF %>% group_by(ROI, Cond) %>% 
      do(broom::tidy(lm(formula = Y ~ Run, data = .))) 
    
    fit_out_2 <- lm_DF %>% group_by(ROI) %>% 
      do(broom::tidy(lm(formula = Y ~ Run, data = .))) 
    fit_out_2$Cond <- "overall"
    
    fit_out <- rbind(fit_out_1, fit_out_2)
    write.csv(fit_out, file.path(out_dir, "Linear_fit_Run_results.csv"))
    
    fit_goodness_1 <- lm_DF %>% group_by(ROI, Cond) %>% 
      do(broom::glance(lm(formula = Y ~ Run, data = .))) 
    
    fit_goodness_2 <- lm_DF %>% group_by(ROI) %>% 
      do(broom::glance(lm(formula = Y ~ Run, data = .)))
    fit_goodness_2$Cond <- "overall"
    
    fit_goodness <- rbind(fit_goodness_1, fit_goodness_2)
    write.csv(fit_goodness, file.path(out_dir, "Linear_fit_Run_goodness.csv"))
  }
}

## Pair-wise t-test: ===========================================================
if ( do.pairwise.tt ) {
  
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
    
    PWC <- PWC.data %>%
      rstatix::pairwise_t_test(Y ~ ROI, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
  ## compare among Runs: -------------------------------------------------------
  if ( do.pairwise.for == "Run" ) {
    
    if ( focus_roi == "ROI-DIFF" ) { 
      sub_DF_1 <- subset(sub_DF, ROI == roi_select[1])
      sub_DF_2 <- subset(sub_DF, ROI == roi_select[2])
      sub_DF_comp      <- data.frame("Y" = sub_DF_1$Y - sub_DF_2$Y)
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
      rstatix::pairwise_t_test(Y ~ Run, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
  ## compare among Conds: ------------------------------------------------------
  if ( do.pairwise.for == "Cond" ) {
    
    if ( focus_roi == "ROI-DIFF" ) { 
      sub_DF_1 <- subset(sub_DF, ROI == roi_select[1])
      sub_DF_2 <- subset(sub_DF, ROI == roi_select[2])
      sub_DF_comp      <- data.frame("Y" = sub_DF_1$Y - sub_DF_2$Y)
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
      rstatix::pairwise_t_test(Y ~ Cond, paired = TRUE, 
                               p.adjust.method = pwc.adj.method) %>%
      dplyr::select(., !c(statistic, df, p)) 
    
    write.csv(data.frame(PWC), file = file.path(out_dir, paste0(PWC.name, ".csv")))
  }
}

#################################### Plots #####################################
if ( ! pairwise.tt.only ) {
  
  ## 3-way (at title) + main effect of Run: ======================================
  if ( plot.3way.anova | plot.main.figs ) {
    
    sub_DF$ROI <- reorder(sub_DF$ROI, sub_DF$Y, FUN = mean, decreasing = T)
    
    P <- ggerrorplot(sub_DF, x = "Run", y = "Y", facet.by = "Cond", color = "ROI", 
                     desc_stat = "mean_se", 
                     position = position_dodge(width = .8), alpha = .5,
                     # font.label = list(size = aov3.label.size),
                     short.panel.labs = FALSE) + 
      
      stat_summary(aes(group = ROI, color = ROI), fun = mean, geom = "line", 
                   position = position_dodge(width = .8), 
                   linewidth = 1, alpha = .8) + 
      
      geom_vline(xintercept = seq(1.5, 7.5), 
                 linetype = "dashed", color = "gray", alpha = .5)
    
    ## one-way ANOVA of Run: 
    if ( aov3.plot.1way.run ) {
      
      if ( length(roi_select) == 2 ) {
        P <- P + 
          stat_anova_test(aes(group = ROI, color = ROI), group.by = "legend.var", 
                          method = "one_way_repeated", wid = "Subj", 
                          label = "italic(p) = {p.format} {p.signif}",
                          label.y = c(max(data_summ$mean) + sd(data_summ$mean), 
                                      min(data_summ$mean) - sd(data_summ$mean)), 
                          hjust = -.1, size = 5.5)
        
      } else { # more than two ROI
        P <- P +
          stat_anova_test(aes(group = ROI, color = ROI), group.by = "legend.var",
                          method = "one_way_repeated", wid = "Subj",
                          label = "italic(p) = {p.format} {p.signif}", 
                          label.y = seq(from = max(data_summ$mean) + length(roi_select)*sd(data_summ$mean), 
                                        to = max(data_summ$mean) + sd(data_summ$mean), 
                                        length.out = length(roi_select)), 
                          # step.increase = .05, 
                          hjust = -.1, vjust = "inward", size = 5.5) 
      }
    }
    
    P <- P + 
      labs(x ="Exposure runs", y = "Intensity", 
           subtitle = get_test_label(AOV.3w, detailed = TRUE)) + 

          theme(text = element_text(size = aov3.element.text.size))
    
    ###
    aov3.fig.name <- ifelse(aov3.plot.1way.run, 
                            "3W_ws_ANOVA (with stats).jpg", "3W_ws_ANOVA.jpg")
    
    ggsave(P, file = file.path(fig_dir, aov3.fig.name), 
           width = aov3.fig.width, height = aov3.fig.height, dpi = 200)
  }
  
  ## 2-way (at title) per ROI + main effect of Cond: =============================
  if ( plot.2way.anova | plot.main.figs ) {
    
    for ( roi in roi_select ) { 
      
      roi_data <- subset(sub_DF, ROI == roi)
      roi_summ <- subset(data_summ, ROI == roi) 
      roi_smec <- subset(SME.cond, ROI == roi)
      
      AOV.2w <- roi_data %>% 
        rstatix::anova_test(dv = Y, wid = Subj, within = c(Cond, Run), data=.) %>% 
        get_anova_table(.)
      
      P <- ggerrorplot(roi_data, x = "Run", y = "Y", color = "Cond", 
                       palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                       desc_stat = "mean_se", 
                       position = position_dodge(.8), alpha = .8, 
                       # font.label = list(size = aov2.label.size),
                       short.panel.labs = FALSE) + 
        
        stat_summary(aes(group = Cond, color = Cond), 
                     fun = mean, geom = "line", 
                     position = position_dodge(width = .8), linewidth = 1) + 
        
        stat_summary(aes(group = Cond, color = Cond), 
                     fun = mean, geom="point", 
                     position = position_dodge(width = .8), size = 3, alpha = .5) + 
        
        geom_vline(xintercept = seq(1.5, 7.5), 
                   linetype = "dashed", color = "gray", alpha = .5)
      
      ## one-way ANOVA of Cond:
      if ( aov2.plot.1way.cond ) {
        P <- P + 
          geom_text(data = roi_smec, 
                    aes(x = Run, 
                        y = ifelse(aov2.plot.fixed.y, 
                                   max(data_summ$mean) + .01, 
                                   max(roi_summ$mean) + .01), 
                        label = ifelse(p < .001, "p < .001**", 
                                       ifelse(p < .05, paste0("p = ", round(p, 3), "*"), 
                                              ""))), 
                    size = 5, angle = 15, fontface = "bold", show.legend = FALSE)
        
          # stat_anova_test(aes(group = Cond), 
          #                 group.by = "x.var", 
          #                 method = "one_way_repeated", wid = "Subj", 
          #                 label = "{p.signif}", 
          #                 label.y = max(roi_summ$mean) + .01, vjust  = "inward", 
          #                 color = "darkgray", angle = 45, size = 5.5) 
      }
      
      
      P <- P + 
        coord_cartesian(ylim = c(ifelse(aov2.plot.fixed.y, 
                                        min(data_summ$mean) - .01, 
                                        min(roi_summ$mean) - .01), 
                                 ifelse(aov2.plot.fixed.y,
                                        max(data_summ$mean) + .01, 
                                        max(roi_summ$mean) + .01))) + 
        
        # scale_x_discrete(labels = change.run.labels) + 
        
        labs(x = "Exposure runs", y = "Intensity", title = roi, 
             subtitle = get_test_label(AOV.2w, detailed = TRUE)) + 
        
        theme(text = element_text(size = aov2.element.text.size), 
              legend.position = "right") 
      
      ###
      aov2.fig.name <- paste0("Interaction_Cond_x_Run__", roi, ".jpg")
      aov2.fig.name <- ifelse(aov2.plot.fixed.y, 
                              paste0("[same scale] ", aov2.fig.name), aov2.fig.name)
        
      ggsave(file = file.path(fig_dir, aov2.fig.name), 
             width = aov2.fig.width, height = aov2.fig.height, dpi = 200)  
    }
  } 

  ## Linear fit between Y and Run, per ROI x Cond: =============================
  if ( plot.lm.y.run ) {
    
    for ( roi in roi_select ) { 
      # for ( cond in c(cond_list, "overall") ) {
      for ( cond in cond_list ) {
        
        if ( cond == "overall" ) {
          run_data <- subset(sub_DF, ROI == roi)
        } else {
          run_data <- subset(sub_DF, ROI == roi & Cond == cond) }
        
        ggplot(run_data, aes(x = Run, y = Y)) + 

          stat_summary(fun = mean, geom = "point", 
                       color = "red", size = 3, alpha = .5) + 
          
          stat_summary(aes(group = 1), fun = mean, geom = "line", 
                       color = "red", linewidth =.5, alpha =.5, linetype = "dashed") + 
          
          stat_smooth(method = lm, formula = y ~ x) + 
          
          stat_summary(fun.data = mean_se, geom = "errorbar", 
                       color = "red", width = 0.1) + 
          
          stat_cor(label.x.npc = "left", # label.y.npc = "bottom", 
                   label.y = min(subset(data_summ, ROI == roi)$mean) - .01,
                   hjust = "inward", vjust = "inward", 
                   color = "black", size = 5) +
          
          stat_regline_equation(label.x.npc = "right", # label.y.npc = "top", 
                                label.y = max(subset(data_summ, ROI == roi)$mean) + .01,
                                hjust = "inward", vjust = "inward", 
                                color = "blue", size = 5) + 
          
          coord_cartesian(ylim = c(min(subset(data_summ, ROI == roi)$mean) - .01,
                                   max(subset(data_summ, ROI == roi)$mean) + .01)) +
          
          scale_x_continuous(n.breaks = 8) + 

          labs(x = "Exposure runs", y = "Intensity", 
               title = paste0(roi, ", ", cond)) + 
          
          theme(text = element_text(size = lm.text.size)) 
        
        ggsave(file = file.path(lm_fig_dir, paste0(roi, "_", cond, ".jpg")), 
               width = lm.fig.width, height = lm.fig.height, dpi = 200) 
      }
    } 
  }
}
## specified pair-wise t-tests: ================================================
if ( do.pairwise.tt ) {
  
  PWC.plot <- PWC %>% add_xy_position(x = do.pairwise.for, fun = "mean_se")

  if ( do.pairwise.for == "ROI" ) { # ------------------------------------------
    
    PWC.data$ROI  <- factor(PWC.data$ROI, levels = roi_select)
    PWC.data$hemi <- ifelse(grepl("rh-", PWC.data$ROI), "R", 
                            ifelse(grepl("lh-", PWC.data$ROI), "L", "Uni"))
    
    if ( length(unique(PWC.data$hemi)) == 2 ) {
      
      P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Y", color = "hemi", 
                     add = "mean_se", 
                     # font.label = list(size = pwc.label.size),
                     short.panel.labs = FALSE) 
    } else {
      
      P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Y", color = "ROI_group", 
                     add = "mean_se", 
                     # font.label = list(size = pwc.label.size),
                     short.panel.labs = FALSE) 
      }
    
    P <- P + labs(x = NULL) + 
      
      theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    
    fig.title <- paste0(focus_cond, ", ", focus_run) ###
    
  } else if ( do.pairwise.for == "Run" ) { # -----------------------------------
    
    dat_mean <- PWC.data %>% group_by(Run) %>% summarise_at("Y", .funs = mean) 
    dat_sign <- data.frame(Run = unique(PWC.data$Run), 
                           Y.sign = ifelse(dat_mean$Y > 0, "Pos", "Neg"))
    PWC.data$Y.sign <- dat_sign$Y.sign[match(PWC.data$Run, dat_sign$Run)]
    PWC.data$Y.sign <- factor(PWC.data$Y.sign, levels = c("Pos", "Neg"))
    
    P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Y", 
                   fill = "Y.sign", palette = c("red", "blue"), alpha = .5,
                   add = "mean_se", 
                   # font.label = list(size = pwc.label.size),
                   short.panel.labs = FALSE) + 
      
      stat_summary(fun = mean, geom ="point", 
                   color = "black", size = 3, alpha = .5) +
      
      stat_summary(aes(group = 1), fun = mean, geom = "line",
                   color = "black", linewidth = .5, linetype = "dashed") + 
      
      # scale_x_continuous(n.breaks = 8) + 
      # scale_x_discrete(labels = change.run.labels) + 
      
      labs(x = "Exposure runs")
    
    fig.title <- paste0(focus_roi, ", ", focus_cond) ###
    
  } else { # do.pairwise.for == "Cond" # ---------------------------------------
    
    dat_mean <- PWC.data %>% group_by(Cond) %>% summarise_at("Y", .funs = mean) 
    dat_sign <- data.frame(Cond = cond_list, 
                           Y.sign = ifelse(dat_mean$Y > 0, "Pos", "Neg"))
    PWC.data$Y.sign <- dat_sign$Y.sign[match(PWC.data$Cond, dat_sign$Cond)]
    PWC.data$Y.sign <- factor(PWC.data$Y.sign, levels = c("Pos", "Neg"))
    
    P <- ggbarplot(PWC.data, x = do.pairwise.for, y = "Y", 
                   fill = "Y.sign", palette = c("red", "blue"), alpha = .5, 
                   add = "mean_se", 
                   # font.label = list(size = pwc.label.size),
                   short.panel.labs = FALSE) + 
      
      labs(x = NULL)

    fig.title <- paste0(focus_roi, ", ", focus_run) ###
  }
  
  P <- P + 
    stat_pvalue_manual(PWC.plot, hide.ns = T, tip.length = .005, label.size = 5.5) + 
    
    labs(y = "Intensity", title = fig.title, caption = get_pwc_label(PWC)) + 
    
    theme(text = element_text(size = 16))
  
  ggsave(file = file.path(fig_dir, paste0(PWC.name, ".jpg")),
         width = pwc.fig.width, height = pwc.fig.height, dpi = 200)
}