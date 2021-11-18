function [ t, k ] = CamposPotenciaisf( Theta, G, Ob )
tic
%% Posicao da base do robo 
base.x = 0;
base.y = 0;
base.z = 0;
%% Tamanho dos links do braco
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%% Constante do campo atrativo
Katt = 0.01;

%% Constante do campo repulsivo
krep =7e12;

%%
eps0 = 0.3;
deltad = 0.05;
ksi1 = 0.07;
ksi2 = 1e-4;
epsi=[];
Frep = [];
n=0.2;

k = 0;

%% Zona de segurança
zonaseg.th = 0:360;
zonaseg.x = eps0 * cosd(zonaseg.th);
zonaseg.y = eps0 * sind(zonaseg.th);

%% Posição das Juntas

P_J1 = double(firtjoin(L1));
P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));

%% Campos Potenciais

Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
while Dpg > ksi1
    Fatt = -Katt.*(P_J3 - G);
    %% Em um projeto utilizando algum tipo de sensor
    
    
    %%
    Ftot = Fatt; % + Frep;%Força total
     g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
        
        Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
        if Dpg < deltad % não entendi essa parte
            g = G;
        end
        Theta = cinematicainvdegtra(g,Theta);
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
        k = k + 1;
     
end


t = toc;
end

