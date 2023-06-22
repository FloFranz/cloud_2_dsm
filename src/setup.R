#-------------------------------------------------------------
# Name:         setup.R
# Description:  script sets up a working environment,
#               defines file paths for data import and output,
#               and loads required packages
# Author:       Florian Franz
# Contact:      florian.franz@nw-fva.de
#-------------------------------------------------------------



# 01 - setup working environment
#--------------------------------

# create directory called 'data' with subdirectories
# 'raw_data', 'processed_data', and 'metadata'
if (!file.exists(paste('data')) |
    (!file.exists(paste('data/raw_data')) |
     (!file.exists(paste('data/raw_data/dsm_cloud')) |
      (!file.exists(paste('data/raw_data/dtm_tiles')) |
       (!file.exists(paste('data/processed_data')) |
        (!file.exists(paste('data/metadata')))))))) {
  
  dir.create('data')
  dir.create('data/raw_data')
  dir.create('data/raw_data/dsm_cloud')
  dir.create('data/raw_data/dtm_tiles')
  dir.create('data/processed_data')
  dir.create('data/metadata')
  
} else {
  
  invisible()
  
}

# create directory called 'src'
if (!file.exists(paste('src'))) {
  
  dir.create('src')
  
} else {
  
  invisible()
  
}

# create directory called 'Rmd'
if (!file.exists(paste('Rmd'))) {
  
  dir.create('Rmd')
  
} else {
  
  invisible()
  
}

# create directory called 'scripts'
if (!file.exists(paste('scripts'))) {
  
  dir.create('scripts')
  
} else {
  
  invisible()
  
}

# create directory called 'output'
if (!file.exists(paste('output')) |
    (!file.exists(paste('output/DSM')) |
     (!file.exists(paste('output/nDSM')) |
      (!file.exists(paste('output/DSM_laz')) |
       (!file.exists(paste('output/nDSM_laz'))))))) {
  
  dir.create('output')
  dir.create('output/DSM')
  dir.create('output/nDSM')
  dir.create('output/DSM_laz')
  dir.create('output/nDSM_laz')
  
} else {
  
  invisible()
  
}

# list the files and directories
list.files(recursive = TRUE, include.dirs = TRUE)



# 02 - file path definitions
#---------------------------

# define raw data directory
raw_data_dir <- 'data/raw_data/'

# define processed data directory
processed_data_dir <- 'data/processed_data/'

# define output directory
output_dir <- 'output/'



# 03 - package loading
#----------------------

# load (and install) required packages
load_packages <- function(packages) {
  
  for (pkg in packages) {
    
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      
      message(paste("Package '", pkg, "' not found, attempting to install...", sep=""))
      install.packages(pkg, dependencies = TRUE)
      
      if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
        
        stop(paste("Package '", pkg, "' not found and could not be installed.", sep=""))
        
      }
    }
  }
}


load_packages(c('terra', 'raster', 'lidR' , 'dplyr', 'ggplot2'))