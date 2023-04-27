# cloud_2_dsm
Calculation of digital surface models from image-based point clouds.

## Description

The generation of surface models from 3D point clouds is a widely used method for further derivation of structural parameters in the context of forest related studies. Here, image-based point clouds are used to calculate digital surface models (DSM) and, with the additional use of digital terrain models (DTM), normalized digital surface models (nDSM). The latter are particularly suitable for forestry studies because they allow modeling of the canopy surface.

The script 'cloud2dsm.R' is based on a previous script, which was developed within the scope of the "F3 - Flächendeckende Fernerkundungsbasierte Forstliche Strukturdaten" (F3- Area-wide remote sensing based forest structural data) project by project partners Forest Research Institute of Baden-Württemberg (Forstliche Versuchs- und Forschungsanstalt Baden-Württemberg – FVA) and Northwest German Forest Research Institute (Nordwestdeutsche Forstliche Versuchsanstalt – NW-FVA). For further information click [here](https://www.waldwissen.net/de/technik-und-planung/waldinventur/f3-fernerkundungsbasierte-walddaten). However, the [lidR](https://github.com/r-lidar/lidR) package by Jean-Romain Roussel and David Auty is used here for calculating DSM and nDSM.

## Further information about the topic

Roussel, J., Auty, D., Coops, N.C., Tompalski, P., Goodbody, T.R., Meador, A.S., Bourdon, J., de Boissieu, F., Achim, A. (2020). lidR: An R package for analysis of Airborne Laser Scanning (ALS) data. *Remote Sensing of Environment*, 251, 112061. <https://doi.org/10.1016/j.rse.2020.112061>.

Roussel, J., Auty, D. (2023). Airborne LiDAR Data Manipulation and Visualization for Forestry Applications. R package version 4.0.3, https://cran.r-project.org/package=lidR. 
