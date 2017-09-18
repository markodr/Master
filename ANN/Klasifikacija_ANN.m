% 8 IzlazMiruje =  [0;0;0;1];
% 4 IzlazDole =    [0;0;1;0]; 
% 2 IzlazSredina = [0;1;0;0]; 
% 1 IzlazGore =    [1;0;0;0];

clc; clear all; close all;
load ANN.mat;
load Signali.mat;
Ulaz=[GORE,SREDINA,DOLE,MIRUJE];
Izlaz = net(Ulaz);
%
Round_Izlaz=round(Izlaz);
Decimalini_Izlaz=[];
for i=1:length(Round_Izlaz)
    Decimalini_Izlaz= [Decimalini_Izlaz ; bi2de(Round_Izlaz(:,i)')];
end
'Gore 1, Sredina 2, Dole 4, Miruje 8'
Decimalini_Izlaz=Decimalini_Izlaz'

% OCEKUJEM 1 2 4 8