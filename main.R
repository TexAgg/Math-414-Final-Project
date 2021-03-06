# https://gist.github.com/TexAgg/e8ebb3012ca92195238a75df0b9f2854
# https://raw.githubusercontent.com/TexAgg/Math-414-Final-Project/194eccf20a525c1d908b577ca150dc5022a07191/main.R

#Clear previous variables
rm(list=ls())

# https://cran.r-project.org/web/packages/wavelets/wavelets.pdf
library(wavelets)
# https://cran.r-project.org/web/packages/wavethresh/wavethresh.pdf
library(wavethresh)

data(lennon)
image(lennon)
lwd = imwd(lennon)
compress.imwd(lwd)

# http://stackoverflow.com/questions/10421248/issues-with-matlab-jpeg2000-compression-scheme-using-wavelet-toolbox