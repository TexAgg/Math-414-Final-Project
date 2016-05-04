(* ::Package:: *)

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


(* ::Subsubsection:: *)
(*Preprocessing*)


(* Convert to grayscale so I don't need to deal with color space. 
For future reference a YCrCb transform example is given here:
http://community.wolfram.com/groups/-/m/t/233186?p_p_auth=21UnjxGl *)
baby = ColorConvert[%,"Grayscale"]

(* How do I subtract intensity values? *)


(* ::Subsubsection:: *)
(*Transformation*)


(* Lossless compression. *)
lossless = DiscreteWaveletTransform[baby, CDFWavelet["5/3"],2]

WaveletImagePlot[lossless, BaseStyle->Red]
Export["losslessbaby.png",%]


(* Lossy compression. *)
lossy = DiscreteWaveletTransform[baby,CDFWavelet["9/7"],2]

WaveletImagePlot[lossy,BaseStyle->Red]
Export["lossybaby.png",%]
