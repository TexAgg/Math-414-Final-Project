(* ::Package:: *)

(* Clear variables. *)
ClearAll["Global`*"]
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
apple = Import["resources/apple.png"]


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
fox = Import["resources/fox.jpg"]


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
img = Import["resources/Highimgnoise.jpg"]


(* Denoise the image. *)
(*TotalVariationFilter[img,0.35,Method->"Poisson"]
TotalVariationFilter[img,0.2,MaxIterations->100]
Sharpen[%,10]
TotalVariationFilter[img,1,Method->"Laplacian",MaxIterations->100]*)


(* Some sources:
ftp://www.adass.org/adass/proceedings/adass97/murtaghf.html *)


Clear[dwt]
dwt=DiscreteWaveletTransform[img,BiorthogonalSplineWavelet[5,5]]

(* Extract image coefficients. *)
dwt[All,"Image"]


wtdwd = WaveletThreshold[dwt, {"Soft", "SURELevel"}, {1 | 2 | 3}]
(* Compare side-by-side: *)
{Image[InverseWaveletTransform[wtdwd], ImageSize -> All], Image[img, ImageSize -> All]}


(*ImageHistogram[img]
ImageHistogram[apple]
ImageHistogram[fox]*)


(* ::Subsection:: *)
(*Example*)


(* Example, in examples\[Rule]applications\[Rule]denoising
https://reference.wolfram.com/language/ref/DiscreteWaveletTransform.html *)


data = Table[Sin[x] + RandomReal[{-0.1, 0.1}], {x, 0, 2 \[Pi], 0.01}];
ListLinePlot[data]
dwd = DiscreteWaveletTransform[data, SymletWavelet[4], 6];
(* Computing the fraction of energy contained at each refinement level: *)
efrac = dwd["EnergyFraction"]
(* Set wavelet coefficients containing less than 1% energy to zero: *)
eth[x_, ind_] := 
 If[(ind /. efrac) < 0.01, x*0., x] /; MemberQ[efrac[[All, 1]], ind]
eth[x_, ___] := x
WaveletMapIndexed[eth, dwd];
ListLinePlot[InverseWaveletTransform[%]]


(* Another example. *)
spaceman = Import["resources/spaceman.png"]
nimg = ImageEffect[spaceman, {"GaussianNoise", 0.2}];
dwd = DiscreteWaveletTransform[nimg, BiorthogonalSplineWavelet[5, 5]];
wtdwd = WaveletThreshold[dwd, {"Soft", "SURELevel"}, {1 | 2 | 3}];
{Image[InverseWaveletTransform[wtdwd], ImageSize -> All], Image[nimg, ImageSize -> All]}



