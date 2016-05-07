(* ::Package:: *)

(* 
Matt Gaikema
Math 414 Final Project
Implementation of the JPEG 2000 compression.
*)


(* ::Title:: *)
(*JPEG 2000 Demonstration*)


(* Clear variables. *)
ClearAll["Global`*"]
(* Limit variable scope to just this document. *)
SetOptions[EvaluationNotebook[], CellContext -> Notebook]
(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project\\resources"]


Needs["RLink`"]
(* Load R. *)
InstallR["RHomeLocation"->"C:\\Program Files\\R\\R-3.2.3"]


(* ::Section:: *)
(*JPEG2000 Compression*)


(* Documentation for wavelet transform:
https://reference.wolfram.com/language/ref/DiscreteWaveletTransform.html 
An example:
http://stat.columbia.edu/~jakulin/Wavelets/index.html *)


(* A neat example is given in the documentation for
WaveletImagePlot under Examples\[Rule]Neat examples:
https://reference.wolfram.com/language/ref/WaveletImagePlot.html *)


(* ::Subsection:: *)
(*Baby*)


(* https://reference.wolfram.com/language/ref/format/JPEG2000.html *)
Import["ExampleData/girl.jp2"];


(* ::Subsubsection:: *)
(*Preprocessing*)


(* Convert to grayscale so I don't need to deal with color space. 
For future reference a YCrCb transform example is given here:
http://community.wolfram.com/groups/-/m/t/233186?p_p_auth=21UnjxGl *)
baby = ColorConvert[%,"Grayscale"]
Export["baby.png",baby]

(* How do I subtract intensity values? *)


(* ::Subsubsection::Closed:: *)
(*Transformation*)


(* Lossless compression. *)
lossless = LiftingWaveletTransform[baby, CDFWavelet["5/3"],2]


(* Perform DWT on numerical image values:
DiscreteWaveletTransform[ImageData[baby], CDFWavelet["5/3"],2] *)


losslessPlot = WaveletImagePlot[lossless]
Export["losslessbaby.png",%]


(* Plot functions. *)
Clear[x]
fam = lossless["Wavelet"];
WaveletPsi[fam,x];
ps = Plot[%,{x,-1,2},PlotLabel->"\[Psi](x)"];
WaveletPhi[fam,x];
ph = Plot[%,{x,-1,2},PlotLabel->"\[Phi](x)"];
losslessFamily = GraphicsRow[{ps,ph}]
Export["lossless_family.png",%]


(* Lossy compression. *)
lossy = LiftingWaveletTransform[baby,CDFWavelet["9/7"],2]


lossyPlot = WaveletImagePlot[lossy]
Export["lossybaby.png",%]


(* Plot functions. *)
Clear[x]
fam = lossy["Wavelet"];
WaveletPsi[fam,x];
ps = Plot[%,{x,-1,2},PlotLabel->"\[Psi](x)"];
WaveletPhi[fam,x];
ph = Plot[%,{x,-1,2},PlotLabel->"\[Phi](x)"];
lossyFamily = GraphicsRow[{ps,ph}]
Export["lossy_family.png",%]


(* ::Subsubsection:: *)
(*Quantization*)


(* Using a simpler function because otherwise it doesn't work. *)
G[img_,wind_] := ImageApply[Floor[#*16]/16&,img]
quant = WaveletMapIndexed[G,lossy]


quantPlot = WaveletImagePlot[quant]
Export["quantBabyPlot.png",quantPlot]


(* ::Subsubsection:: *)
(*Encoding*)


lossyBaby = InverseWaveletTransform[quant]
(* Exporting as a .jp2 will automatically perform the encoding. *)
Export[{"lossyBaby.png", "lossyBaby.jp2"},lossyBaby]



