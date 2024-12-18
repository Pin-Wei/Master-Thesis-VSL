setwd("C:/Users/PinWei/my_VSL_fMRI/Familiarity_test_performance")

library(ggplot2)
library(viridis)
library(dplyr)

behav <- read.table('familiarity_test_score.txt', header=T) # from my_VSL/Reconstruct_results.py
N <- nrow(behav)

subj_id <- rownames(behav)
behav.slow <- behav[as.integer(subj_id)>100, ]
N.slow <- nrow(behav.slow)

Ges <- 64/3 # guessing score
N.guess <- sum(behav$N_correct < Ges)
N.learn <- sum(behav$N_correct > Ges)
N.slow.guess <- sum(behav.slow$N_correct < Ges)
N.slow.learn <- sum(behav.slow$N_correct > Ges)

score <- behav$N_correct
t.test(score, mu = Ges, alternative = "greater")
null_distribution <- c()
for (i in 1:10000) {
  AFC_2 <- sample(c(1, 0), 16, replace=TRUE)
  AFC_4 <- sample(c(1, 0, 0, 0), 16, replace=TRUE)
  AFC_3 <- sample(c(1, 0, 0), 28, replace=TRUE)
  sample_score <- sum(AFC_2) + sum(AFC_4) + sum(AFC_3)
  null_distribution[i] <- sample_score
}
critical_threshold <- quantile(null_distribution, 0.95)
N.indv.learn <- sum(score > critical_threshold)
H_0 <- data.frame(ndist = null_distribution)

out_table <- data.frame(
  Subj = sprintf("sub-%02d", as.integer(subj_id)),
  Design = ifelse(as.integer(subj_id) > 100, "slow", "rapid"), 
  Score = behav$ACC,
  Group = ifelse(behav$N_correct > critical_threshold, "Learn", "No")
)
write.table(out_table, 
            "subj_score_LN.tsv", sep="\t", row.names = FALSE)
write.table(subset(out_table, Group == "Learn"), 
            "subj_score_Learn.tsv", sep="\t", row.names = FALSE)
write.table(subset(out_table, Group == "No"), 
            "subj_score_No.tsv", sep="\t", row.names = FALSE)

write.table(subset(out_table, Group == "Learn")$Subj, 
            "subjList_learner.txt", quote = F, row.names = F, col.names = F)
write.table(subset(out_table, Group == "No")$Subj, 
            "subjList_nolearn.txt", quote = F, row.names = F, col.names = F)

# ## histogram:-------------------------------------------------------------------
# # ggplot(behav, aes(x=N_correct)) +
# # ggplot(behav.slow, aes(x=N_correct)) +
# ggplot(H_0, aes(x=ndist)) +
#   geom_histogram(binwidth=1, colour="white", fill="pink") +
#   # geom_histogram(binwidth=5, colour="white", fill="pink", aes(y=..density..)) +
#   geom_density(alpha=.2, fill="#FF6666") +
#   # geom_vline(aes(xintercept=Ges), color="black", linetype=2, size=1) +
#   geom_vline(aes(xintercept=critical_threshold), color="red", linetype=2, size=1) + 
#   coord_cartesian(xlim = c(0, 60)) +
#   # scale_x_continuous(breaks=seq(0, 60, 5)) +
#   scale_x_continuous(breaks=seq(0, 60, 10)) +
#   labs(x="Score", y="Amount") +
#   # theme(text=element_text(size=12))
#   theme(text=element_text(size=20))
# 
# # ggsave(file='Familiarity_test_score.jpg', width=6, height=2)
# # ggsave(file='Familiarity_test_score.slow.jpg', width=6, height=2)
# # ggsave(file='Familiarity_test_score.slow (bin=5).jpg', width=6, height=3)
# ggsave(file='Null distribution.jpg', width=6, height=2.5)
# 
# 
# ## box plot: -------------------------------------------------------------------
# behav$Y = "Y"
# ggplot(behav, aes(x=N_correct, y=Y, color=N_correct)) +
#   geom_point(size=3, alpha=.5) +
#   geom_boxplot(alpha=.5) +
#   # geom_vline(aes(xintercept=64/3), color="red", linetype=2, size=1) +
#   scale_color_gradient(low="gray", high="#FF6666") +
#   # scale_color_gradient(low="green", high="blue") +
#   coord_cartesian(xlim = c(0, 60)) +
#   theme(text=element_text(size=12))
# 
# ggsave(file='Familiarity_test_score_box.jpg', width=6, height=1)