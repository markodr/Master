
%M = csvread('C:\Users\Nenad Jovicic ETF\Documents\Dragoslavic\30.08.2016_08.54.16.zgz', 0, 0);%test1 - OK
M = csvread('C:\Users\Nenad Jovicic ETF\Documents\Dragoslavic\30.08.2016_08.53.19.zgz', 0, 0);%test1 - OK


siz=size(M(:,1));

M(:,1)=1:siz(1);
close all;

figure;%TL - senzor na poziciji 1
subplot(6,1,1);
plot(M(:,1), M(:,2));%accx
subplot(6,1,2);
plot(M(:,1), M(:,3));%accy
subplot(6,1,3);
plot(M(:,1), M(:,4));%accz
subplot(6,1,4);
plot(M(:,1), M(:,5));%gyrox
subplot(6,1,5);
plot(M(:,1), M(:,6));%gyroy
subplot(6,1,6);
plot(M(:,1), M(:,7));%gyroz

ACCALL_1=M(:,2).^2+M(:,3).^2+M(:,4).^2;

figure;%FL - senzor na poziciji 2
subplot(6,1,1);
plot(M(:,1), M(:,20));
subplot(6,1,2);
plot(M(:,1), M(:,21));
subplot(6,1,3);
plot(M(:,1), M(:,22));
subplot(6,1,4);
plot(M(:,1), M(:,23));
subplot(6,1,5);
plot(M(:,1), M(:,24));
subplot(6,1,6);
plot(M(:,1), M(:,25));

ACCALL_2=M(:,20).^2+M(:,21).^2+M(:,22).^2;

figure;%SL - senzor na poziciji 3
subplot(6,1,1);
plot(M(:,1), M(:,11));
subplot(6,1,2);
plot(M(:,1), M(:,12));
subplot(6,1,3);
plot(M(:,1), M(:,13));
subplot(6,1,4);
plot(M(:,1), M(:,14));
subplot(6,1,5);
plot(M(:,1), M(:,15));
subplot(6,1,6);
plot(M(:,1), M(:,16));

ACCALL_3=M(:,11).^2+M(:,12).^2+M(:,13).^2;

figure;%FR - senzor na poziciji 4
subplot(6,1,1);
plot(M(:,1), M(:,47));
subplot(6,1,2);
plot(M(:,1), M(:,48));
subplot(6,1,3);
plot(M(:,1), M(:,49));
subplot(6,1,4);
plot(M(:,1), M(:,50));
subplot(6,1,5);
plot(M(:,1), M(:,51));
subplot(6,1,6);
plot(M(:,1), M(:,52));

ACCALL_4=M(:,47).^2+M(:,48).^2+M(:,49).^2;

figure;%zbir svih akcelarometara
subplot(4,1,1);
plot(M(:,1), ACCALL_1, 'r');
subplot(4,1,2);
plot(M(:,1), ACCALL_2);
subplot(4,1,3);
plot(M(:,1), ACCALL_3);
subplot(4,1,4);
plot(M(:,1), ACCALL_4);





% ACCALL_1_cs=cumsum(ACCALL_1-mean(ACCALL_1));
% figure;%zbir svih akcelarometara u razlicitim bojama
% plot(M(:,1), ACCALL_1_cs, 'r');
% hold;

%segmentacija udarca
ACCALL_1234=ACCALL_1+ACCALL_2+ACCALL_3+ACCALL_4;
threshold=10000000;
totalsample=size(M);
punchseg=zeros(totalsample(1),1);
for i=1:totalsample(1)
    if ACCALL_1234(i)>threshold
        punchseg(i)=1;
    end
end

figure;%zbir svih akcelarometara u razlicitim bojama
subplot (3,1,1);
plot(M(:,1), ACCALL_1, 'r');
hold;
plot(M(:,1), ACCALL_2, 'g');
plot(M(:,1), ACCALL_3, 'b');
plot(M(:,1), ACCALL_4, 'y');
subplot (3,1,2);
plot(M(:,1), ACCALL_1234);
subplot (3,1,3);
plot(M(:,1), punchseg);

%vizuelizacija. Kao neki vektor. E sad problem je triangulacija, jer imamo
%4 senzora. Osim toga nije bas jednostavno




