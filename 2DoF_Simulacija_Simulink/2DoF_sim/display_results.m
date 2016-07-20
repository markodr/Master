close all

%% internal coordinates q
figure('Position',[50 400 700 250]);
for m1 = 1:2
    subplot(1,2,m1)
    switch m1
        case 1
            plot(dt:dt:T,Ps.q_ref(1,:),'r',dt:dt:T,Ps.q(1,:),'b')
            grid
            title('joint position q(1)')
            ylabel('position[deg]')
            xlabel('time[s]')
            legend('reference position q(1)','position q(1)','Location','NorthEast')
        case 2
            plot(dt:dt:T,Ps.q_ref(2,:),'r',dt:dt:T,Ps.q(2,:),'b')
            grid           
            title('joint position q(2)')
            ylabel('position[deg]')
            xlabel('time[s]')
            legend('reference position q(2)','position q(2)','Location','NorthEast')
    end
end

%% external coordinates
figure('Position',[50 50 700 250]);
for m1 = 1:2
    subplot(1,2,m1)
    switch m1
        case 1
            plot(dt:dt:T,Ps.X_ref(1,:),'r',dt:dt:T,Ps.X(1,:),'b')
            grid
            title('Cartesian position x')
            ylabel('position[m]')
            xlabel('time[s]')
            legend('reference position x ref','actual position x','Location','NorthEast')
        case 2
            plot(dt:dt:T,Ps.X_ref(2,:),'r',dt:dt:T,Ps.X(2,:),'b')
            grid           
            title('Cartesian position z')
            ylabel('position[m]')
            xlabel('time[s]')
            legend('reference position z ref','actual position z','Location','NorthEast')
    end
end

%% joint torques
figure('Position',[800 400 700 250]);
for m1 = 1:2
     subplot(1,2,m1)

     switch m1
         case 1
             plot(dt:dt:T,Ps.Tau(1,:),'b')
             grid
             title('joint torque - first joint')
             ylabel('torque[Nm]')
             xlabel('time[s]')
             legend('tau 1')
         case 2
             plot(dt:dt:T,Ps.Tau(2,:),'b')
             grid
             title('joint torque - second joint')
             ylabel('torque[Nm]')
             xlabel('time[s]')
             legend('tau 2')
    end
end 