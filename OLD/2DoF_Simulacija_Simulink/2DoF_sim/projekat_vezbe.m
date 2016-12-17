clear all; close all; clc

global m I l l1 l2 g Fint Tau

%% simulation parameters
t = 0;          % simulation time inicialization
dt = 0.001;     % simulation step
T = 3;          % total simulation time
lengthT = T/dt; % number of simulation steps
i = 1;          % simulation step 
g = 9.81;       % gravity acceleration
Fint = [0; 0];  % interaction force - external force

%% kinematics and dynamics parameters
l1 = 0.3;       % [m] length of the 1st link
l2 = 0.3;       % [m] length of the 2nd link
m1 = 4;         % [kg] mass of the 1st link
m2 = 4;         % [kg] mass of the 2nd link
I1 = 0.03;      % [kgm2] moment of inertia of the 1st link
I2 = 0.03;      % [kgm2] moment of inertia of the 2nd link
l = l1; m = m1; I = I1;

%% initial conditions
q = [30*pi/180; 60*pi/180]; % initial position
dq = [0; 0];                % initial velocity
ddq = [0; 0];               % initial acceleration

%% trajectory planning
% calculate reference joint positions and velocities - trapezoidal profile
q_init = q;                         % start position
q_stop = [60*pi/180; -60*pi/180];   % stop position
T_acc = 0.2*T; % acceleration/deceleration time - 20% of total time 
for j = 1:2
    [q_ref(j,:) dq_ref(j,:)] = Trapezoidal_Vel_Prof(dt, T, T_acc, q_init(j), q_stop(j));
end;

%% controller
PID_parameters;

%% main loop
while (t<T)
   t = i*dt;
   
   [J A] = matrix_kin(q, dq); % calculates J, A
   
   [X] = forward_kinematics(q, dq, J, A); % q -> X
   [X_ref] = forward_kinematics(q_ref(:,i), dq_ref(:,i), J, A); % q_ref -> X_ref
   
   [H C G] = matrix_dyn(q, dq); % calculates H, C, G

   [Tau] = calculate_Tau(q, q_ref, Kp, Kd, G, i); % Tau = Tau_FF + Tau_FB
   
   Q_4 = [q; dq];
   options = odeset('RelTol',1e-2,'AbsTol',1e-3,'MaxOrder',3);
   [tout,Q_4_out] = ode45(@int_2DoF,[t t+dt], Q_4, options);
   Q_4 = Q_4_out(end,:)';
   % size(Q_4_out);
   q = Q_4(1:2);
   dq = Q_4(3:4);
    
   % visualisation
   if mod(i,20)==0
      figure(1)
      plot([0 l1*sin(q(1)) l1*sin(q(1))+l2*sin(q(1)+q(2))], [0 l1*cos(q(1)) l1*cos(q(1))+l2*cos(q(1)+q(2))],...
           '--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)
      axis equal;
      axis([0 0.5 0 0.5]);%definisanje osa bez obzira na broj koordinata  
      title('2DoF robot')
      ylabel('z position[m]')
      xlabel('x position[m]')
      grid
      pause(0.1)
   end
    
   write_in_memory;
   i = i+1;
end