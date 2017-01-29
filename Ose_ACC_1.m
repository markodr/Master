clc;
close all;
clear all;
% Import the data
[~, ~, raw] = xlsread('C:\Users\Embedded Design\Desktop\LabView Master\EXPORT SIGNALA.xlsx','sheet1','A2:H10001');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {0}; % Replace non-numeric cells
% Create output variable
data = reshape([raw{:}],size(raw));
% Allocate imported array to column variable names
Zuta1 = data(:,1);
Zelena1 = data(:,2);
Bela1 = data(:,3); Bela1=Bela1.*0;
Zuta2 = data(:,4);
Zelena2 = data(:,5);
Bela2 = data(:,6); Bela2=Bela2.*0;
Zuta3 = data(:,7);
Zelena3 = data(:,8);
% Ovde peglam 3 osu acc koja ne postoji
Bela3 = data(:,3); Bela3=Bela3.*0;

% Clear temporary variables
clearvars data raw R;

%% ACC 1
figure('name','Senzor 1');
title('ACC 1 - Gornji Senzor');
hold on;
N_Bela_1=Bela1-mean(Bela1);
plot(N_Bela_1);
N_Zelena1=Zelena1-mean(Zelena1);
plot(N_Zelena1);
N_Zuta1=Zuta1-mean(Zuta1);
plot(N_Zuta1);
hold off;
fprintf('\nSenzor 1   %f   %f   %f'...
        ,sum(N_Bela_1.^2),sum(N_Zelena1.^2),sum(N_Zuta1.^2));

%% ACC 2
figure('name','Senzor 2');
title('ACC 2 - Srednji Senzor');
hold on;
N_Bela_2=Bela2-mean(Bela2);
plot(N_Bela_2);
N_Zelena2=Zelena2-mean(Zelena2);
plot(N_Zelena2);
N_Zuta2=Zuta2-mean(Zuta2);
plot(N_Zuta2);
hold off;
fprintf('\nSenzor 2   %f   %f   %f'...
        ,sum(N_Bela_2.^2),sum(N_Zelena2.^2),sum(N_Zuta2.^2));

%% ACC 3
figure('name','Senzor 3');
title('ACC 3 - Donji Senzor');
hold on;
N_Bela_3=Bela3-mean(Bela3);
plot(N_Bela_3);
N_Zelena3=Zelena3-mean(Zelena3);
plot(N_Zelena3);
N_Zuta3=Zuta3-mean(Zuta3);
plot(N_Zuta3);
hold off;
fprintf('\nSenzor 3   %f   %f   %f'...
        ,sum(N_Bela_3.^2),sum(N_Zelena3.^2),sum(N_Zuta3.^2));

%% PRIKAZIVANJE inteziteta

figure('name','Inteziteti');
title('Inteziteti - Svi ACC');
hold on;
Intezitet_1= N_Bela_1.^2 + N_Zelena1.^2 + N_Zuta1.^2 ;
plot(Intezitet_1);
Intezitet_2= N_Bela_2.^2 + N_Zelena2.^2 + N_Zuta2.^2 ;
plot(Intezitet_2);
Intezitet_3= N_Bela_3.^2 + N_Zelena3.^2 + N_Zuta3.^2 ;
plot(Intezitet_3);
hold off;
fprintf('\n')
