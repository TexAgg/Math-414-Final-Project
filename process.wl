(* ::Package:: *)

(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project"]


(* Import an image with lots of "noise". *)
img = Import["Highimgnoise.jpg"]


(* Run various tests. *)
TotalVariationFilter[img,0.35,Method->"Poisson"]
TotalVariationFilter[img,0.2,MaxIterations->100]
Sharpen[%,10]
TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]


