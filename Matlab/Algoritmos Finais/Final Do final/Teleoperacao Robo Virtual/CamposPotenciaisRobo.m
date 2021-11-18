function [ g, Theta , Pose] = CamposPotenciaisRobo( Theta, G,Pose,x,y,z )
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

%%

%deltad = 0.05;
deltad = 0.1;
ksi1 = 0.07;


Cont = 0;

% Gaus

n = 50;
X = 1:n;
delt_s =3;
%delt_s =5;
gx = gaussmf(X,[delt_s 0]);
gy =gaussmf(X,[delt_s 0]);
gz =gaussmf(X,[delt_s 0]);
deltx = gx*(rand(n)-rand(n));
delty = gy*(rand(n)-rand(n));
deltz = gz*(rand(n)-rand(n));

%% Posição das Juntas

% P_J1 = double(firtjoin(L1));
% P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));

%%Vetor Aleatório
V=[];


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
       % Theta = mod(Theta , 2*pi);
        if (max(Theta > 2*pi) < 1)
        %if (max(Theta >  1.7453) < 1)
        %if (max(Theta(1) > pi) < 1)&&(max(Theta(2) > pi) < 1)&& (max(Theta(3) > 1.7453) < 1)
           
            %Thetadeg = round(rad2deg(Theta));
           
        
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
        surf(x,y,z)
        
        hold off
        grid
        xlabel('x')
        ylabel('y')
        axis([-20 20 -20 20 0 20 -1 0])
%         %legend(sprintf('x: %.2f\ny:%.2f\nz:%.2f',G(1),G(2),G(3)));
        
        drawnow
      
       
        
        else
           
          Cont = Cont+1;
     
          for i=1:n
              
              g1 = g + [deltx(i);delty(i);deltz(i)];
              Theta = cinematicainvdegtra(g1,Theta);
              Theta = mod(Theta , 2*pi);
              %if (max(Theta > pi) < 1)
             if (max(Theta(1) > pi) < 1)&&(max(Theta(2) > pi) < 1)&& (max(Theta(3) > 1.7453) < 1)
                  V=[V,Theta];
              end
              
          end
           
            
            C = size(V);
            ind =C(2)-1;
            if isempty(V) == 0
                disp('=D')
                Theta = V(:,round(ind)+1);
                Thetadeg = round(rad2deg(Theta));
                         
                P_J1 = double(firtjoin(L1));
                P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
                P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
                Pose = [Pose , P_J3];
                plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
                hold on
                plot3(Gb(1),Gb(2),Gb(3),'ok','linewidth',2,'markersize',10)
                plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
                plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
                plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
                plot3(Pose(1,:),Pose(2,:),Pose(3,:),'r' , 'linewidth' , 2 , 'markersize' , 10)
                surf(x,y,z)
                hold off
                grid
                xlabel('x')
                ylabel('y')
                %legend(sprintf('x: %.2f\ny:%.2f\nz:%.2f',G(1),G(2),G(3)));
        
                axis([-20 20 -20 20 0 20 -1 0])
                drawnow
                V=[];
                
                if(Cont>2)
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

