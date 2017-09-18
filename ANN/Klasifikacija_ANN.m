clc; clear all; close all;
load ANN.mat;
load Signali.mat;

Ulaz=[GORE,SREDINA,DOLE];
Izlaz = net(Ulaz);

Round_Izlaz=round(Izlaz);
Decimalini_Izlaz=[];
for i=1:length(Round_Izlaz)
    Decimalini_Izlaz= [Decimalini_Izlaz ; bi2de(Round_Izlaz(:,i)')];
end
Decimalini_Izlaz=Decimalini_Izlaz';