clear; clc; close all;
tic
%--------------------
%-----Parametros-----
%--------------------

% ------- Posicao da base do robo -------
base.x = 0;
base.y = 0;
base.z = 0;

% ------- Tamanho dos links do braco -------
%L = [4.27;11.05;4.21];
%L=[1;1;1];
L = [0.35;1.099;0.45];

% ------- Posicao atual do braco -------
%Theta = deg2rad(360*rand(3,1));
Theta=[0 ;0; 0];
%-------- O objetivo principal G----------
G = [1 ; 1 ; 1];

% ------- Caminho ---------------------------------------------------------

N = -1.5:0.09:1.5;
Caminho.x= 10*ones(1,length(N));
Caminho.y=N;
Caminho.z= ones(1,length(N));

%----- Declara��o de Katt,Krep,eps0,deltad---------
Katt = 0.01;
Krep = 0.0005;
eps0 = 0.3;
deltad = 0.05;
ksi1 = 0.07;
ksi2 = 1e-4;
epsi=[];
Frep = [];
n=0.2;
d = 0.1; %distancia que o manipilador anda pelo comando do teclado

%------------zona de seguran�a-----------------
zonaseg.th = 0:360;
zonaseg.x = eps0 * cosd(zonaseg.th);
zonaseg.y = eps0 * sind(zonaseg.th);

%---------Posi��o do Robo----------------------
 P_J1 = double(firtjoin(L(1)));
    P_J2 = double(secondjoin(L(1),L(2),Theta(1),Theta(2)));
    P_J3 = double(thirdjoin(L(1),L(2),L(3),Theta(1),Theta(2), Theta(3)));

for i = 1:length(Caminho.y)
    G = [Caminho.x(i);Caminho.y(i);Caminho.z(i)];
    P_J1 = double(firtjoin(L(1)));
    P_J2 = double(secondjoin(L(1),L(2),Theta(1),Theta(2)));
    P_J3 = double(thirdjoin(L(1),L(2),L(3),Theta(1),Theta(2),Theta(3)));
    [Theta , flag] = cinematicainv(G,Theta,L);
    if flag == 0
        Theta = round(mod(rad2deg(Theta),360));
    else
        disp('Posicao nao alcancavel. Terminando o programa.')
        break;
    end
    
%      if (Theta(1) > 180) || (Theta(1) < 0)
%          Theta(1) = Theta(1)-180; 
%      end
%       if (Theta(2) > 180) || (Theta(2) < 0)
%          Theta(2) = Theta(2)-180; 
%       end
%      if (Theta(3) > 180) || (Theta(3) < 0)
%          Theta(3) = Theta(3)-180;  
%      end
disp(Theta)
    Theta = deg2rad(Theta);
     plot3(G(1),G(2),G(3),'or','linewidth',2,'markersize',10)
    hold on
    plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
    plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
    plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
    plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
    plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
    plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
    plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
    plot3(Caminho.x , Caminho.y ,Caminho.z ,'xg' , 'linewidth' , 2 , 'markersize' , 10)
    
    hold off
    grid
    xlabel('x')
    ylabel('y')
    axis equal
    drawnow
   
end


toc