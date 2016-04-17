#Clear previous variables
rm(list=ls())

library(wavelets)

# Chapter 4 problem 1

f = function(x) {
    if (x >= 0 && x < 1/4) {
    	return(-1)
    } else if (x >= 1/4 && x < 1/2) {
    	return(4)
    } else if (x >= 1/2 && x > 3/4) {
    	return(2)	
    } else if (x >= 3/4 && x < 1) {
    	return(-3)
    } else {
    	return(NaN)
    }
}