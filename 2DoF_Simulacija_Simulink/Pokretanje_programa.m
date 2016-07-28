clear all;
close all;
%% pocetni uslovi
l = 0.3;
q1d = pi/4;
q2d = pi/3;

xd = l*sin(q1d) + l*sin(q1d+q2d);
yd = l*cos(q1d) + l*cos(q1d+q2d);

%% Rezim upravljanja  1 bez merenja sile, 2 sa merenjem sile
Rezim = 0;  
%%  Parametri kontrolera
M = [  1 , 0; 0 ,   1];
B = [ 10 , 0; 0 ,  10];
K = [ 50 , 0; 0  , 50];
%% Simulacija za razlicito K
sim('impedansno_upravljanje.slx');
xy1 = x_y;
q1q2_1 = q1_q2;
tau1 = tau;

K = [ 100, 0; 0, 100];

sim('impedansno_upravljanje.slx');
xy2 = x_y;
q1q2_2 = q1_q2;
tau2 = tau;

K = [200 , 0; 0 , 200];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

K = [400 , 0; 0 , 400];

sim('impedansno_upravljanje.slx');
xy4 = x_y;
q1q2_4 = q1_q2;
tau4 = tau;


figure(1)
subplot(2,2,1)
hold on
plot(xy1)
plot(xy2)
plot(xy3)
plot(xy4)
hold off
subplot(2,2,2)
hold on
plot(q1q2_1)
plot(q1q2_2)
plot(q1q2_3)
plot(q1q2_4)
hold off
subplot(2,2,3)
plot(sila)
subplot(2,2,4)
hold on
plot(tau1)
plot(tau2)
plot(tau3)
plot(tau4)
hold off
%%  Simulacija za razlicito B
M = [  1 , 0; 0 ,   1];
B = [  3 , 0; 0 ,   3];
K = [100 , 0; 0 , 100];

sim('impedansno_upravljanje.slx');
xy1 = x_y;
q1q2_1 = q1_q2;
tau1 = tau;

B = [5 , 0; 0 , 5];

sim('impedansno_upravljanje.slx');
xy2 = x_y;
q1q2_2 = q1_q2;
tau2 = tau;

B = [10 , 0; 0 , 10];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

B = [20 , 0; 0 , 20];

sim('impedansno_upravljanje.slx');
xy4 = x_y;
q1q2_4 = q1_q2;
tau4 = tau;

figure(2)
subplot(2,2,1)
hold on
plot(xy1)
plot(xy2)
plot(xy3)
plot(xy4)
hold off
subplot(2,2,2)
hold on
plot(q1q2_1)
plot(q1q2_2)
plot(q1q2_3)
plot(q1q2_4)
hold off
subplot(2,2,3)
plot(sila)
subplot(2,2,4)
hold on
plot(tau1)
plot(tau2)
plot(tau3)
plot(tau4)
hold off
%%  Simulacija za razlicito M
M = [  1 , 0; 0 ,   1];
B = [ 10 , 0; 0 ,  10];
K = [100 , 0; 0 , 100];

sim('impedansno_upravljanje.slx');
xy1 = x_y;
q1q2_1 = q1_q2;
tau1 = tau;

M = [3 , 0; 0 , 3];

sim('impedansno_upravljanje.slx');
xy2 = x_y;
q1q2_2 = q1_q2;
tau2 = tau;

M = [5 , 0; 0 , 5];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

M = [10 , 0; 0 , 10];

sim('impedansno_upravljanje.slx');
xy4 = x_y;
q1q2_4 = q1_q2;
tau4 = tau;

figure(3)
subplot(2,2,1)
hold on
plot(xy1)
plot(xy2)
plot(xy3)
plot(xy4)
hold off
subplot(2,2,2)
hold on
plot(q1q2_1)
plot(q1q2_2)
plot(q1q2_3)
plot(q1q2_4)
hold off
subplot(2,2,3)
plot(sila)
subplot(2,2,4)
hold on
plot(tau1)
plot(tau2)
plot(tau3)
plot(tau4)
hold off
%%  Simulacija za razlicito K
Rezim = 1;

B = [ 10 , 0; 0 , 10];
K = [ 50 , 0; 0 , 50];

sim('impedansno_upravljanje.slx');
xy1 = x_y;
q1q2_1 = q1_q2;
tau1 = tau;

K = [100 , 0; 0 , 100];

sim('impedansno_upravljanje.slx');
xy2 = x_y;
q1q2_2 = q1_q2;
tau2 = tau;

K = [200 , 0; 0 , 200];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

K = [400 , 0; 0 , 400];

sim('impedansno_upravljanje.slx');
xy4 = x_y;
q1q2_4 = q1_q2;
tau4 = tau;

figure(4)
subplot(2,2,1)
hold on
plot(xy1)
plot(xy2)
plot(xy3)
plot(xy4)
hold off
subplot(2,2,2)
hold on
plot(q1q2_1)
plot(q1q2_2)
plot(q1q2_3)
plot(q1q2_4)
hold off
subplot(2,2,3)
plot(sila)
subplot(2,2,4)
hold on
plot(tau1)
plot(tau2)
plot(tau3)
plot(tau4)
hold off
%%  Simulacija za razlicito B
B = [ 3 , 0; 0 ,  3];
K = [100 , 0; 0 , 100];

sim('impedansno_upravljanje.slx');
xy1 = x_y;
q1q2_1 = q1_q2;
tau1 = tau;

B = [5 , 0; 0 , 5];

sim('impedansno_upravljanje.slx');
xy2 = x_y;
q1q2_2 = q1_q2;
tau2 = tau;

B = [10 , 0; 0 , 10];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

B = [20 , 0; 0 , 20];

sim('impedansno_upravljanje.slx');
xy3 = x_y;
q1q2_3 = q1_q2;
tau3 = tau;

figure(5)
subplot(2,2,1)
hold on
plot(xy1)
plot(xy2)
plot(xy3)
plot(xy4)
hold off
subplot(2,2,2)
hold on
plot(q1q2_1)
plot(q1q2_2)
plot(q1q2_3)
plot(q1q2_4)
hold off
subplot(2,2,3)
plot(sila)
subplot(2,2,4)
hold on
plot(tau1)
plot(tau2)
plot(tau3)
plot(tau4)
hold off





