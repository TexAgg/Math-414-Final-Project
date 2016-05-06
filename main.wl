(* ::Package:: *)

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


(* ::Subsubsection::Closed:: *)
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
lossless = DiscreteWaveletTransform[baby, CDFWavelet["5/3"],2]


(* Perform DWT on numerical image values:
DiscreteWaveletTransform[ImageData[baby], CDFWavelet["5/3"],2] *)


WaveletImagePlot[lossless, BaseStyle->Red]
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
lossy = DiscreteWaveletTransform[baby,CDFWavelet["9/7"],2]


lossyPlot = WaveletImagePlot[lossy,BaseStyle->Red]
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


(* I don't know how to do this. 
http://www.mathworks.com/matlabcentral/fileexchange/11764-wsq-image-library--for-fingerprints--v-2-8 *)


(* https://reference.wolfram.com/language/ref/ColorQuantize.html *)


(* Color-quantize the lossy DWT. 
I think this is not what I want. *)
quant = ColorQuantize[lossyPlot,7]


(* How do I quantize? 
https://reference.wolfram.com/language/ref/WaveletMapIndexed.html *)


(* http://www.whydomath.org/node/wavlets/jpeg2000quantization.html *)
Clear[q,t,d,R,c,i]
R=8;
i=2;
c=8.5;
fr=8;
\[Tau] = 2^(R-c+i)*(1+fr/2^(11))
(* Step size. *)
d = \[Tau];
(* Quantization function. 
This needs to accept an image as an argument,
and return an image. 
Try applying it to the ImageData. *)
q[t_,w_] := Sign[t]*Floor[Abs[t]/(\[Tau]/2^w)]


(* This gets me the data, but I need it in image form. 
Also it is slow. *)
(*WaveletMapIndexed[q,DiscreteWaveletTransform[ImageData[baby], CDFWavelet["5/3"],2]]*)


(* Experiment with R. *)
RSet["cof",10]
(*REvaluate["source('C:/Users/mgaik/Dropbox/Programming/R/Math-414-Final-Project/main.R')"]*)


(* ::Subsubsection:: *)
(*Encoding*)


(* I have no idea what to do for this part. *)
ByteCount[Compress[baby]]
(* https://reference.wolfram.com/language/ref/ImageMeasurements.html *)
ImageMeasurements[baby,{"Dimensions","SampleDepth"}]
186*240*8



