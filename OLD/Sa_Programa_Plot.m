%clear all
close all
clc
% Testiranje redosleda naponom
figure();
title('Test Senzor - Postaviti x,y,z ose na 3.3V');
hold on;
plot(Sredina1,'r');
plot(Sredina2,'b');
plot(Sredina3,'c');
hold off;
legend('ACC 1','ACC 2','ACC 3')


%% PRIKAZ SNIMLJENIH SIGNALA
clear all
close all
clc
load('NajnovijiSignali.mat')

% Gornji udarac
figure();
title('3 Senzora - GORE UDARACI');
hold on;
plot(Gore1,'r');
plot(Gore2,'b');
plot(Gore3,'c');
hold off;
legend('ACC 1','ACC 2','ACC 3')


%Srednji udarac
figure();
title('3 Senzora - SREDINA UDARACI');
hold on;
plot(Sredina1,'r');
plot(Sredina2,'b');
plot(Sredina3,'c');
hold off;
legend('ACC 1','ACC 2','ACC 3')


%Donji udarac
figure();
title('3 Senzora - DOLE UDARACI');
hold on;
plot(Dole1,'r');
plot(Dole2,'b');
plot(Dole3,'c');
hold off;
legend('ACC 1','ACC 2','ACC 3')



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

    
 