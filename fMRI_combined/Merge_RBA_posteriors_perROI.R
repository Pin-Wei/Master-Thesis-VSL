# source("Merge_RBA_posteriors_perROI.R")
# setwd(file.path("/media", "data2", "pinwei", "SL_hippocampus", "Combined_group", "code"))

rm(list = ls())
fid <- c('local', 'remote')[2]

if ( fid == 'local' ) {
  setwd(file.path("C:/Users/PinWei/my_VSL_fMRI"))
  behav_folder <- "Familiarity_test_performance"  
  grp_out <- '.'
  
} else { # remote
  top_dir <- file.path("/media", "data2", "pinwei", "SL_hippocampus")
  behav_folder <- file.path(top_dir, "behavioral_data", "familarity_test") 
  grp_out <- file.path(top_dir, "Combined_group", "derivatives")
  setwd(grp_out)
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

run_list <- c(sprintf("run-%02d", seq(2, 9)))

reml <- as.integer(readline("REML? ([1]: Yes [2]: No) "))
id0 <- c("REML_", "")[reml]

model_idx <- as.integer(readline("model ID ([1]: basic [2]: StudY [3]: Score)? "))
id1 <- c("basic", "StudY", "Score")[model_idx]

model_id <- paste0(id0, id1)
print(model_id)

# eoi_idx <- as.integer(readline("Effect of interest: [1]: Intercept [2]: Intercept + Score"))
if ( model_idx == 3 ) { eoi_list <- c("", "Score_") } else { eoi_list <- c("") }

## Setup dirs: -----------------------------------------------------------------

data_folder <- file.path(grp_out, "RBA", ap_ver, paste0("model_", model_id))

out_folder <- file.path(data_folder, "Posteriors_per_ROI")
if ( ! file.exists(out_folder) ) { 
  dir.create(out_folder, recursive=TRUE)
}

##################################### MAIN #####################################
  
for ( cond in cond_list ) {
  
  for ( xi in seq(length(eoi_list)) ) {
    eoi <- eoi_list[xi]
    
    for ( run in run_list ) {
      
      load(file.path(data_folder, paste0(ap_ver, "_", cond, "_", run, ".RData")))
      
      posteriors <- data.frame(psROI(aa, bb, lop$EOIq[xi]))
      # posteriors <- data.frame(ps0)
      
      for ( roi in colnames(posteriors) ) {
        
        sub_data <- data.frame(posteriors[roi])
        colnames(sub_data) <- run        
        
        if ( run == run_list[1] ){
          assign(roi, sub_data)
          
        } else { 
          assign(roi, cbind(get(roi), sub_data))
        }
      }
    }
    
    out_file <- file.path(out_folder, paste0(eoi, ap_ver, "_", cond, ".RData"))
    save(list = colnames(posteriors), file = out_file)
  }
}

if ( ! file.exists("roiList_RBA.Rdata") ) { 
  roi_list <- colnames(posteriors)
  
  save(file = "roiList_RBA.Rdata", roi_list) 
}

                 