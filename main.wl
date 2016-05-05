(* ::Package:: *)

(* ::Title:: *)
(*JPEG 2000 Demonstration*)


(* Clear variables. *)
ClearAll["Global`*"]
(* Limit variable scope to just this document. *)
SetOptions[EvaluationNotebook[], CellContext -> Notebook]
(* Set the working directory for image analysis. *)
SetDirectory["C:\\Users\\mgaik\\Dropbox\\Programming\\R\\Math-414-Final-Project\\resources"]


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

(* How do I subtract intensity values? *)


(* ::Subsubsection::Closed:: *)
(*Transformation*)


(* Lossless compression. *)
lossless = DiscreteWaveletTransform[baby, CDFWavelet["5/3"],2]

WaveletImagePlot[lossless, BaseStyle->Red]
Export["losslessbaby.png",%]


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


(* https://reference.wolfram.com/language/ref/ColorQuantize.html *)


(* Color-quantize the lossy DWT. 
I think this is not what I want. *)
quant = ColorQuantize[lossyPlot,7]


(* How do I quantize? 
https://reference.wolfram.com/language/ref/WaveletMapIndexed.html *)


(* http://www.whydomath.org/node/wavlets/jpeg2000quantization.html *)
Clear[q,t,d]
(* Step size. *)
d = 2;
(* Quantization function. *)
q[t_] := Sign[t]*Floor[Abs[t]/d]
(*Q[list_] := Map[q,list]*)


v = {3,-2.1,0.8,-0.4,-6,4,9,10}
Map[q,v]


(*Q[v]
Map[Q,ImageData[baby]]
ImageData[baby]*)


(*Clear[c]
WaveletMapIndexed[c\[Rule]Q[c],lossy]*)


(* ::Subsubsection:: *)
(*Encoding*)


(* I have no idea what to do for this part. *)
ByteCount[Compress[baby]]
(* https://reference.wolfram.com/language/ref/ImageMeasurements.html *)
ImageMeasurements[baby,{"Dimensions","SampleDepth"}]
186*240*8






