% Brisi pre rucnog importa
clc;
close all;
clear all;
% Import data
figure();
hold on;
plot(ACC1_X);
plot(ACC1_Y);
plot(ACC2_X);

%%
clc; close all; clear all;
pauza=(0.3);
x=0; y=0; z=0; tr=1; score=0; i=0; iter=10;
xi=[0,0]; yi=[0,0]; zi=[0,0];

sekvenca=[1,2,3,1,8];
% Dinamicki kreiram sekvencu
prijem = zeros(1,length(sekvenca));

% Testiram X
if x>=tr && x>=y && x>=z % Aktiviran je ACC
    xi(0)=iter;
    xsad=1;

    prijem(i)=1;
    i=i+1;
    wait(pauza);
end
% Testiram Y
if y>=tr && y>=x && y>=z
    prijem(i)=2;
    i=i+1;
    wait(pauza);
end
% Testiram Z
if z>=tr && z>=x && z>=y
    prijem(i)=2;
    i=i+1;
    wait(pauza);
end

score=prijem;
clear prijem