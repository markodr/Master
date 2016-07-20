function [Tau] = calculate_Tau(q, q_ref, Kp, Kd, G, i)

for j=1:2
    % feedforward control - gravity compensation
    Tau_FF(j,1) = G(j,1);
    
    % feedback PD control
    Tau_FB(j,1) = Kp(j)*(q_ref(j,i)-q(j)) + Kd(j)*(q_ref(j,i)-q(j));

    Tau(j,1) = Tau_FF(j,1) + Tau_FB(j,1);
end