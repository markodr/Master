clc;
clear all;
close all;
%filename = 'C:\Users\Embedded Design\Desktop\LabView Master\Cisto_merenje_3_ACC.lvm';
filename = 'C:\Users\Embedded Design\Desktop\LabView Master\Kombinacije.lvm';
delimiter = '\t';
startRow = 25;
formatSpec = '%f%f%f%f%f%f%f%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
X_Value = dataArray{:, 1};
Zuta1 = dataArray{:, 2};
Zuta2 = dataArray{:, 3};
Zuta3 = dataArray{:, 4};
ACC_1 = dataArray{:, 5};
ACC_2 = dataArray{:, 6};
ACC_3 = dataArray{:, 7};
Comment = dataArray{:, 8};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%% pakovanje signala
GORE=[];
SREDINA=[];
DOLE=[];
% KODIRAN IZLAZ
CODE=[0;0;1];
NEMA=[0;0;0];

% Vadim sve sa ACC_1
for i=1:length(ACC_1)
   if isnan(ACC_1(i))
       continue;
   else
       GORE=[GORE,ACC_1(i)];
   end
    
end

% Vadim sve sa ACC_2
for i=1:length(ACC_2)
   if isnan(ACC_2(i))
       continue;
   else
       SREDINA=[SREDINA,ACC_2(i)];
   end
    
end

% Vadim sve sa ACC_3
for i=1:length(ACC_3)
   if isnan(ACC_3(i))
       continue;
   else
       DOLE=[DOLE,ACC_3(i)];
   end
    
end

%% Sada treba napraviti jedan vektor koij sadrzi koji prozori sadrze udarac
close all;
prozor=500;
kraj=floor(length(Zuta1)/prozor);

% Prikazuje PRVI
figure(1);
hold on;
plot( Zuta1(1:500) );
plot( Zuta2(1:500) ); 
plot( Zuta3(1:500) );
hold off;
title('PROZOR-1')
legend('ACC 1','ACC 2','ACC 3');
% Prikazujem od DRUGOG do KRAJA

v=2;
ose=[];
for i=1:kraj-1
    figure(v);
    hold on;
    plot( Zuta1(i*prozor:(i+1)*prozor) );
    plot( Zuta2(i*prozor:(i+1)*prozor) ); 
    plot( Zuta3(i*prozor:(i+1)*prozor) );
    hold off;
    legend('ACC 1','ACC 2','ACC 3');
    legenda=strcat('PROZOR-' , num2str(v));
    title(legenda)
    v=v+1;
    i=i+1;
    ose=[ose;[i*prozor,(i+1)*prozor]];
    
end
%% Prikazujem CEO signal radi biranja signala
figure();
hold on;
plot(Zuta1);
plot(Zuta2);
plot(Zuta3);
hold off;
title('Kompletan Signal')
legend('ACC 1','ACC 2','ACC 3');

%% Prikazujem kompletan intezitete

INTEZITET=[GORE;SREDINA;DOLE];
figure();
hold on;
plot(INTEZITET(1,:));
plot(INTEZITET(2,:));
plot(INTEZITET(3,:));
hold off;
title('INTEZITETI')
legend('ACC 1','ACC 2','ACC 3');

%% OBAVEZNO DODATI 0 VEKTOR i SNIMITI GA

udarci=[];
bez_udarca=[];