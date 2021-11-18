clear; clc; close all;

Theta = [0;pi/2;pi/2];
%Theta = [3.9269;2.3462;1.5938]
fprintf('\nAperte A para começar ');
% ------- Posicao da base do robo -------
base.x = 0;
base.y = 0;
base.z = 0;

% ------- Tamanho dos links do braco -------
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%--------Objetivo------------------
G=[-4.21;0;15.12];
 
 %----------Passo do Manipulador----
 d = 1;
 


%O manipulador deve ir a posição inicial

%Constante do campo atrativo
Katt = 0.01;

%Constante do campo repulsivo
krep =7e12;

eps0 = 0.3;
deltad = 0.05;
ksi1 = 0.07;
ksi2 = 1e-4;
epsi=[];
Frep = [];
n=0.2;

zonaseg.th = 0:360;
zonaseg.x = eps0 * cosd(zonaseg.th);
zonaseg.y = eps0 * sind(zonaseg.th);

P_J1 = double(firtjoin(L1));
P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));




st = getkey;
if (st == 97)
    fprintf('\nStart');
end
plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
hold on
plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)


hold off
grid
xlabel('x')
ylabel('y')
axis equal
drawnow

while (st == 97)
    sprintf('-------------------------------------\nMenu Principal:\nEscolha dentre as seguintes opções:\nA para o eixo x\nB para o eixo y\nC para o eixo z\nD para sair\n-------------------------------------')
    ei= getkey;
    switch ei
        case 97
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
             se=getkey;
             switch se
                 case 97
                     fprintf('FRONT')
                     G = G + [ d ; 0 ; 0];
                     Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                     while Dpg > ksi1
                         
                         
                         Fatt = -Katt.*(P_J3 - G);
                         %         %------------------------------------------------------------------
                         %         %--------Em um projeto utilizando algum tipo de sensor--------------
                         %         %------------------------------------------------------------------
                         %         L = getLaserReadings(handler);
                         %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                         %         for i = 1 : 181
                         %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                         %         end
                         %
                         %         Frep = [0;0];
                         %         indices = find(epsi <= eps0);
                         %         if isempty(indices) == 0
                         %             for j = 1:size(indices)
                         %
                         %                 a = (1/epsi(indices(j)))^3;
                         %                 b = (1/epsi(indices(j))) - (1/eps0);
                         %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                         %                 Frep = Frep + Frepj;
                         %
                         %             end
                         %             Frep = krep * Frep;
                         %
                         %         end
                         %         %----------------------------------------------------------------
                         %         %----------------------------------------------------------------
                         %         %----------------------------------------------------------------
                         
                         Ftot = Fatt; % + Frep;%Força total
                         g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                         
                         Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                         if Dpg < deltad % não entendi essa parte
                             g = G;
                         end
                         Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                         Theta = deg2rad(Theta);
                         P_J1 = double(firtjoin(L1));
                         P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                         P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                         plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                         hold on
                         plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         
                         
                         hold off
                         grid
                         xlabel('x')
                         ylabel('y')
                         axis equal
                         drawnow
                     end
                 case 98
                     fprintf('BACK')
                     G = G + [-d ; 0 ; 0];
                     Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                     while Dpg > ksi1
                         
                         
                         Fatt = -Katt.*(P_J3 - G);
                         %         %------------------------------------------------------------------
                         %         %--------Em um projeto utilizando algum tipo de sensor--------------
                         %         %------------------------------------------------------------------
                         %         L = getLaserReadings(handler);
                         %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                         %         for i = 1 : 181
                         %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                         %         end
                         %
                         %         Frep = [0;0];
                         %         indices = find(epsi <= eps0);
                         %         if isempty(indices) == 0
                         %             for j = 1:size(indices)
                         %
                         %                 a = (1/epsi(indices(j)))^3;
                         %                 b = (1/epsi(indices(j))) - (1/eps0);
                         %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                         %                 Frep = Frep + Frepj;
                         %
                         %             end
                         %             Frep = krep * Frep;
                         %
                         %         end
                         %         %----------------------------------------------------------------
                         %         %----------------------------------------------------------------
                         %         %----------------------------------------------------------------
                         
                         Ftot = Fatt; % + Frep;%Força total
                         g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                         
                         Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                         if Dpg < deltad % não entendi essa parte
                             g = G;
                         end
                         Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                         Theta = deg2rad(Theta);
                         P_J1 = double(firtjoin(L1));
                         P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                         P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                         plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                         hold on
                         plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                         plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                         
                         
                         hold off
                         grid
                         xlabel('x')
                         ylabel('y')
                         axis equal
                         drawnow
                     end
                 case 99
                     st = 97;
                 case 100
                     st = 0;
             end
        case 98
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('RIGHT')
                    G = G + [0; -d; 0];
                    Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                    while Dpg > ksi1
                        
                        
                        Fatt = -Katt.*(P_J3 - G);
                        %         %------------------------------------------------------------------
                        %         %--------Em um projeto utilizando algum tipo de sensor--------------
                        %         %------------------------------------------------------------------
                        %         L = getLaserReadings(handler);
                        %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                        %         for i = 1 : 181
                        %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                        %         end
                        %
                        %         Frep = [0;0];
                        %         indices = find(epsi <= eps0);
                        %         if isempty(indices) == 0
                        %             for j = 1:size(indices)
                        %
                        %                 a = (1/epsi(indices(j)))^3;
                        %                 b = (1/epsi(indices(j))) - (1/eps0);
                        %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                        %                 Frep = Frep + Frepj;
                        %
                        %             end
                        %             Frep = krep * Frep;
                        %
                        %         end
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        
                        Ftot = Fatt; % + Frep;%Força total
                        g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                        
                        Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                        if Dpg < deltad % não entendi essa parte
                            g = G;
                        end
                        Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                        Theta = deg2rad(Theta);
                        P_J1 = double(firtjoin(L1));
                        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                        plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                        hold on
                        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        
                        
                        hold off
                        grid
                        xlabel('x')
                        ylabel('y')
                        axis equal
                        drawnow
                    end
                case 98
                    fprintf('LEFT')
                    G = G + [0 ;d ;0 ];
                    Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                    while Dpg > ksi1
                        
                        
                        Fatt = -Katt.*(P_J3 - G);
                        %         %------------------------------------------------------------------
                        %         %--------Em um projeto utilizando algum tipo de sensor--------------
                        %         %------------------------------------------------------------------
                        %         L = getLaserReadings(handler);
                        %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                        %         for i = 1 : 181
                        %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                        %         end
                        %
                        %         Frep = [0;0];
                        %         indices = find(epsi <= eps0);
                        %         if isempty(indices) == 0
                        %             for j = 1:size(indices)
                        %
                        %                 a = (1/epsi(indices(j)))^3;
                        %                 b = (1/epsi(indices(j))) - (1/eps0);
                        %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                        %                 Frep = Frep + Frepj;
                        %
                        %             end
                        %             Frep = krep * Frep;
                        %
                        %         end
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        
                        Ftot = Fatt; % + Frep;%Força total
                        g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                        
                        Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                        if Dpg < deltad % não entendi essa parte
                            g = G;
                        end
                        Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                        Theta = deg2rad(Theta);
                        P_J1 = double(firtjoin(L1));
                        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                        plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                        hold on
                        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        
                        
                        hold off
                        grid
                        xlabel('x')
                        ylabel('y')
                        axis equal
                        drawnow
                    end
                case 99
                    st = 97;
                case 100
                    st = 0;
            end
        case 99
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('UP')
                    G = G + [0 ; 0; d];
                    Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                    while Dpg > ksi1
                        
                        
                        Fatt = -Katt.*(P_J3 - G);
                        %         %------------------------------------------------------------------
                        %         %--------Em um projeto utilizando algum tipo de sensor--------------
                        %         %------------------------------------------------------------------
                        %         L = getLaserReadings(handler);
                        %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                        %         for i = 1 : 181
                        %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                        %         end
                        %
                        %         Frep = [0;0];
                        %         indices = find(epsi <= eps0);
                        %         if isempty(indices) == 0
                        %             for j = 1:size(indices)
                        %
                        %                 a = (1/epsi(indices(j)))^3;
                        %                 b = (1/epsi(indices(j))) - (1/eps0);
                        %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                        %                 Frep = Frep + Frepj;
                        %
                        %             end
                        %             Frep = krep * Frep;
                        %
                        %         end
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        
                        Ftot = Fatt; % + Frep;%Força total
                        g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                        
                        Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                        if Dpg < deltad % não entendi essa parte
                            g = G;
                        end
                        Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                        Theta = deg2rad(Theta);
                        P_J1 = double(firtjoin(L1));
                        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                        plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                        hold on
                        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        
                        
                        hold off
                        grid
                        xlabel('x')
                        ylabel('y')
                        axis equal
                        drawnow
                    end
                case 98
                    fprintf('DOWN')
                    G = G + [0; 0; -d];
                    Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                    while Dpg > ksi1
                        
                        
                        Fatt = -Katt.*(P_J3 - G);
                        %         %------------------------------------------------------------------
                        %         %--------Em um projeto utilizando algum tipo de sensor--------------
                        %         %------------------------------------------------------------------
                        %         L = getLaserReadings(handler);
                        %         Obs = [L.Sensor.globalPosition.x ; L.Sensor.globalPosition.y];
                        %         for i = 1 : 181
                        %             epsi(i) = ((Pi - Obs(:,i))'*(Pi - Obs(:,i)) ).^(1/2);
                        %         end
                        %
                        %         Frep = [0;0];
                        %         indices = find(epsi <= eps0);
                        %         if isempty(indices) == 0
                        %             for j = 1:size(indices)
                        %
                        %                 a = (1/epsi(indices(j)))^3;
                        %                 b = (1/epsi(indices(j))) - (1/eps0);
                        %                 Frepj = (a*b).*(Pi - Obs(:,indices(j)));
                        %                 Frep = Frep + Frepj;
                        %
                        %             end
                        %             Frep = krep * Frep;
                        %
                        %         end
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        %         %----------------------------------------------------------------
                        
                        Ftot = Fatt; % + Frep;%Força total
                        g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
                        
                        Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
                        if Dpg < deltad % não entendi essa parte
                            g = G;
                        end
                        Theta = round(mod(rad2deg(cinematicainv(g,Theta)),360));
                        Theta = deg2rad(Theta);
                        P_J1 = double(firtjoin(L1));
                        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                        plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                        hold on
                        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                        
                        
                        hold off
                        grid
                        xlabel('x')
                        ylabel('y')
                        axis equal
                        drawnow
                    end
                 case 99
                     st = 97;
                 case 100
                     st = 0;
            end
        case 100
            st = 0;
    end
                    
            
end

disp('FIM')
