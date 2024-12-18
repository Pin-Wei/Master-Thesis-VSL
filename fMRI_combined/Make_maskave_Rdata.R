# source("Make_maskave_Rdata.R") 

setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))
# setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))

rm(list = ls())
fid <- c("local", "remote")[2]

if ( fid == "local" ) {
  behav_folder <- "Familiarity_test_performance"  
  grp_out <- "."
  
} else { # remote
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group")
  behav_folder <- file.path(top_dir, "code") 
  grp_out <- file.path(top_dir, "derivatives")
}

# library(dplyr)   # a grammar of data manipulation
# library(tidyr)   # describes a standard way of storing data

################################################################################

dtype <- as.integer(readline("PPI or ordinary stats? [1 or 2] "))

if ( dtype == 1 ) {
  seed_list <- c("HPC-head", "HPC-body", "HPC-tail", "Hippocampus")
  print(seed_list)
  seed_roi <- seed_list[as.integer(readline("Which seed? [index] "))]
  
  cond_list <- c("Fst", "Snd", "Trd")
  # gfunc <- c("", "_gfunc")[1] 
  gfunc <- c("", "_gfunc")[
    as.integer(readline("What kind of ROIS? ([1]: anat [2]: gfunc) "))]
  
  data_folder <- file.path(grp_out, paste0("ROIstats", gfunc), 
                           "runs_MNI_3ord_v6.PPI_REML", seed_roi)
} else {
  ver <- 7
  reml <- c("", "_REML")[2]
  ap_ver <- paste0("runs_MNI_3ord_v", ver, reml)
  
  if ( ver == 6 | ver == 7 ) {
    cond_list <- c("Fst", "Snd", "Trd", "any.stim", "1.and.2", "2.and.3", "1.vs.2", "3.vs.2", "1.vs.3", "1.2.vs.3", "2.3.vs.1", "1.vs.2.3", "3.vs.1.2")
  } else if ( ver == 5 ) {
    cond_list <- c("Fst", "Snd", "Trd", "1+2+3", "1+2", "2+3", "1-2", "3-2", "1-3")
  } 
  
  gfunc <- c("", "_gfunc")[
    as.integer(readline("What kind of ROIS? ([1]: anat [2]: gfunc) "))]
  
  data_folder <- file.path(grp_out, paste0("ROIstats", gfunc), ap_ver)
}

run_list <- sprintf("run-%02d", seq(2, 9))
# run_list <- sprintf("run-%02d", seq(1, 10))
# run_list <- sprintf("run-01", "run-10")

roi_exclude <- c("CBM_ex")

# ------------------------------------------------------------------------------

df_path <- file.path(data_folder, "maskave.all_ROI_Run_Cond.Rdata")

for ( cond in cond_list ) {
  
  for ( run in run_list ) {
    
    fn_regex <- paste0(run,"_MNI_*_",cond,"_maskave.csv")
    data_path_list <- Sys.glob(paths = file.path(data_folder, fn_regex))
    
    for ( data_path in data_path_list ) {
      
      in_data <- read.table(data_path, header=F, sep=",")
      colnames(in_data) <- c("Subj", "Y")      
      
      if ( cond == "1+2+3" ) {
        file_suffix <- "_1\\+2\\+3_maskave.csv"
        
      } else if ( cond == "1+2" ) {
        file_suffix <- "_1\\+2_maskave.csv"
        
      } else if ( cond == "2+3" ) {
        file_suffix <- "_2\\+3_maskave.csv"
        
      } else if ( cond == "1+3" ) {
        file_suffix <- "_1\\+3_maskave.csv"
        
      } else {
        file_suffix <- paste0("_",cond,"_maskave.csv")
      }
      
      roi <- gsub(file_suffix, "", 
                  gsub(paste0(run,"_MNI_"), "", 
                       basename(data_path)))
      
      if ( !(roi %in% roi_exclude) ) {
        in_data$ROI <- roi
        in_data$Run <- gsub("run-", "", run)
        in_data$Cond <- cond
        
        if ( exists("all_DF") ){
          all_DF <- rbind(all_DF, in_data)
          
        } else { all_DF <- in_data }
      }
    }
  }
}
rm(in_data)

save(all_DF, file = df_path)
write.csv(all_DF, gsub(".Rdata", ".csv", df_path), row.names=FALSE)

