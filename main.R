#Clear previous variables
rm(list=ls())

# https://cran.r-project.org/web/packages/wavelets/wavelets.pdf
library(wavelets)

###############################################

# Import dataset
data(nile)

k = 1:length(nile)
plot(k,nile)

nile_dwt = dwt(nile, filter="haar")
#print(nile_dwt, type="l")
plot(nile_dwt)

###############################################