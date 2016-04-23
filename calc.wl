(* ::Package:: *)

SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project"]
img = Import["Highimgnoise.jpg"]


TotalVariationFilter[img,0.35,Method->"Poisson"]


TotalVariationFilter[img,0.2,MaxIterations->100]


Sharpen[%,10]


TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]
