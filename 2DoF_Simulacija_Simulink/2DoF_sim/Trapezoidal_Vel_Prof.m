function [ref, dq_ref] = Trapezoidal_Vel_Prof(delta_t, tk, tu, startValue, stopValue)

% TRAJECTORY PLANNING ACCORDING TO TRAPEZOIDAL VELOCITY PROFILE
% startValue   - starting reference value 
% stopValue    - ending reference value
% tk           - duration of simulation
% tu           - acceleration time

lengthT = tk/delta_t+1;

alfa_max = (stopValue-startValue)/(tu*(tk-tu));
w_max = alfa_max*tu;

ref = zeros(1,lengthT);    % reference trajectory allocation
dq_ref = zeros(1,lengthT); % reference velocity  allocation

% trajectory planning
for i = 1 : lengthT
   deltat = i*delta_t;
   if ( deltat <= tu )
      ref(i) = startValue + 0.5 * alfa_max * deltat^2; 
   elseif (( deltat > tu ) && ( deltat <= (tk-tu) ))
      ref(i) = startValue + 0.5 * alfa_max * tu^2 + w_max * (deltat - tu);
   elseif ( deltat > tk-tu )
      ref(i) = startValue + 0.5 * alfa_max * tu^2 + w_max * (tk - 2*tu) + w_max * (deltat - (tk - tu)) - 0.5 * alfa_max * (deltat - (tk - tu))^2; 
   end
end

% velocity planning
for i = 1 : lengthT
   deltat = i*delta_t;
   if ( deltat <= tu )
      dq_ref(i) = alfa_max * deltat; 
   elseif (( deltat > tu ) && ( deltat <= (tk-tu) ))
      dq_ref(i) = w_max;
   elseif ( deltat > tk-tu )
      dq_ref(i) = w_max - alfa_max * (deltat - (tk - tu)); 
   end
end