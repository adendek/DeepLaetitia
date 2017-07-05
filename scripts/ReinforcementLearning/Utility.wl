(* ::Package:: *)

(* ::Input:: *)
(*SelectParameter[]:=( *)
(* parametrNumber = 8;*)
(*Return[parameter =RandomInteger[{1,parametrNumber}]]*)
(*)*)


(* ::Input:: *)
(*KeepPreviousParameterValue[parameter_]:= ( *)
(*Which[parameter ==1, Return[r],*)
(*parameter ==2, Return[t],*)
(*parameter ==3, Return[s],*)
(*parameter ==4, Return[a],*)
(*parameter ==5, Return[b],*)
(*parameter ==6, Return[c],*)
(*parameter ==7, Return[ey],*)
(*parameter ==8, Return[ex]*)
(* ];*)
(*)*)
(**)


(* ::Input:: *)
(*CalculateParameterUpdate[parameter_, step_]:= ( *)
(*deltaRange = step * (ParametersStruct[[parameter]][[3]]- ParametersStruct[[parameter]][[2]]);*)
(*delta = RandomReal[{-deltaRange , deltaRange}];*)
(*Return[delta]*)
(*)*)


(* ::Input:: *)
(*UpdateParmeter[parameter_, delta_]:= ( *)
(*Which[parameter ==1, r=Max[ParametersStruct[[parameter]][[2]] ,Min[ r+delta,ParametersStruct[[parameter]][[3]]] ],*)
(* parameter==2, t =  Max[ParametersStruct[[parameter]][[2]] ,Min[ t+delta,ParametersStruct[[parameter]][[3]]] ],*)
(* parameter == 3 , s = Max[ParametersStruct[[parameter]][[2]] ,Min[ s+delta,ParametersStruct[[parameter]][[3]]] ],*)
(*parameter ==4, a=  Max[ParametersStruct[[parameter]][[2]] ,Min[ a+delta,ParametersStruct[[parameter]][[3]]] ], *)
(*parameter==5, b= Max[ParametersStruct[[parameter]][[2]] ,Min[ b+delta,ParametersStruct[[parameter]][[3]]] ], *)
(*parameter == 6 , c = Max[ParametersStruct[[parameter]][[2]] ,Min[ c+delta,ParametersStruct[[parameter]][[3]]] ],*)
(*parameter ==7, ey=  Max[ParametersStruct[[parameter]][[2]] ,Min[ ey+delta,ParametersStruct[[parameter]][[3]]] ], *)
(*parameter==8, er= Max[ParametersStruct[[parameter]][[2]] ,Min[ er+delta,ParametersStruct[[parameter]][[3]]] ]*)
(* ]*)
(*)*)


(* ::Input:: *)
(*PredictHappinessProbability[face_]:=( *)
(*happinesProbability = trainedConvNet[face,"Probabilities"][[1]];*)
(*Return[happinesProbability]*)
(*)*)
(**)


ExtractFaceFromImage[image_]:=(
	box =  FindFaces[image];
	face =   ImageTrim[image,#]&/@ box ;
	face = face[[1]];
	greyFace = ColorConvert[face,"Grayscale"];
	Return[greyFace]
)


ReloadParameterValue[parameter_,previousParamValue_]:=(
Which[
	parameter ==1, r = previousParamValue ,
	parameter ==2, t = previousParamValue,
	parameter ==3, s = previousParamValue,
	parameter ==4, a = previousParamValue,
	parameter ==5, b = previousParamValue,
	parameter ==6, c = previousParamValue,
	parameter ==7, ey = previousParamValue,
	parameter ==8, ex = previousParamValue
 ];

)


ResetParameters[]:=(
r = 0.5;
t = 0.8;
s = 0.5;
a = 0;
b = 0.6;
c =0;
ey = 0.16;
er = 0;
)
