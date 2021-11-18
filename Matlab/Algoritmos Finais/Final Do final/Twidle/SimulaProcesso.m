function [ Delta_Erro ] = SimulaProcesso( K )
Delta_Erro = 0;
tempo_simulado = 0;

%%
%% Posicao da base do robo 
base.x = 0;
base.y = 0;
base.z = 0;

%% Tamanho dos links do braco 
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%% Posição Inicial

Theta = [3.1312; 0.6689; 0.6396];
Gi=[-9.7458; 0.0975; 14.9947];

%% Objetivo Global

G = [9.7458; 0.0975; 14.9947];

%% Obstaculo
nob = 1000;
Xob = 1:nob;
%delt_sobb =1.5;
delt_sobb =1;
gx = gaussmf(Xob,[delt_sobb 0]);
gy =gaussmf(Xob,[delt_sobb 0]);
gz =gaussmf(Xob,[delt_sobb 0]);
obstx = gx*(rand(nob)-rand(nob));
obsty = gy*(rand(nob)-rand(nob));
obstz = gz*(rand(nob)-rand(nob));
obst = [obstx;obsty;obstz];
for p=1:nob
    obst(:,p) = obst(:,p) + [0;0;15];
end

%% Posição Inicial Das Juntas Do Robo
P_J1 = double(firtjoin(L1));
P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));

%% Vetor que Guarda Posição
Pose=[];

%% Constantes

Katt = K(1);
Krep = K(2);

%%
plot3(Gi(1),Gi(2),Gi(3),'or','linewidth',2,'markersize',10)
hold on
plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J1(1) , P_J1(2) , P_J1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
plot3([base.x P_J1(1)] , [base.y P_J1(2)],[base.z P_J1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J2(1) , P_J2(2) , P_J2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
plot3([P_J1(1) P_J2(1)] , [P_J1(2) P_J2(2)] , [P_J1(3) P_J2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
plot3(P_J3(1) , P_J3(2),P_J3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
plot3([P_J2(1) P_J3(1)] , [P_J2(2) P_J3(2)], [P_J2(3) P_J3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)
plot3(G(1),G(2),G(3),'ok', 'linewidth' , 2 , 'markersize' , 10)
plot3(obst(1,:),obst(2,:),obst(3,:),'.k')
hold off
grid
xlabel('x')
ylabel('y')
axis([-20 20 -20 20 0 20 -1 0])
drawnow
end

