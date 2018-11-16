# Country averages of Copernicus ERA5 hourly meteorological variables
# Script to generate the data in https://zenodo.org/record/1489915#.W-8lQXpKjOQ
# @author Matteo De Felice (http://matteodefelice.name)

options(java.parameters = "-Xmx8000m") # needed from loadeR to load in memory the large files

library(tidyverse)
library(loadeR)
library(panas)

# Directory with ERA5 NetCDFs 
PATH <- "/opt/data/ERA5/"
# List of files
files_data <- list(
  list(varname = "msl", path = paste0(PATH, "EU-mslp-2008-2017.nc")),
  list(varname = "z", path = paste0(PATH, "EU-z500-2008-2017.nc")),
  list(varname = "t", path = paste0(PATH, "EU-t850-2008-2017.nc")),
  list(varname = "ro", path = paste0(PATH, "EU-ro-2008-2017.nc")),
  list(varname = "tp", path = paste0(PATH, "EU-tp-2008-2017.nc")),
  list(varname = "sd", path = paste0(PATH, "EU-sd-2008-2017.nc")),
  list(varname = "t2m", path = paste0(PATH, "EU-t2m-2008-2017.nc")),
  list(varname = "ssrd", path = paste0(PATH, "EU-ssrd-2008-2017.nc")),
  list(varname = "ssrdc", path = paste0(PATH, "EU-ssrd-2008-2017.nc")),
  list(varname = "v10", path = paste0(PATH, "EU-w10-2008-2017.nc")),
  list(varname = "u10", path = paste0(PATH, "EU-w10-2008-2017.nc")),
  list(varname = "v100", path = paste0(PATH, "EU-w100-2008-2017.nc")),
  list(varname = "u100", path = paste0(PATH, "EU-w100-2008-2017.nc"))
)
# Function used to load single files
get_ts <- function(file_item) {
  print(file_item)
  print(file_item$path)

  d <- loadGridData(file_item$path, file_item$varname, 
                    years = seq(2000, 2017)) 

  return(list(
    varname = file_item$varname,
    tsdata = get_ts_from_shp(d, shapefile = "NUTS0"), # aggregation at NUTS0
    date = d$Dates$start
  ))
}
# Lapply on all the files
all_ts <- lapply(files_data, get_ts)
# Rename the files
names(all_ts) <- map_chr(all_ts, ~.$varname)
# Save *ALL* the variables to a RDS binary file 
write_rds(all_ts, "country-hourly-ts-ERA5.rds")
# Write the needed CSV 
write_csv(all_ts$u10, 'ERA5-u10.csv')
