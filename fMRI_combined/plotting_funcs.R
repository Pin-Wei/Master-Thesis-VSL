library(dplyr)
library(tidyr)
library(broom)
library(ggplot2)
library(ggpubr)

#1# ----------------------------------------------------------------------------
# Compare group mean, DF is summarized, var.y = mean.
my_BarPlot <- function(DF, XNAME, YNAME, GNAME, YMIN, YMAX, TITLE, 
                       subTITLE=F, FSIZE=14, AxSIZE=12, LRANGE=F, YINT=F) {
  P <- ggplot(DF, aes(x = !!sym(XNAME), y = mean, group = !!sym(GNAME), 
                      fill = !!sym(GNAME), color = !!sym(GNAME))) +
    geom_bar(stat = "identity", position = "dodge2", alpha =.7) + 
    coord_cartesian(ylim = c(YMIN, YMAX)) +
    labs(x = XNAME, y = YNAME, title = TITLE) +
    theme(text = element_text(size = FSIZE), 
          axis.text = element_text(size = AxSIZE))
  if ( subTITLE != FALSE ) { 
    P <- P + labs(subtitle = subTITLE) }
  if ( LRANGE != FALSE ) {
    P <- P + geom_linerange(aes(ymin = mean-sd, ymax = mean+sd), 
                            position = position_dodge(.9)) }
  if ( YINT != FALSE ) {
    P <- P + geom_hline(aes(yintercept = YINT), color = "white", 
                        linetype = 2, linewidth =.5, alpha =.7) }
  
  return(P)
}

#2# ----------------------------------------------------------------------------
# NOT to compare group mean, a summary (mean) line of var.x is add.
my_BoxPlot <- function(DF, XNAME, YNAME, YMIN, YMAX, TITLE, 
                       subTITLE=F, FSIZE=14, AxSIZE=12, YINT=F) {
  P <- ggplot(DF, aes(x = !!sym(XNAME), y = !!sym(YNAME))) +
    geom_boxplot(aes(group = !!sym(XNAME)), na.rm = TRUE, outlier.color = NA) + 
    stat_summary(aes(group = !!sym(XNAME)), fun = mean, geom = "point", 
                 na.rm = TRUE, size = 3, alpha =.5, color = "blue") + 
    stat_summary(aes(group = 1), fun = mean, geom = "line", 
                 na.rm = TRUE, size = 1.1, color = "blue") + 
    coord_cartesian(ylim = c(YMIN, YMAX)) +
    labs(x = XNAME, y = YNAME, title = TITLE) +
    theme(text = element_text(size = FSIZE), 
          axis.text = element_text(size = AxSIZE))
  if ( subTITLE != FALSE ) { 
    P <- P + labs(subtitle = subTITLE) }
  if ( YINT != FALSE ) {
    P <- P + geom_hline(aes(yintercept = YINT), color = "red", 
                        linetype = 2, linewidth =1, alpha =.5) }
  
  return(P)
}

#3# ----------------------------------------------------------------------------
# To see the trend, a smooth line is add.
my_LinePlot <- function(DF, XNAME, YNAME, GNAME, YMIN, YMAX, TITLE, 
                        subTITLE=F, FSIZE=14, AxSIZE=12, YINT=F) {
  P <- ggplot(DF, aes(x = !!sym(XNAME), y = !!sym(YNAME), group = !!sym(GNAME))) 
  if ( YINT != FALSE ) {
    P <- P + geom_hline(aes(yintercept = YINT), color = "red", 
                        linetype = 1, linewidth =.5, alpha =.5)
  }
  P <- P + geom_smooth(formula = y ~ poly(x, 5), method = "glm", na.rm = T, 
                       linetype = 2, linewidth =.5, color = "grey", alpha =.1) + 
    geom_point(size = 3, alpha =.7, na.rm = T, color = 'blue') + 
    geom_line(size =.5, alpha =.5, na.rm = T, color = 'blue') + 
    coord_cartesian(ylim = c(YMIN, YMAX)) +
    labs(x = XNAME, y = YNAME, title = TITLE) +
    theme(text = element_text(size = FSIZE), 
          axis.text = element_text(size = AxSIZE))
  if ( subTITLE != FALSE ) { 
    P <- P + labs(subtitle = subTITLE) 
  }
  return(P)
}

#4# ----------------------------------------------------------------------------
# Scatter plot + Regression line + Significance test.
my_CorrPlot <- function(DF, XLAB, YLAB, 
                        XNAME, YNAME, YMIN, YMAX, TITLE, 
                        FSIZE=14, AxSIZE=12, YINT=F) {
  X <- subset(DF, select = XNAME)
  Y <- subset(DF, select = YNAME)
  r_val <- round(cor(x = X, y = Y, use = "pairwise.complete.obs"), 2)
  p_val <- round(cor.test(X, Y, use = "pairwise.complete.obs")$p.value, 3)
  
  P <- ggplot(DF, aes(x = !!sym(XNAME), y = !!sym(YNAME))) +
    geom_point(size = 2, alpha =.7, na.rm = TRUE) +
    geom_smooth(formula = y ~ x, method = "lm", na.rm = TRUE) +
    labs(x = XNAME, y = YNAME, title = TITLE,
         subtitle = paste0("R = ", r_val, " (p = ", p_val, ")")) +
    coord_cartesian(ylim = c(YMIN, YMAX)) +
    theme(text = element_text(size = FSIZE), 
          axis.text = element_text(size = AxSIZE))
  
  return(P)
}

### ----------------------------------------------------------------------------
my_1sampleT <- function(DF, IVarName1, IVarName2, DVarN, H_0, ALT) {
  DF_summ <- DF %>% 
    group_by(!!sym(IVarName1), !!sym(IVarName2)) %>%
    summarise_at(vars(!!sym(DVarN)),
                 list(mean = ~ mean(., na.rm = TRUE),
                      sd = ~ sd(., na.rm = TRUE), 
                      max = ~ max(., na.rm = TRUE)))
  DF_stats <- DF %>% 
    group_by(!!sym(IVarName1), !!sym(IVarName2)) %>%
    tidyr::drop_na(!!sym(DVarN)) %>% 
    do(tidy(t.test(!!sym(DVarN) ~ 1,
                   data = ., 
                   na.rm = TRUE,
                   mu = H_0,
                   alternative = ALT))) %>%
    select(all_of(c(IVarName1, IVarName2, "statistic", "p.value")))
  
  p_sig <- cut(DF_stats$p.value, c(0, .001, .05, 1), labels = c("**", "*", "")) 
  p_nsig <- ifelse(DF_stats$p.value > .05, "n.s.", "")
  
  p_print <- ifelse(DF_stats$p.value < .05, 
                    ifelse(DF_stats$p.value < .001, "< .001", 
                           round(DF_stats$p.value, 3)), "") 
  
  DF_stats <- cbind(DF_stats, "p_print" = p_print, 
                    "p_sig" = p_sig, "p_Nsig" = p_nsig)
  
  DF <- inner_join(DF_summ, DF_stats, by = c(IVarName1, IVarName2))
  
  return(DF)
}

### ----------------------------------------------------------------------------
my_addSig2Plt <- function(P, P_PRINT=F, P_SIG=F, P_NSIG=F, 
                          PPR_hj=0.5, PPR_vj=0, PPR_C="black", 
                          PS_hj=-0.5,  PS_vj=0,  PS_C="gray", 
                          PNS_hj=0.5, PNS_vj=0, PNS_C="gray") {
  
  if ( P_PRINT != FALSE ) {
    P <- P + geom_text(aes(label = p_print, y = mean*2), 
                       colour = PPR_C, angle = 15,
                       position = position_dodge(.9), 
                       hjust = PPR_hj, vjust = PPR_vj,
                       check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE) 
  }
  if ( P_SIG != FALSE ) {
    P <- P + geom_text(aes(label = p_sig, y = mean+sd), 
                       colour = PS_C, size = 5, angle = 45, 
                       position = position_dodge(.9), 
                       hjust = PS_hj, vjust = PS_vj,
                       check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE)
  }
  if ( P_NSIG != FALSE ) {
    P <- P + geom_text(aes(label = p_Nsig, y = mean*2), 
                       colour = PNS_C, fontface="italic", 
                       position = position_dodge(.9), 
                       hjust = PNS_hj, vjust = PNS_vj,
                       check_overlap = TRUE, na.rm = TRUE, show.legend = FALSE)
  }
  
  P <- P + guides(color = "none")
  
  return(P)
}