#Clear previous variables
rm(list=ls())

# https://cran.r-project.org/web/packages/wavelets/wavelets.pdf
library(wavelets)

###############################################

# Import dataset
data(nile)
nile_dwt = dwt(nile, filter="haar")

###############################################