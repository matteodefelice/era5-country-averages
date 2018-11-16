# Country averages of Copernicus ERA5 hourly meteorological variables

This repository contains the script used to generate the dataset available at [this Zenodo page](https://zenodo.org/record/1489915#.W-8lQXpKjOQ). 

The R script uses the following packages:

- [panas](https://github.com/matteodefelice/panas) for the country averages based on a shapefile
- [loadeR](https://github.com/SantanderMetGroup/loadeR) to load the NetCDF in a smart way
- [tidyverse](https://www.tidyverse.org/) for all the rest

The ERA5 data can be downloaded freely from the [C3S Climate Data Store](https://cds.climate.copernicus.eu/#!/home).
