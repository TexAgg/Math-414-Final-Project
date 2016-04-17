#Clear previous variables
rm(list=ls())

# https://cran.r-project.org/web/packages/wavelets/wavelets.pdf
library(wavelets)

###############################################

# Chapter 4 problem 1

f = function(x) {
    if (x >= 0 && x < 1/4) {
    	return(-1)
    } else if (x >= 1/4 && x < 1/2) {
    	return(4)
    } else if (x >= 1/2 && x < 3/4) {
    	return(2)	
    } else if (x >= 3/4 && x < 1) {
    	return(-3)
    } else {
    	return(NaN)
    }
}

j = 2
k = seq(0, 1-1/2^j, by=1/(2^j))
y = as.numeric(lapply(k,f))

fdwt = dwt(X=y, filter="haar")
#print(fdwt)
#print(fdwt@W)
#print(fdwt@V)

###############################################
# http://www.colorado.edu/engineering/CAS/courses.d/ASEN5519.d/kaist.lecture.11.pdf

# Scaling coefficients
a.2 = c(1.5, -1)
# Wavelet coefficients
b.2 = c(-1, -3/2)
backward = dwt.backward(V=a.2, W=b.2, filter=wt.filter("haar"))
print(backward*sqrt(2))

# Why are the coeficcients reversed?

###############################################

# Import dataset
data(nile)