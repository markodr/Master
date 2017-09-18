clc;
clear all;
close all;

Broj_semplova=8;
% Ucitavanje podataka
[Dole1,Dole2,Dole3] = importfile('DOLEPeakToPeak.lvm',1, Broj_semplova);
[Sredina1,Sredina2,Sredina3] = importfile('SREDINAPeakToPeak.lvm',1, Broj_semplova);
[Gore1,Gore2,Gore3] = importfile('GOREPeakToPeak.lvm',1, Broj_semplova);

% Kreiranje ulaznog vektora
GORE=[Gore1';Gore2';Gore3'];
SREDINA=[Sredina1';Sredina2';Sredina3'];
DOLE=[Dole1';Dole2';Dole3'];

%Kreiranje Izaznog Vektora
IzlazDole=[0;0;1]; 
IzlazSredina=[0;1;0]; 
IzlazGore=[1;0;0];

DOLE_IZLAZ=[];
SREDINA_IZLAZ=[];
GORE_IZLAZ =[];

for i=1:Broj_semplova
    DOLE_IZLAZ = [DOLE_IZLAZ,IzlazDole];
    SREDINA_IZLAZ = [SREDINA_IZLAZ,IzlazSredina];
    GORE_IZLAZ = [GORE_IZLAZ,IzlazGore];
end

% Obucavanje ANN
Ulaz=[GORE,SREDINA,DOLE];
Izlaz=[GORE_IZLAZ,SREDINA_IZLAZ,DOLE_IZLAZ];


net = patternnet(10);
[net,tr] = train(net,Ulaz,Izlaz);
nntraintool;

save('ANN.mat','net')

save('Signali.mat','GORE','SREDINA','DOLE');
