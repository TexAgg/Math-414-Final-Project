(* ::Package:: *)

(* 
Matt Gaikema
Math 414 Final Project
Spring 2016
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


(* Demonstrate the JPEG 2000 compression algorithm on an image. 
The compression was originally transformed on a picture of a baby;
hence all the baby-related variables. *)


(* Import the image to compress. *)
(*Import["ExampleData/girl.jp2"];*)
Import["ExampleData/spikey2.png"];


(* ::Subsubsection:: *)
(*Preprocessing*)


(* Convert to grayscale so I don't need to deal with color space. 
For future reference a YCrCb transform example is given here:
http://community.wolfram.com/groups/-/m/t/233186?p_p_auth=21UnjxGl *)
baby = ColorConvert[%,"Grayscale"]
Export[{"baby.png","baby.jp2"},baby]


(* ::Subsubsection:: *)
(*Transformation*)


(* Transform for lossless compression. *)
lossless = LiftingWaveletTransform[baby, CDFWavelet["5/3"],2]


(* Perform DWT on numerical image values: *)
(*DiscreteWaveletTransform[ImageData[baby], CDFWavelet["5/3"],2]*)


(* Wavelet immage coefficients. *)
losslessPlot = WaveletImagePlot[lossless]
Export["losslessbaby.png",%]


(* Plot 5/3 primal functions. *)
Clear[x]
fam = lossless["Wavelet"];
WaveletPsi[fam,x];
ps = Plot[%,{x,-1,2},PlotLabel->"\[Psi](x)"];
WaveletPhi[fam,x];
ph = Plot[%,{x,-1,2},PlotLabel->"\[Phi](x)"];
losslessFamily = GraphicsRow[{ps,ph}]
Export["lossless_family.png",%]


(* Transform for lossy compression. *)
lossy = LiftingWaveletTransform[baby,CDFWavelet["9/7"],2]


(* Wavelet immage coefficients. *)
lossyPlot = WaveletImagePlot[lossy]
Export["lossybaby.png",%]


(* Plot 9/7 primal functions. *)
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


(* Wavelet image coefficients. *)
quantPlot = WaveletImagePlot[quant]
Export["quantBabyPlot.png",quantPlot]


(* ::Subsubsection:: *)
(*Encoding*)


lossyBaby = InverseWaveletTransform[quant]
(* Exporting as a .jp2 will automatically perform the encoding. *)
Export["finalLossyBaby.jp2",lossyBaby,"ImageEncoding"->"JPEG2000"]
Export["finalLossyBaby.png",lossyBaby]


losslessBaby = InverseWaveletTransform[lossless]
(* Exporting as a .jp2 will automatically perform the encoding. *)
Export["finalLosslessBaby.jp2",losslessBaby,"ImageEncoding"->"Lossless"]
Export["finalLosslessBaby.png",losslessBaby]


(* ::Section::Closed:: *)
(*Misc.*)


(* ::Subsection::Closed:: *)
(*Image import*)


(* Import external images and figures for the report. *)


Import["http://www.verypdf.com/pdfinfoeditor/jpeg-jpeg2k-1.png"]
Export["comparison.png",%]


(* Switch to a seperate directory with the example images. *)
SetDirectory["example"]


(* The original image. *)
Import["http://www.whydomath.org/node/wavlets/images/Largejpeg2000image.gif"]
Export["originalExample.png",%]


(* 9/7 lossy transform. *)
Import["http://www.whydomath.org/node/wavlets/images/Largejpeg2000wt97.gif"]
Export["lossyTransform.png",%]


(* 5/3 lossless transform. *)
Import["http://www.whydomath.org/node/wavlets/images/Largejpeg2000wt53.gif"]
Export["losslessTransform.png",%]


(* Quantization of the 9/7 wavelet coefficients. *)
Import["http://www.whydomath.org/node/wavlets/images/Largejpeg2000wt97quant.gif"]
Export["exampleQuant.png",%]


(* JPEG 2000 compressed image. *)
Import["http://www.whydomath.org/node/wavlets/images/Largejpeg2000compressed.gif"]
Export["exampleCompressed.png",%]


(* Return to resources directory. *)
ResetDirectory[]


(* ::Subsection::Closed:: *)
(*Messing around*)


(* There is nothing relevant beyond this portion of the file. *)


boi = Import["https://i.ytimg.com/vi/nytzHVEHLLs/hqdefault.jpg"]


boi = RemoveBackground[boi]
(*boi = ImageResize[boi,Scaled[1/2]]*)


Export["datboi.png",boi]


(* I think this external file causes an error with output. *)
(*Get["https://gist.githubusercontent.com/keshavsaharia/5894016/raw/c273091075a4d06edf4b6f9c10cd89020382c5f9/Mathematica%2520-%2520ASCII"]
ASCIIimage[boi]*)
