clc;
clear all;
close all;

Broj_semplova=8;
% Ucitavanje podataka
[Dole1,Dole2,Dole3] = importfile('DOLEPeakToPeak.lvm',1, Broj_semplova);
[Sredina1,Sredina2,Sredina3] = importfile('SREDINAPeakToPeak.lvm',1, Broj_semplova);
[Gore1,Gore2,Gore3] = importfile('GOREPeakToPeak.lvm',1, Broj_semplova);
[Miruje1,Miruje2,Miruje3] = importfile('MIRUJEPeakToPeak.lvm',1, Broj_semplova);

% Kreiranje ulaznog vektora
GORE=[Gore1';Gore2';Gore3'];
SREDINA=[Sredina1';Sredina2';Sredina3'];
DOLE=[Dole1';Dole2';Dole3'];
MIRUJE=[Miruje1';Miruje2';Miruje3'];

%Kreiranje Izaznog Vektora
IzlazMiruje =  [0;0;0;1];
IzlazDole =    [0;0;1;0]; 
IzlazSredina = [0;1;0;0]; 
IzlazGore =    [1;0;0;0];

DOLE_IZLAZ = [];
SREDINA_IZLAZ = [];
GORE_IZLAZ = [];
MIRUJE_IZLAZ = [];

for i=1:Broj_semplova
    DOLE_IZLAZ = [DOLE_IZLAZ,IzlazDole];
    SREDINA_IZLAZ = [SREDINA_IZLAZ,IzlazSredina];
    GORE_IZLAZ = [GORE_IZLAZ,IzlazGore];
    MIRUJE_IZLAZ =[MIRUJE_IZLAZ,IzlazMiruje];
end

% Obucavanje ANN
Ulaz=[MIRUJE,GORE,SREDINA,DOLE];
Izlaz=[MIRUJE_IZLAZ,GORE_IZLAZ,SREDINA_IZLAZ,DOLE_IZLAZ];

net = patternnet(10);
[net,tr] = train(net,Ulaz,Izlaz);
nntraintool;

save('ANN.mat','net');

save('Signali.mat','MIRUJE','GORE','SREDINA','DOLE');
