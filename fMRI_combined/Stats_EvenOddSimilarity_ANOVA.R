# source(".R") 
rm(list = ls())

library(dplyr)         # a grammar of data manipulation
library(tidyr)         # describes a standard way of storing data
# library(tidyverse)
library(rstatix)
# library(nlme)          # Build model
# library(multcompView)  # Post-hoc tests
# library(lsmeans)       # Post-hoc tests
library(ggplot2)
library(ggpubr)

################################################################################

ap_folder <- "ap-runs_v5"
stim_type <- "tpl_sorted"
runs_type <- c("each", "binded")[1]

roi_sel <- c("High-Vis","Hippocampus")
# focus_roi <- roi_sel[2]

cond_list <- c("Fst", "Snd", "Trd")
# focus_cond <- cond_list[1]

Check_ME <- T
# Check_ME <- F 

PH_ME <- T
# PH_ME <- F

PLOT_3wayAOV <- T
# PLOT_3wayAOV <- F

PLOT_2way_perROI <- T
# PLOT_2way_perROI <- F

# learner_only <- T
learner_only <- F

# threshold <- 21.33
threshold <- 27

################################################################################
## Setup directories: ----------------------------------------------------------

fid <- c('local', 'remote')[1]
if ( fid == 'local' ) {
  top_dir <- file.path("C:", "Users", "PinWei", "my_VSL_fMRI")
  setwd(top_dir)
  data_dir <- file.path(top_dir, "PyMVPA", "odd_even_trials_similarity", ap_folder)
  behav_folder <- "Familiarity_test_performance"  
  
} else {
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus")
  setwd(file.path(top_dir, "Combined_group", "code"))
  mvpa_dir <- file.path(top_dir, "Combined_group", "derivatives", "PyMVPA")
  data_dir <- file.path(mvpa_dir, "odd_even_trials_similarity", ap_folder)
  behav_folder <- file.path(top_dir, "behavioral_data", "familarity_test") 
}

fig_folder <- file.path(data_dir, paste0(
  "ANOVA ",paste(roi_sel, collapse = "_")," (",stim_type,"_",runs_type,")")
  )

if ( ! file.exists(fig_folder) ) {
  dir.create(fig_folder, recursive=TRUE)
}

## Load and combine data: ------------------------------------------------------

data_fn <- paste0("allROI_allRlist_allCond_allSubj_",stim_type,"_",runs_type,".csv")
all_DF <- read.csv(file.path(data_dir, data_fn), header=T)
all_DF$Subj <- as.numeric(gsub("sub-", "", all_DF$Subj))

behav <- read.table(
  file.path(behav_folder, "familiarity_test_score.txt"), 
  header = T, row.names = NULL, 
)
colnames(behav) <- c("Subj", "ACC", "Score", "Vio")
behav$Subj <- as.numeric(behav$Subj)
behav$Group <- ifelse(behav$Score > threshold, "L", "N")

all_DF <- dplyr::left_join(all_DF, behav, by="Subj")
all_DF$Subj <- as.factor(all_DF$Subj)

sub_DF <- subset(
  all_DF, ROI %in% roi_sel & Cond %in% c("Fst", "Snd", "Trd")
)

if ( learner_only ) {
  sub_DF <- subset(sub_DF, Group == "L")
}

##################################### MAIN #####################################
# - https://www.datanovia.com/en/lessons/repeated-measures-anova-in-r/#three-way
# - http://www.cookbook-r.com/Statistical_analysis/ANOVA/#one-way-within-anova

## Three-way Within-subjects Factorial Design: ---------------------------------

AOV3w <- sub_DF %>%
  rstatix::anova_test(dv = Similarity, wid = Subj, within = c(Cond, Runs, ROI), data=.) %>% 
  get_anova_table(.)
# aov(Similarity ~ Cond*Runs*ROI + Error(Subj/(Cond*Runs*ROI)), data=.) %>% 
# summary(.)

fn <- "3W_ws_ANOVA.csv"
write.csv(data.frame(AOV3w), file = file.path(fig_folder, fn))

## Check assumptions -----------------------------------------------------------
if ( Check_ME ) {
  
  Outliers <- sub_DF %>%
    group_by(Cond, Runs, ROI) %>%
    identify_outliers(Similarity)
  write.csv(data.frame(Outliers), 
            file = file.path(fig_folder, "Outliers.csv"))
  
  Normality <- sub_DF %>%
    group_by(Cond, Runs, ROI) %>%
    shapiro_test(Similarity) 
  write.csv(data.frame(Normality), 
            file = file.path(fig_folder, "Norm_Shapiro.csv"))
  
  ggqqplot(sub_DF, "Similarity", ggtheme = theme_bw()) +
    facet_grid(Cond + ROI ~ Runs, 
               labeller = "label_both")
  
  ggsave(file = file.path(fig_folder, "Normality.jpg"), 
         width = 10, height = 10, dpi = 200) 
}

## Post-hoc tests --------------------------------------------------------------
if ( PH_ME | PLOT_2way_perROI ) {  
  
  ## Simple two-way interaction:
  AOV2w <- sub_DF %>% 
    group_by(ROI) %>% 
    rstatix::anova_test(dv = Similarity, wid = Subj, within = c(Cond, Runs), data=.) %>% 
    get_anova_table(.)
  
  write.csv(data.frame(AOV2w), 
            file = file.path(fig_folder, "Interaction_Cond_x_Run.csv"))
  
  ## Simple main effect of Run (per Condition):
  SME_r <- sub_DF %>% 
    group_by(ROI, Cond) %>% 
    rstatix::anova_test(dv = Similarity, wid = Subj, within = Runs, data=.) %>% 
    get_anova_table(.)
  
  write.csv(data.frame(SME_r),
            file = file.path(fig_folder, "Main_effect_Run.csv"))
  
  ## Simple main effect of Condition (per Run):
  SME_c <- sub_DF %>% 
    group_by(ROI, Runs) %>% 
    rstatix::anova_test(dv = Similarity, wid = Subj, within = Cond, data=.) %>% 
    get_anova_table(.)
  
  write.csv(data.frame(SME_c),
            file = file.path(fig_folder, "Main_effect_Cond.csv"))
  
  ## Simple comparisons:
  PWC <- sub_DF %>% 
    group_by(ROI, Cond) %>% 
    rstatix::pairwise_t_test(Similarity ~ Runs, 
                             paired = TRUE, 
                             p.adjust.method = "bonferroni") 
  
  for ( focus_roi in roi_sel ) {
    for ( focus_cond in cond_list ) {
      
      PWC_focus <- PWC %>% 
        filter(ROI == focus_roi, Cond == focus_cond) %>% 
        dplyr::select(., !c(statistic, df, p))
      
      fn <- paste("Pairwise_Tt_only", focus_roi, focus_cond, "csv", sep = ".")
      write.csv(data.frame(PWC_focus), 
                file = file.path(fig_folder, fn))      
    }
  }
}

#################################### PLOTS #####################################

## Three-way ANOVA: ------------------------------------------------------------
if ( PLOT_3wayAOV ) {
  
  fig_name <- paste(c("Three-way_repeated",roi_sel,"jpg"), collapse = ".")
  
  fw <- 10
  fh <- 7
  fig1_ylim <- c(-.25, .5)
  fig1_ypos <- c(.45, .4)
  
  ggboxplot(sub_DF, 
            x = "Runs", 
            y = "Similarity", 
            fill = "ROI", 
            facet.by = "Cond", 
            font.label = list(size = 20),
            short.panel.labs = FALSE, 
            outlier.shape = NA) + 
    
    # One-way repeated ANOVA:
    stat_anova_test(aes(group = ROI, color = ROI), 
                    method = "one_way_repeated", 
                    wid = "Subj",
                    group.by = "legend.var", 
                    # label = "italic(F)({DFn}, {DFd}) = {F}, italic(p) = {p.format} {p.signif}, italic(n) = {n}",
                    label = "italic(p) = {p.format} {p.signif}",
                    label.y = fig1_ypos, 
                    hjust = 0, 
                    size = 6) + 
    
    labs(x = NULL, 
         subtitle = get_test_label(AOV3w, detailed = TRUE)) + 
    
    coord_cartesian(ylim = fig1_ylim) +
    
    theme(text = element_text(size=20), 
          axis.text.x = element_text(size=16, angle = 90, vjust = .5, hjust = 1))
  
  ggsave(file = file.path(fig_folder, fig_name), 
         width = fw, height = fh, dpi = 200)
}

## Two-way ANOVA: --------------------------------------------------------------
if ( PLOT_2way_perROI ) {
  
  fw <- 5
  fh <- 6
  
  # ask_me <- as.integer(readline("Add significant labels for... \
  #   [1] One-way ANOVA for conditions, per run \
  #   [2] pair-wise comparisons across runs"))
  ask_me <- 1
  add_sign_for <- c("one_way_for_cond", "pairwise_comp_runs")[ask_me]
  
  for ( roi in roi_sel ) {
    fig_name <- paste(c("Two-way_repeated",roi,"jpg"), collapse = ".")
    
    fig2_ylim <- c(-.25, .5)
    fig2_ypos <- .4
    # fig2_ypos <- max(filter(sub_DF, ROI == roi)$Similarity)
    
    if ( add_sign_for == "pairwise_comp_runs" ) {
      PWC.filtered <- PWC %>% 
        filter(ROI == roi) %>% 
        add_xy_position(x = "Runs")
      
      PWC.filtered$y.position <- fig2_ypos
      # PWC.filtered$y.position <- seq(from = ypos_0 -.1, to = ypos_0 + .5, 
      #                                length.out = nrow(PWC.filtered))      
      
    } else if ( add_sign_for == "one_way_for_cond" ) {
      SME_c.filtered <- SME_c %>% 
        filter(ROI == roi) 
    }
    
    P <- ggboxplot(sub_DF %>% filter(ROI == roi), 
                   x = "Runs", 
                   y = "Similarity", 
                   fill = "Cond", 
                   palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                   outlier.shape = NA,
                   font.label = list(size = 20), 
                   short.panel.labs = FALSE) +
      
      stat_anova_test(aes(group = "Runs"),
                      method = "two_way_repeated",
                      wid = "Subj",
                      label = "italic(F)({DFn}, {DFd}) = {F}, italic(p) = {p.format} {p.signif}, italic(n) = {n}",
                      label.y.npc = 0,
                      hjust = 0) + 
      
      # labs(subtitle = get_test_label(AOV2w.filtered, detailed = TRUE),
      labs(subtitle = paste0("Anova2: Cond x Run, ",roi))
    
    if ( add_sign_for == "pairwise_comp_runs" ) {
      P <- P +
        stat_pvalue_manual(PWC.filtered, 
                           tip.length = .02, 
                           label = "{p.adj}{p.adj.signif}",
                           hide.ns = T) + 
        
        labs(caption = get_pwc_label(PWC.filtered))
      
    } else if ( add_sign_for == "one_way_for_cond" ) {
      P <- P + 
        geom_text(data = SME_c.filtered, 
                  aes(x = Runs, 
                      y = fig2_ypos, 
                      label = ifelse(
                        p < .05, 
                        ifelse(p < .001, 
                               "< .001**",
                               sprintf("%.3f%s", p, `p<.05`)), 
                        "")), 
                  size = 5, 
                  fontface = "italic", #"bold",
                  angle = 45,
                  colour = "red",
                  na.rm = TRUE, 
                  show.legend = FALSE)
    }
    
    P <- P + 
      labs(x = NULL) +
      
      coord_cartesian(ylim = fig1_ylim) +
      
      theme(text = element_text(size = 16), 
            axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1)) 
    
    ggsave(file = file.path(fig_folder, fig_name), 
           width = fw, height = fh, dpi = 200)  
  }
}

################################### ARCHIVE #################################### 
# ------------------------------------------------------------------------------
# if ( STAT_ME2 ) {
#
#   for ( roi in roi_sel ) {
#     AOV2w <- all_DF %>%
#       subset(ROI == roi) %>%
#       rstatix::anova_test(Similarity ~ Cond*Runs + Error(Subj/(Cond*Runs)), data=.)
#       # aov(Similarity ~ Cond*Runs + Error(Subj/(Cond*Runs)) , data=.) %>% 
#       # summary(.)
#     
#     fn <- paste(c("Two-way_Within-subject_ANOVA",roi,"txt"), collapse = ".")
#     fp <- file.path(fig_folder, fn)
#     capture.output(AOV2w, file = fp)
#     
#     for ( cond in cond_list ) {
#       AOV1w <- all_DF %>%
#         subset(ROI == roi & Cond == cond) %>% 
#         rstatix::anova_test(Similarity ~ Runs + Error(Subj/Runs), data=.)
#         # aov(Similarity ~ Runs + Error(Subj/Runs) , data=.) %>% 
#         # summary(.)
#       
#       fn <- paste(c("One-way_Within-subject_ANOVA",roi,cond,"txt"), collapse = ".")
#       fp <- file.path(fig_folder, fn)
#       capture.output(AOV1w, file = fp)
#     }
#   }
# }