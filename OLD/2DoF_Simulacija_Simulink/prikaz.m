function  prikaz()
    sim('pro');            % prvo se odradi simulacija u simulinku, potom se dobijeni rezultati koriste za vizuelizaciju
    load('izlazQ1.mat');    % izlazni fajl kreiran u simulaciji, predstavlja putanju prvog zgloba
    load('izlazQ2.mat');    % izlazni fajl kreiran u simulaciji, predstavlja putanju drugog zgloba
    i = 1;
    l1 = 0.3;               % duzina izmedju zglobova
    l2 = 0.3;
    while (i<length(q1))
        figure(1)
        plot([0 l1*sin(q1(2,i)) l1*sin(q1(2,i))+l2*sin(q1(2,i)+q2(2,i))], [0 l1*cos(q1(2,i)) l1*cos(q1(2,i))+l2*cos(q1(2,i)+q2(2,i))],...
           '--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)
        axis equal;
        axis([0 0.5 0 0.5]);%definisanje osa bez obzira na broj koordinata  
        i=i+1;
        pause(0.01);
    end
end
