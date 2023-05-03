#-----------------------------------------------------------------------
# Name:         cloud2dsm.R
# Description:  Script calculates digital surface models (DSM) and normalized digital surface models (nDSM)
#               from image-based point clouds previously generated via image-matching methods.
#               The processing is tile-based, where every tile is 1000 x 1000 m.
# Author:       Florian Franz
# Contact:      florian.franz@nw-fva.de
#-------------------------------------------------------------



# source setup script
source('src/setup.R', local = TRUE)



# 01 - set paths and parameters
#-------------------------------

# input path to point cloud tiles
point_clouds <- paste0(raw_data_dir, 'dsm_cloud')

# input path to DTM tiles
dtm <- paste0(raw_data_dir, 'dtm_tiles')

# output path for DSM and nDSM .tif files
out_path_dsm <- paste0(output_dir, 'DSM')
out_path_ndsm <- paste0(output_dir, 'nDSM')

# EPSG code for input data coordinate system
# ERTS89/UTM Zone 32 N = 25832, ERTS89/UTM Zone 33 N = 25833
epsg <- 25832

# define region name
region <- 'solling'



# 02 - preparations for calculations
#-----------------------------------

# remove empty files (< 1500 bytes)
files <- list.files(point_clouds)

for (f in files) {
  
  if (file.size(paste0(point_clouds, '/', f)) < 1500) {
    
    file.remove(paste0(point_clouds, '/', f))
    print('Empty point cloud files removed')
    
  }
}

# rename point clouds and DTM files
source('src/rename_files.R', local = TRUE)

rename_files(dir_path = point_clouds,
             epsg = epsg,
             region = region)

rename_files(dir_path = dtm,
             epsg = epsg,
             region = region)

# list common tiles between DTM and point cloud
# create list of point clouds/DTM without filename extension and without DSM_/DTM_

# create a list of point cloud files
point_list <- list.files(point_clouds, pattern = '\\.laz$|\\.las$', full.names = FALSE)
point_list <- substr(point_list, 5, nchar(point_list) - 4)

# create a list of DTM files
dtm_list <- list.files(dtm, pattern = '\\.laz$|\\.las$', full.names = FALSE)
dtm_list <- substr(dtm_list, 5, nchar(dtm_list) - 4)

# remove all .lax files in DTM directory
filelist <- list.files(dtm, pattern = '\\.lax$', full.names = TRUE)
file.remove(filelist)

# identify file format of point cloud files
pc_format <- substr(list.files(point_clouds)[1],
                    nchar(list.files(point_clouds)[1]) - 3,
                    nchar(list.files(point_clouds)[1]))

# identify file format of DTM files
dtm_format <- substr(list.files(dtm)[1],
                     nchar(list.files(dtm)[1]) - 3,
                     nchar(list.files(dtm)[1]))

# find tiles that occur in point cloud and in DTM
common_list <- dplyr::intersect(point_list, dtm_list)

# list tiles in point cloud and DTM with DSM_/DTM_ and without filename extension
cloud_common <- paste0('DSM_', common_list)
dtm_common <- paste0('DTM_', common_list)

# create a list of file names in common_list
pc_common_tile_list <- paste0(point_clouds, "/DSM_", common_list, pc_format)

# print results
print(paste('point cloud format is', pc_format))
print(paste('point cloud list:', point_list))
print(paste('DTM format is', dtm_format))
print(paste('DTM list:', dtm_list))
print(paste('common list:', common_list))
print(paste('length common list:', length(common_list)))
print(paste('cloud common:', cloud_common))
print(paste('DTM common:', dtm_common))
print(paste("point cloud common tile list:", pc_common_tile_list))
















