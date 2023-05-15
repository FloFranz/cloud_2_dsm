#-----------------------------------------------------------------------
# Name:         comparing_ndsms.R
# Description:  Script compares nDSMs raster files calculated with point-to-raster
#               and pitfree algorithms with reference nDSMs.
# Author:       Florian Franz
# Contact:      florian.franz@nw-fva.de
#-------------------------------------------------------------



# source setup script
source('src/setup.R', local = TRUE)



# 01 - set paths
#----------------

# input path to nDSMs reference
ndsm_ref_path <- processed_data_dir

# input path to nDSMs p2r
ndsm_p2r_path <- paste0(output_dir, 'nDSM')

# input path to nDSMs pitfree
ndsm_pitfree_path <- paste0(output_dir, 'nDSM')



# 02 - read nDSMs
#-----------------

# nDSMs reference
ndsm_ref_files <- list.files(ndsm_ref_path, pattern = '.tif', full.names = TRUE)

ndsm_ref_list <- c()

for (i in seq_along(ndsm_ref_files)) {
  
  ndsm_ref_file <- ndsm_ref_files[i]
  ndsms_ref <- terra::rast(ndsm_ref_file)
  ndsm_ref_list[[i]] <- ndsms_ref
  
}

# nDSMs p2r
ndsm_p2r_files <- list.files(ndsm_p2r_path, pattern = 'p2r.*\\.tif$', full.names = TRUE)


ndsm_p2r_list <- c()

for (i in seq_along(ndsm_p2r_files)) {
  
  ndsm_p2r_file <- ndsm_p2r_files[i]
  ndsms_p2r <- terra::rast(ndsm_p2r_file)
  ndsm_p2r_list[[i]] <- ndsms_p2r
  
}

# nDSMs pitfree
ndsm_pitfree_files <- list.files(ndsm_pitfree_path, pattern = 'pitfree.*\\.tif$', full.names = TRUE)


ndsm_pitfree_list <- c()

for (i in seq_along(ndsm_pitfree_files)) {
  
  ndsm_pitfree_file <- ndsm_pitfree_files[i]
  ndsms_pitfree <- terra::rast(ndsm_pitfree_file)
  ndsm_pitfree_list[[i]] <- ndsms_pitfree
  
}



# 03 - comparison
#-----------------

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

# statistics nDSMs p2r
stats_ndsms_p2r <- c()

for (ndsm in ndsm_p2r_list) {
  
  stats_ndsms_p2r <- append(stats_ndsms_p2r,
                            c(mean = round(terra::global(ndsm, fun = 'mean', na.rm = TRUE), 1),
                              max = round(terra::global(ndsm, fun = 'max', na.rm = TRUE), 1),
                              min = round(terra::global(ndsm, fun = 'min', na.rm = TRUE), 1),
                              sd = round(terra::global(ndsm, fun = 'sd', na.rm = TRUE), 1))
                            
  )
}

# statistics nDSMs pitfree
stats_ndsms_pitfree <- c()

for (ndsm in ndsm_pitfree_list) {
  
  stats_ndsms_pitfree <- append(stats_ndsms_pitfree,
                            c(mean = round(terra::global(ndsm, fun = 'mean', na.rm = TRUE), 1),
                              max = round(terra::global(ndsm, fun = 'max', na.rm = TRUE), 1),
                              min = round(terra::global(ndsm, fun = 'min', na.rm = TRUE), 1),
                              sd = round(terra::global(ndsm, fun = 'sd', na.rm = TRUE), 1))
                            
  )
}

# combine the lists into a single data frame
# determine the length of each list
length_ref <- length(stats_ndsms_ref)
length_p2r <- length(stats_ndsms_p2r)
length_pitfree <- length(stats_ndsms_pitfree)

# determine the number of repetitions
n <- min(length_ref, length_p2r, length_pitfree)

# create the data frame
df_stats <- data.frame(
  ref_mean = unlist(stats_ndsms_ref[seq(1, by = 4, length.out = n)]),
  ref_max = unlist(stats_ndsms_ref[seq(2, by = 4, length.out = n)]),
  ref_min = unlist(stats_ndsms_ref[seq(3, by = 4, length.out = n)]),
  ref_sd = unlist(stats_ndsms_ref[seq(4, by = 4, length.out = n)]),
  p2r_mean = unlist(stats_ndsms_p2r[seq(1, by = 4, length.out = n)]),
  p2r_max = unlist(stats_ndsms_p2r[seq(2, by = 4, length.out = n)]),
  p2r_min = unlist(stats_ndsms_p2r[seq(3, by = 4, length.out = n)]),
  p2r_sd = unlist(stats_ndsms_p2r[seq(4, by = 4, length.out = n)]),
  pitfree_mean = unlist(stats_ndsms_pitfree[seq(1, by = 4, length.out = n)]),
  pitfree_max = unlist(stats_ndsms_pitfree[seq(2, by = 4, length.out = n)]),
  pitfree_min = unlist(stats_ndsms_pitfree[seq(3, by = 4, length.out = n)]),
  pitfree_sd = unlist(stats_ndsms_pitfree[seq(4, by = 4, length.out = n)])
)


# --- visualization ---

# create an empty list to store the boxplot objects
boxplot_list <- c()

# loop through each raster in the list
for (i in 1:length(ndsm_pitfree_list)) {
  
  # extract the raster values as a vector
  raster_values <- values(ndsm_pitfree_list[[i]])
  
  # store the raster values in the boxplot list
  boxplot_list[[i]] <- raster_values
  
}

# plot the boxplots
par(mfrow = c(1, length(ndsm_pitfree_list)))

for (i in 1:length(ndsm_pitfree_list)) {
  
  boxplot(boxplot_list[[i]])
  
}


# get the locations from the row names
locations <- row.names(df_stats)

# set up the layout for bar plots
par(mfrow = c(1, length(locations)))

# loop through each location
for (location in locations) {
  
  # select the mean values for the current location
  mean_values <- df_stats[location, grep("mean", colnames(df_stats))]
  
  # create a bar plot for the mean values
  barplot(as.numeric(mean_values),
          main = paste("Mean Values for tile", location),
          xlab = "Algorithm",
          ylab = "Mean Value",
          names.arg = names(mean_values),
          ylim = c(0,27),
          col = c("blue", "green", "red"))
}