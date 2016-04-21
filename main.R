#Clear previous variables
rm(list=ls())

# https://cran.r-project.org/web/packages/wavelets/wavelets.pdf
library(wavelets)
#library(imager)
#library(jpeg)
#library(pixmap)
library(rgdal)
library(png)

###############################################

# Import dataset
data(nile)

k = 1:length(nile)
plot(k,nile, type="l")

nile_dwt = dwt(nile, filter="haar")
#print(nile_dwt)
plot(nile_dwt)

###############################################
# Deconstruct and reconstruct a jpg 
# using SVD.

imdata = readGDAL("apple.png")

## as.matrix converts from sp's data.frame form to matrix
red.matrix <- as.matrix(imdata[1])
green.matrix <- as.matrix(imdata[2])
blue.matrix <- as.matrix(imdata[3])

## we need to flip vertically (could transpose with t() if necessary)
green.matrix <- green.matrix[,ncol(green.matrix):1]
green.matrix.svd <- svd(green.matrix)

d <- green.matrix.svd$d
u <- green.matrix.svd$u
v <- green.matrix.svd$v

op <- par(mfrow = c(3,2))
for (i in c(3, 4, 5, 10, 20, 30))
{
	green.matrix.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
	
	image(green.matrix.compressed, col = heat.colors(255), main = i)
	
}

###############################################