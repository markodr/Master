function [H, C, G] = matrix_dyn(q, dq)

global m l I g

% inertial matrix
H11 = 2*I + m*l^2*(1.5+cos(q(2)));
H12 = I + 0.5*m*l^2*(0.5+cos(q(2)));
H21 = H12;
H22 = I + 0.25*m*l^2;

H = [H11 H12;...
     H21 H22];

% velocity effects matrix
C11 = -m*l^2*sin(q(2))*dq(2);
C12 = -0.5*m*l^2*sin(q(2))*dq(2);
C21 = 0.5*m*l^2*sin(q(2))*dq(1);
C22 = 0;

C = [C11 C12;...
     C21 C22];

% gravity matrix
G11 = -1.5*m*l*g*sin(q(1))-0.5*m*l*g*sin(q(1)+q(2));
G21 = -0.5*m*l*g*sin(q(1)+q(2));

G = [G11;...
     G21];