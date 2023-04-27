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



# 01 - data import
#------------------

