#-----------------------------------------------------------------------
# Name:         comparing_dsms_and_ndsms.R
# Description:  Script compares DSM and nDSM raster files calculated with
#               point-to-raster algorithm with reference nDSMs.
# Author:       Florian Franz
# Contact:      florian.franz@nw-fva.de
#-------------------------------------------------------------



# source setup script
source('src/setup.R', local = TRUE)



# 01 - set paths
#----------------

# input path to DSMs reference
dsm_ref_path <- processed_data_dir

# input path to nDSMs reference
ndsm_ref_path <- processed_data_dir

# input path to DSMs
dsm_path <- paste0(output_dir, 'DSM')

# input path to nDSMs
ndsm_path <- paste0(output_dir, 'nDSM')



# 02 - read DSMs and nDSMs
#-----------------

# DSMs reference
dsm_ref_files <- list.files(dsm_ref_path, pattern = '^dsm', full.names = TRUE)

dsm_ref_list <- c()

for (i in seq_along(dsm_ref_files)) {
  
  dsm_ref_file <- dsm_ref_files[i]
  dsms_ref <- terra::rast(dsm_ref_file)
  dsm_ref_list[[i]] <- dsms_ref
  
}

# nDSMs reference
ndsm_ref_files <- list.files(ndsm_ref_path, pattern = '^ndsm', full.names = TRUE)

ndsm_ref_list <- c()

for (i in seq_along(ndsm_ref_files)) {
  
  ndsm_ref_file <- ndsm_ref_files[i]
  ndsms_ref <- terra::rast(ndsm_ref_file)
  ndsm_ref_list[[i]] <- ndsms_ref
  
}

# DSMs
dsm_files <- list.files(dsm_path, pattern = '^DSM', full.names = TRUE)

dsm_list <- c()

for (i in seq_along(dsm_files)) {
  
  dsm_file <- dsm_files[i]
  dsms <- terra::rast(dsm_file)
  dsm_list[[i]] <- dsms
  
}

# nDSMs
ndsm_files <- list.files(ndsm_path, pattern = '^nDSM', full.names = TRUE)

ndsm_list <- c()

for (i in seq_along(ndsm_files)) {
  
  ndsm_file <- ndsm_files[i]
  ndsms <- terra::rast(ndsm_file)
  ndsm_list[[i]] <- ndsms
  
}



# 03 - comparison
#-----------------

# statistics DSMs reference
stats_dsms_ref <- c()

for (dsm in dsm_ref_list) {
  
  stats_dsms_ref <- append(stats_dsms_ref,
                            c(mean = round(terra::global(dsm, fun = 'mean', na.rm = TRUE), 1),
                              max = round(terra::global(dsm, fun = 'max', na.rm = TRUE), 1),
                              min = round(terra::global(dsm, fun = 'min', na.rm = TRUE), 1),
                              sd = round(terra::global(dsm, fun = 'sd', na.rm = TRUE), 1))
                            
  )
}

# statistics nDSMs reference
stats_ndsms_ref <- c()

for (ndsm in ndsm_ref_list) {
  
  stats_ndsms_ref <- append(stats_ndsms_ref,
                            c(mean = round(terra::global(ndsm, fun = 'mean', na.rm = TRUE), 1),
                              max = round(terra::global(ndsm, fun = 'max', na.rm = TRUE), 1),
                              min = round(terra::global(ndsm, fun = 'min', na.rm = TRUE), 1),
                              sd = round(terra::global(ndsm, fun = 'sd', na.rm = TRUE), 1))
                            
  )
}

# statistics DSMs
stats_dsms <- c()

for (dsm in dsm_list) {
  
  stats_dsms <- append(stats_dsms,
                            c(mean = round(terra::global(dsm, fun = 'mean', na.rm = TRUE), 1),
                              max = round(terra::global(dsm, fun = 'max', na.rm = TRUE), 1),
                              min = round(terra::global(dsm, fun = 'min', na.rm = TRUE), 1),
                              sd = round(terra::global(dsm, fun = 'sd', na.rm = TRUE), 1))
                            
  )
}

# statistics nDSMs
stats_ndsms <- c()

for (ndsm in ndsm_list) {
  
  stats_ndsms <- append(stats_ndsms,
                       c(mean = round(terra::global(ndsm, fun = 'mean', na.rm = TRUE), 1),
                         max = round(terra::global(ndsm, fun = 'max', na.rm = TRUE), 1),
                         min = round(terra::global(ndsm, fun = 'min', na.rm = TRUE), 1),
                         sd = round(terra::global(ndsm, fun = 'sd', na.rm = TRUE), 1))
                       
  )
}

# combine the lists into a single data frame
# determine the length of each list
length_dsms_ref <- length(stats_dsms_ref)
length_ndsms_ref <- length(stats_ndsms_ref)
length_dsms <- length(stats_dsms)
length_ndsms <- length(stats_ndsms)

# determine the number of repetitions
n <- min(length_dsms_ref, length_ndsms_ref, length_dsms, length_ndsms)

# create the data frame
df_stats <- data.frame(
  dsm_ref_mean = unlist(stats_dsms_ref[seq(1, by = 4, length.out = n)]),
  dsm_ref_max = unlist(stats_dsms_ref[seq(2, by = 4, length.out = n)]),
  dsm_ref_min = unlist(stats_dsms_ref[seq(3, by = 4, length.out = n)]),
  dsm_ref_sd = unlist(stats_dsms_ref[seq(4, by = 4, length.out = n)]),
  ndsm_ref_mean = unlist(stats_ndsms_ref[seq(1, by = 4, length.out = n)]),
  ndsm_ref_max = unlist(stats_ndsms_ref[seq(2, by = 4, length.out = n)]),
  ndsm_ref_min = unlist(stats_ndsms_ref[seq(3, by = 4, length.out = n)]),
  ndsm_ref_sd = unlist(stats_ndsms_ref[seq(4, by = 4, length.out = n)]),
  dsm_mean = unlist(stats_dsms[seq(1, by = 4, length.out = n)]),
  dsm_max = unlist(stats_dsms[seq(2, by = 4, length.out = n)]),
  dsm_min = unlist(stats_dsms[seq(3, by = 4, length.out = n)]),
  dsm_sd = unlist(stats_dsms[seq(4, by = 4, length.out = n)]),
  ndsm_mean = unlist(stats_ndsms[seq(1, by = 4, length.out = n)]),
  ndsm_max = unlist(stats_ndsms[seq(2, by = 4, length.out = n)]),
  ndsm_min = unlist(stats_ndsms[seq(3, by = 4, length.out = n)]),
  ndsm_sd = unlist(stats_ndsms[seq(4, by = 4, length.out = n)])
)

# *** calculate statistics over all 25 tiles ***

# mean height DSM
mean_dsm_ref <- mean(df_stats$dsm_ref_mean)
mean_dsm_new <- mean(df_stats$dsm_mean)

# max height DSM
max_dsm_ref <- mean(df_stats$dsm_ref_max)
max_dsm_new <- mean(df_stats$dsm_max)

# min height DSM
min_dsm_ref <- mean(df_stats$dsm_ref_min)
min_dsm_new <- mean(df_stats$dsm_min)

# mean height nDSM
mean_ndsm_ref <- mean(df_stats$ndsm_ref_mean)
mean_ndsm_new <- mean(df_stats$ndsm_mean)

# max height nDSM
max_ndsm_ref <- mean(df_stats$ndsm_ref_max)
max_ndsm_new <- mean(df_stats$ndsm_max)



# --- visualization ---

# create plots with row numbers on the x-axis and column values on the y-axis
# and distance lines between the value pairs

# mean height DSM
plot(1:nrow(df_stats), df_stats$dsm_ref_mean, type = "p", pch = 16, xlab = "tile", ylab = "mean height", col = "blue", xaxt = "n")
points(1:nrow(df_stats), df_stats$dsm_mean, pch = 16, col = "green")
axis(side = 1, at = 1:nrow(df_stats), labels = 1:nrow(df_stats))
legend("topright", legend = c("DSM_ref", "DSM_new"), col = c("blue", "green"), pch = 16)

# max height DSM
plot(1:nrow(df_stats), df_stats$dsm_ref_max, type = "p", pch = 16, xlab = "tile", ylab = "max height", col = "blue", xaxt = "n")
points(1:nrow(df_stats), df_stats$dsm_max, pch = 16, col = "green")
axis(side = 1, at = 1:nrow(df_stats), labels = 1:nrow(df_stats))
legend("topright", legend = c("DSM_ref", "DSM_new"), col = c("blue", "green"), pch = 16)

for (i in 1:nrow(df_stats)) {
  segments(i, df_stats$dsm_ref_max[i], i, df_stats$dsm_max[i], col = "red", lty = "dashed")
}

# min heigth DSM
plot(1:nrow(df_stats), df_stats$dsm_ref_min, type = "p", pch = 16, xlab = "tile", ylab = "max height", col = "blue", xaxt = "n")
points(1:nrow(df_stats), df_stats$dsm_min, pch = 16, col = "green")
axis(side = 1, at = 1:nrow(df_stats), labels = 1:nrow(df_stats))
legend("topright", legend = c("DSM_ref", "DSM_new"), col = c("blue", "green"), pch = 16)

for (i in 1:nrow(df_stats)) {
  segments(i, df_stats$dsm_ref_min[i], i, df_stats$dsm_min[i], col = "red", lty = "dashed")
}

# mean height nDSM
plot(1:nrow(df_stats), df_stats$ndsm_ref_mean, type = "p", pch = 16, xlab = "tile", ylab = "mean height", col = "blue", xaxt = "n")
points(1:nrow(df_stats), df_stats$ndsm_mean, pch = 16, col = "green")
axis(side = 1, at = 1:nrow(df_stats), labels = 1:nrow(df_stats))
legend("topright", legend = c("nDSM_ref", "nDSM_new"), col = c("blue", "green"), pch = 16)

# max height nDSM
plot(1:nrow(df_stats), df_stats$ndsm_ref_max, type = "p", pch = 16, xlab = "tile", ylab = "max height", col = "blue", xaxt = "n")
points(1:nrow(df_stats), df_stats$ndsm_max, pch = 16, col = "green")
axis(side = 1, at = 1:nrow(df_stats), labels = 1:nrow(df_stats))
legend("topright", legend = c("nDSM_ref", "nDSM_new"), col = c("blue", "green"), pch = 16)

for (i in 1:nrow(df_stats)) {
  segments(i, df_stats$ndsm_ref_max[i], i, df_stats$ndsm_max[i], col = "red", lty = "dashed")
}












