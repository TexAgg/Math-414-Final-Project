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


(* ::Subsubsection::Closed:: *)
(*Preprocessing*)


(* Convert to grayscale so I don't need to deal with color space. 
For future reference a YCrCb transform example is given here:
http://community.wolfram.com/groups/-/m/t/233186?p_p_auth=21UnjxGl *)
baby = ColorConvert[%,"Grayscale"]
Export["baby.png",baby]

(* How do I subtract intensity values? *)


(* ::Subsubsection:: *)
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


(* I don't know how to do this. 
http://www.mathworks.com/matlabcentral/fileexchange/11764-wsq-image-library--for-fingerprints--v-2-8 *)


(* How do I quantize? 
https://reference.wolfram.com/language/ref/WaveletMapIndexed.html *)


(* http://www.whydomath.org/node/wavlets/jpeg2000quantization.html *)
Clear[q,t,d,R,c,i,Q,w]
R=8;
i=2;
c=8.5;
fr=8;
\[Tau] = 2^(R-c+i)*(1+fr/2^(11))
(* Step size. *)
d = \[Tau];
(* Quantization function. 
This needs to accept an image as an argument,
and return an image. *)
q[t_,w_] := Sign[t]*Floor[Abs[t]/(2/(2^(w-1)))]


Clear[img,wind]
Q[img_,wind_] := ImageApply[q[#,wind]&,img] 


(*Q[baby,3]*)
(* Holy crap I did something. *)
(*Q[#,2]&/@lossy[All,{"Values","Image"}]*)


(* This gets me the data, but I need it in image form. 
Also it is slow. *)
(*test = WaveletMapIndexed[q,DiscreteWaveletTransform[ImageData[baby], CDFWavelet["5/3"],2]]*)


(* Experiment with R. *)
RSet["cof",10]
(*REvaluate["source('C:/Users/mgaik/Dropbox/Programming/R/Math-414-Final-Project/main.R')"]*)


(* ::Subsubsubsection:: *)
(*Actual implimentation*)


(* Using a simpler function because otherwise it doesn't work. *)
G[img_,wind_] := ImageApply[Floor[#/2]&,img]
quant = WaveletMapIndexed[G,lossy]


InverseWaveletTransform[quant]


ByteCount[Compress[%]]
ByteCount[Compress[baby]]


WaveletImagePlot[quant]
lossyPlot


(* ::Subsubsection:: *)
(*Encoding*)


(* I have no idea what to do for this part. *)
ByteCount[Compress[baby]]
(* https://reference.wolfram.com/language/ref/ImageMeasurements.html *)
ImageMeasurements[baby,{"Dimensions","SampleDepth"}]
186*240*8


StringForm["Size of original image: `` bytes.", ByteCount[Compress[baby]]]
StringForm[
	"Size of compressed image: `` bytes.", 
	ByteCount[Compress[lossless[Automatic,{"Image","Values"}]]]
]



