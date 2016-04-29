(* ::Package:: *)

(* Limit variable scope to just this document. *)
SetOptions[EvaluationNotebook[], CellContext -> Notebook]


(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project"]


(* ::Section:: *)
(*Wavelet*)


(* Documentation for wavelet transform:
https://reference.wolfram.com/language/ref/DiscreteWaveletTransform.html 
An example:
http://stat.columbia.edu/~jakulin/Wavelets/index.html *)


(* ::Subsection::Closed:: *)
(*Example*)


img = Import["apple.png"]


(* Perform a discrete wavelet transform on the image, using the Haar wavelet transform. *)
dwt = DiscreteWaveletTransform[img]
(* Extract the coefficients as images. *)
dwt[All,"Image"]
(* Extract the coefficients. *)
(*dwt[All]*)


(* Return the original image. *)
(*InverseWaveletTransform[dwt]*)


(* ::Subsection:: *)
(*Jpeg2000*)


(* Use the CDF Wavelet Transform. *)
(* https://en.wikipedia.org/wiki/JPEG_2000 *)
img = Import["fox.jpg"]


(*ImageData[img]*)
ImageColorSpace[img]


(* 9/7 for lossy compression. 
The JPEG 2000 actually first does a color transform
and then tile coding. *)
dwt = DiscreteWaveletTransform[img,CDFWavelet["9/7"]]
dwt[All,"Image"]
dwt[All]


(* 5/3 for lossless compression. *)
dwt = DiscreteWaveletTransform[img,CDFWavelet["5/3"]]
dwt[All,"Image"]
(*dwt[All]*)


(* ::Section::Closed:: *)
(*Misc.*)


(* Import an image with lots of "noise". *)
img = Import["Highimgnoise.jpg"]


(* Run various tests. 
I have no idea what these mean *)
(*
TotalVariationFilter[img,0.35,Method->"Poisson"]
TotalVariationFilter[img,0.2,MaxIterations->100]
Sharpen[%,10]
TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]
*)
