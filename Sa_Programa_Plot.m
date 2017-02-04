clear all



%% ACC 1
figure();
title('Svi inteziteti');
hold on;
plot(Zuta4);
plot(Zuta5);
plot(Zuta6);
hold off;
%%
clc
% Izlazi
Gornji=0;
Donji=0;
Donji=0;
% Ulazi
gore=1;
sredina=2;
dole=3;
tr=0.1;
izlaz=[0;0;0];

if gore>sredina && gore>dole && gore>=tr
    izlaz=[1;0;0]
end

if sredina>gore && sredina>dole && sredina>=tr
    izlaz=[0;1;0]
end

if dole>gore && dole>sredina && dole>=tr
    izlaz=[0;0;1]
end
    
Gornji=izlaz(1);
Srednji=izlaz(2);
Donji=izlaz(1);

    
 