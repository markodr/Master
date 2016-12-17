function [J, A] = matrix_kin(q, dq)

global l1 l2

J11 = l1*cos(q(1))+l2*cos(q(1)+q(2));
J12 = l2*cos(q(1)+q(2));
J21 = -l1*sin(q(1))-l2*sin(q(1)+q(2));
J22 = -l2*sin(q(1)+q(2));

J = [J11 J21;...
     J21  J22];

A1 = -l1*sin(q(1))*(dq(1)^2)-l2*sin(q(1)+q(2))*(dq(1)+dq(2))^2;
A2 = -l1*cos(q(1))*(dq(1)^2)-l2*cos(q(1)+q(2))*(dq(1)+dq(2))^2;

A = [A1;...
     A2];