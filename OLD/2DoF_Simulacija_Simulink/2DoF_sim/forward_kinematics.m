function [X] = forward_kinematics(q, dq, J, A)

global l1 l2

% Cartesian position
x = l1*sin(q(1)) + l2*sin(q(1)+q(2));% calculates Cartesian X
z = l1*cos(q(1)) + l2*cos(q(1)+q(2));% calculates Cartesian Z
X = [x; z];

% Cartesian velocity
dX = J*dq; % calculates Cartesian velocities in X and Z direction
% dX = [dx; dz];