clc;
clear all;
close all;

% Ucitavanje podataka
[Dole1,Dole2,Dole3] = importfile('DOLEPeakToPeak.lvm',1, 8);
[Sredina1,Sredina2,Sredina3] = importfile('SREDINAPeakToPeak.lvm',1, 8);
[Gore1,Gore2,Gore3] = importfile('GOREPeakToPeak.lvm',1, 8);

%Kreiranje Izaznog Vektora
IzlazDole=[0;0;1]; IzlazSredina=[0;1;0]; IzlazGore=[1;0;0];

DOLE=[Dole1';Dole2';Dole3'];
DOLE_IZLAZ=[ [0;0;1],[0;0;1],[0;0;1],[0;0;1],[0;0;1],[0;0;1],[0;0;1],[0;0;1] ];

SREDINA=[Sredina1';Sredina2';Sredina3'];
SREDINA_IZLAZ=[ [0;1;0],[0;1;0],[0;1;0],[0;1;0],[0;1;0],[0;1;0],[0;1;0],[0;1;0] ];

GORE=[Gore1';Gore2';Gore3'];
GORE_IZLAZ=[ [1;0;0],[1;0;0],[1;0;0],[1;0;0],[1;0;0],[1;0;0],[1;0;0],[1;0;0] ];

Ulaz=[GORE,SREDINA,DOLE];
Izlaz=[GORE_IZLAZ,SREDINA_IZLAZ,DOLE_IZLAZ];


net = patternnet(10);
[net,tr] = train(net,Ulaz,Izlaz);
nntraintool;