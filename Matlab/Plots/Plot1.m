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
%Theta = deg2rad(180*rand(3,1));
%Theta = [1.7191; 0.4355 ;0.4690];
%Theta = [0.2618; 0.4189; 0.5585];
Theta = [ 1.0821; 1.5533; 1.2217];
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

Cont = 0;


%Gaux = 0;
% 
 %% RandomWalk
% delt_s= 0.2;
% n=50;
% al=(rand(n,1));
%% Gaus

n = 100;
X = 1:n;
delt_s =3;
gx = gaussmf(X,[delt_s 0]);
gy =gaussmf(X,[delt_s 0]);
gz =gaussmf(X,[delt_s 0]);
deltx = gx*(rand(n)-rand(n));
delty = gy*(rand(n)-rand(n));
deltz = gz*(rand(n)-rand(n));

%% Zona de segurança
zonaseg.th = 0:360;
zonaseg.x = eps0 * cosd(zonaseg.th);
zonaseg.y = eps0 * sind(zonaseg.th);

%% Obstaculo

%%Vetor Aleatório
V=[];
G1=[];

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
            Thetadeg = round(rad2deg(Theta));
%             a.servoWrite(3,Thetadeg(1));
%             a.servoWrite(10,Thetadeg(2));
%             a.servoWrite(11,Thetadeg(3));
        
        P_J1 = double(firtjoin(L1));
        P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
        Pose = [Pose , P_J3];
        plot3(G(1),G(2),G(3),'ob','linewidth',2,'markersize',10)
        hold on
        plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xk' , 'linewidth' , 2 , 'markersize' , 10)
        plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'k' , 'linewidth' , 2 , 'markersize' , 10)
        plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
        
        hold off
        grid
        xlabel('x')
        ylabel('y')
        axis equal
        drawnow
      
       
        
        else
           
          Cont = Cont+1;
          %%
          %             for n=1:10
          %                 g = g + 0.3*rand(3,1)-0.3*rand(3,1);
          %                 Theta = cinematicainvdegtra(g,Theta);
          %                 if (max(Theta > pi) < 1)
          %                     V=[V,Theta];
          %                 end
          %             end
          %%
          
          %%
          for i=1:n
%               if al(i)<=0.166
%                   al(i) = 1;
%               else if al(i) <=0.3333
%                       al(i) = 2;
%                   else if al(i) <=0.5
%                           al(i) = 3;
%                       else if al(i) < 0.6667
%                               al(i) = 4;
%                           else if al(i) < 0.8333
%                                   al(i) = 5;
%                               else
%                                   al(i) = 6;
%                               end
%                           end
%                       end
%                   end
%               end
%           
%               switch al(i)
%                   case 1
%                      g1 = g + [delt_s;0;0];
%                   case 2
%                       g1 = g + [-delt_s;0;0];
%                   case 3
%                       g1 = g + [0;delt_s;0];
%                   case 4
%                       g1 = g + [0;-delt_s;0];
%                   case 5
%                       g1 = g + [0;0;delt_s];
%                   case 6
%                       g1 = g + [0;0;-delt_s];
%               end
              g1 = g + [deltx(i);delty(i);deltz(i)];
            
              %%
              G1 = [G1,g1];
           
%               plot3(G(1),G(2),G(3),'ob','linewidth',2,'markersize',10)
%                 hold on
%                 plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xk' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'k' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
%                    plot3(G1(1,:),G1(2,:),G1(3,:),'kx');
%                 hold off
%                 grid
%                 xlabel('x')
%                 ylabel('y')
%                 axis equal
%                 drawnow
              
              Theta = cinematicainvdegtra(g1,Theta);
              Theta = mod(Theta , 2*pi);
              if (max(Theta > pi) < 1)
                  V=[V,Theta];
              end
%               G1=[];
              
              
          
              
              
              
          end
          
           x = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
          
           plot3(G(1),G(2),G(3),'ob','linewidth',2,'markersize',10)
                hold on
                 plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xk' , 'linewidth' , 2 , 'markersize' , 10)
                 plot3(G1(1,:),G1(2,:),G1(3,:),'g.');
                   plot3(x(1),x(2),x(3),'xr', 'linewidth' , 4 , 'markersize' , 10); 
                     plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
                     plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
              
                
                plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
                plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
               
                plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'k' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
                   plot3(G1(1,:),G1(2,:),G1(3,:),'g.');
                   plot3(x(1),x(2),x(3),'xr', 'linewidth' , 4 , 'markersize' , 10); 
                  
                hold off
                grid
                xlabel('x')
                ylabel('y')
                legend('Objetivo','End-Effector','Posição Aleatória','Posição Viável','Junta','Link','Location','northwest')
                axis equal
                drawnow
%           
%               plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
%                 hold on
%                 plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(P_J3(1) , P_J3(2),P_J3(3) , 'ob' , 'linewidth' , 5 , 'markersize' , 10)
%                 plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
%                 plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
%                    plot3(G1(1,:),G1(2,:),G1(3,:),'y.');
%                 hold off
%                 grid
%                 xlabel('x')
%                 ylabel('y')
%                 axis equal
%                 drawnow
            %%
            
            C = size(V);
            ind =C(2)-1;
            if isempty(V) == 0
                disp('=D')
                Theta = V(:,round(ind)+1)
                Thetadeg = round(rad2deg(Theta));
                %             a.servoWrite(3,Thetadeg(1));
                %             a.servoWrite(10,Thetadeg(2));
                %             a.servoWrite(11,Thetadeg(3));
                
                Pose = [Pose , P_J3];
                
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
                V=[];
                
                if(Cont>5)
                    disp('Posicao inalcancavel, escolha outra')
                    Dpg = ksi1;
                end
            else
                 disp('Posicao inalcancavel, escolha outra')
                 Dpg = ksi1;
                
            end
            
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
            
            
            
        end
     
end