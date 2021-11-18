%%Teste Tempo campos potenciais

clear; clc; close all

%%
% a.servoAttach(3);
% a.servoAttach(10);
% a.servoAttach(11);


%% Posicao da base do robo 
base.x = 0;
base.y = 0;
base.z = 0;
%% Tamanho dos links do braco
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;
%% Theta Inicial
%Theta = [ 0 ;0 ;0];
%Theta = [ 0.1451; 0.3051; 2.5870];
%Theta = [0.1082; 1.3784; 1.1987]
Theta = deg2rad(180*rand(3,1));
%Theta = [1.7191; 0.4355 ;0.4690];
%Theta = [0.2618; 0.4189; 0.5585];
%% Objetivo
G = [1.7100; 2.9618; 17.2855];
%G = [10;0;10]
%G=[6;4;10];
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
Pose = [];


%Gaux = 0;

%% Zona de segurança
zonaseg.th = 0:360;
zonaseg.x = eps0 * cosd(zonaseg.th);
zonaseg.y = eps0 * sind(zonaseg.th);

%% Obstaculo


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
        
        %% Se a posição anterior for parecida com a atual
%         if ((g-Gaux)'*(g-Gaux)).^(1/2)>0.001%abs(g-Gaux)<[ 0.001;0.001;0.001]
%             g = g + 3*rand(3,1);
%             disp('=/')
%         end
            
        
        
        %%
        
        Theta = cinematicainvdegtra(g,Theta);
        Theta = mod(Theta , 2*pi);
        if (max(Theta > pi) < 1)
        %if (Theta(1) < pi)&&(Theta(2) < pi)&&((Theta(3) > 3*pi/2)||(Theta(3)==0)||(Theta(3) < pi/2))
            Thetadeg = round(rad2deg(Theta))
%             a.servoWrite(3,Thetadeg(1));
%             a.servoWrite(10,Thetadeg(2));
%             a.servoWrite(11,Thetadeg(3));
        
        P_J1 = double(firtjoin(L1));
        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
        Pose = [Pose , P_J3];
        plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
        hold on
        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
        
        hold off
        grid
        xlabel('x')
        ylabel('y')
        axis equal
        drawnow
        Gaux = g;
       
        
        else
            disp('Posicao inalcancavel, escolha outra')
            % Aqui voce faz o seu algoritmo que busca um ponto randomico
            % em uma regiao proxima do ponto que voce queria chegar (o g
            % atual) mas que eh inalcancavel)
            % 1. Chute uma posicao aleatoria proxima do ponto inalcancavel
            % Cuidado para nao chutar uma posicao muito proxima do
            % obstaculo que o Campos Potenciais recusatia.
            % 2. Calcule a cinematica inversa para esse ponto aleatorio
            % 3. Se os Theta forem tranquilos e favoraveis, mova seu robo
            % para la, Senao, chute outro ponto aleatorio.
            % 4. Tente um numero N de vezes ate desistir. ex: 500
            % 5. Se desistir, retorne uma mensage dizendo que arregou.
            
            Dpg = ksi1;
        end
     
end
