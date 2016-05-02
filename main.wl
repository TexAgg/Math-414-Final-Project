(* ::Package:: *)

(* Limit variable scope to just this document. *)
SetOptions[EvaluationNotebook[], CellContext -> Notebook]


(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project"]


(* ::Section:: *)
(*Compression*)


(* Documentation for wavelet transform:
https://reference.wolfram.com/language/ref/DiscreteWaveletTransform.html 
An example:
http://stat.columbia.edu/~jakulin/Wavelets/index.html *)


(* ::Subsection::Closed:: *)
(*Example*)


Clear[apple]
apple = Import["apple.png"]


Clear[dwt]
(* Perform a discrete wavelet transform on the image, using the Haar wavelet transform. *)
dwt = DiscreteWaveletTransform[apple]
(* Extract the coefficients as images. *)
dwt[All,"Image"]
(* Extract the coefficients. *)
(*dwt[All]*)


(* Return the original image. *)
(*InverseWaveletTransform[dwt]*)


(* ::Subsection::Closed:: *)
(*Jpeg2000*)


Clear[fox]
(* Use the CDF Wavelet Transform. *)
(* https://en.wikipedia.org/wiki/JPEG_2000 *)
fox = Import["fox.jpg"]


(*ImageData[fox]*)
ImageColorSpace[fox]


Clear[dwt]
(* 9/7 for lossy compression. 
The JPEG 2000 actually first does a color transform
and then tile coding. *)
dwt = DiscreteWaveletTransform[fox,CDFWavelet["9/7"]]
dwt[All,"Image"]
dwt[All]


(* 5/3 for lossless compression. *)
dwt = DiscreteWaveletTransform[img,CDFWavelet["5/3"]]
dwt[All,"Image"]
(*dwt[All]*)


(* ::Section:: *)
(*Denoising*)


Clear[img]
(* Import an image with lots of "noise". *)
img = Import["Highimgnoise.jpg"]


(* Denoise the image. *)
(*TotalVariationFilter[img,0.35,Method->"Poisson"]
TotalVariationFilter[img,0.2,MaxIterations->100]
Sharpen[%,10]
TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]*)


(* Some sources:
ftp://www.adass.org/adass/proceedings/adass97/murtaghf.html *)


Clear[dwt]
dwt=DiscreteWaveletTransform[img,SymletWavelet[]]

(* Extract image coefficients. *)
dwt[All,"Image"]


ImageHistogram[img]
(*ImageHistogram[apple]
ImageHistogram[fox]*)


Clear[x,y]
x = Range[-Pi,Pi,0.5];
y = Function[x,Sin[x]]/@x;
(*ListLinePlot[y]*)
y2 = GaussianFilter[y,2];
ListLinePlot[{Transpose@{x,y},Transpose@{x,y2}}]
