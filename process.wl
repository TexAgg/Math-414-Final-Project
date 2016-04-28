(* ::Package:: *)

(* Limit variable scope to just this document. *)
SetOptions[EvaluationNotebook[], CellContext -> Notebook]


(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project"]


(* ::Section:: *)
(*Wavelet*)


img = Import["apple.png"]


(* Perform a discrete wavelet transform on the image. *)
dwt = DiscreteWaveletTransform[img]
(* Extract the coefficients. *)
dwt[All,"Image"]


(* ::Section::Closed:: *)
(*Random*)


(* Import an image with lots of "noise". *)
img = Import["Highimgnoise.jpg"]


(* Run various tests. 
I have no idea what these mean *)
TotalVariationFilter[img,0.35,Method->"Poisson"]
TotalVariationFilter[img,0.2,MaxIterations->100]
Sharpen[%,10]
TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]



