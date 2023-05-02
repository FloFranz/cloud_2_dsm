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


