function dydt_Q_4 = int_2DoF(t, Q_4)
% Function that defines model of 2DOF robot manipulator
%         [tout,Xout] = ode45(@int_2DoF,[t t+dt], q);
%         X = Xout(end,:)';

% Q_4(1) = q(1)
% Q_4(2) = q(2)
% Q_4(3) = dq(1)
% Q_4(4) = dq(2)

global m I l l1 l2 g Fint Tau

[J A] = matrix_kin([Q_4(1); Q_4(2)], [Q_4(3); Q_4(4)]); % calculates J, A
[H C G] = matrix_dyn([Q_4(1); Q_4(2)], [Q_4(3); Q_4(4)]); % calculates H, C, G

% int
% dydtQ_2 = H\(TAU + J'*Fint - C*[Q_4(3);Q_4(4)]-G); 
dydtQ_2 = H\(Tau - C*[Q_4(3);Q_4(4)]-G);

dydt_Q_4(1:2) = Q_4(3:4);
dydt_Q_4(3:4) = dydtQ_2;
dydt_Q_4 = dydt_Q_4';