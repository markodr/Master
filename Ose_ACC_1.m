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
x=0; y=0; z=0; tr=1; score=0; i=0; iter=10; control='STOP'
xs=[];ys=[];zs=[];

% Treba mi brojaca koji se resetuje sa STOP

sekvenca=[1,2,3,1,8];
% Dinamicki kreiram sekvencu
prijem = zeros(1,length(sekvenca));


% Testiram X
if x>=tr && x>=y && x>=z % Aktiviran je ACC
 
    
end
% Testiram Y
if y>=tr && y>=x && y>=z
    yi(1)=y;
    yi(2)=iter;
end
% Testiram Z
if z>=tr && z>=x && z>=y
    zi(1)=z;
    zi(2)=iter;
end

score=prijem;
clear prijem