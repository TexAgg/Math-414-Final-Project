#Clear previous variables
rm(list=ls())

library(wavelets)

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
print(fdwt)
print(fdwt@W)
print(fdwt@V)