
clc,close all,clear all
%%
% a.servoAttach(3);
% a.servoAttach(10);
% a.servoAttach(11);



%% Posição Inicial
%Theta = [pi/2;pi/2;0];

Theta = [3.1312; 0.6689; 0.6396];

%Thetadeg = round(rad2deg(Theta));
% a.servoWrite(3,Thetadeg(1));
% a.servoWrite(10,Thetadeg(2));
% a.servoWrite(11,Thetadeg(3));

%%
fprintf('\nAperte A para começar ');
%% Posicao da base do robo 
base.x = 0;
base.y = 0;
base.z = 0;

%% Tamanho dos links do braco 
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%% Objetivo Inicial
%G=[0;0;19.33];

G=[-9.7458; 0.0975; 14.9947]

%% Objetivo Global
%Gb = [5;3;10.33];
 %Gb = [5;8;15];
 Gb = [9.7458; 0.0975; 14.9947];

 
 %%Obstaculo
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

 
 
%% Passo do Manipulador
d = 4;
%% Posição Inicial Das Juntas Do Robo
P_J1 = double(firtjoin(L1));
P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
%% Vetor que Guarda Posição
Pose=[];
%%
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
plot3(Gb(1),Gb(2),Gb(3),'ok', 'linewidth' , 2 , 'markersize' , 10)
plot3(obst(1,:),obst(2,:),obst(3,:),'.k')
hold off
grid
xlabel('x')
ylabel('y')
axis([-20 20 -20 20 0 20 -1 0])
drawnow

while (st == 97)
    sprintf('-------------------------------------\nMenu Principal:\nEscolha dentre as seguintes opções:\nA para o eixo x\nB para o eixo y\nC para o eixo z\nD para sair\n-------------------------------------')
    ei= getkey;
    switch ei
        case 97
            sprintf('-------------------------------------\nMenu Secundário:\nEscolha dentre as seguintes opções:\nA 1 cm\nB -1cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('FRONT')
                    G = G + [ d ; 0 ; 0];
                    [ g, Theta ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                case 98
                    fprintf('BACK')
                    G = G + [-d ; 0 ; 0];
                    [ g, Theta ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                     
                 case 99
                     st = 97;
                 case 100
                     st = 0;
             end
        case 98
            sprintf('-------------------------------------\nMenu Secundário:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('RIGHT')
                    G = G + [0;d; 0];
                    [ g, Theta ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                case 98
                    fprintf('LEFT')
                    G = G + [0 ;-d ;0 ];
                  [ g, Theta ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                case 99
                    st = 97;
                case 100
                    st = 0;
            end
        case 99
            sprintf('-------------------------------------\nMenu Secundário:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('UP')
                    G = G + [0 ; 0; d];
                 [ g, Theta ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                case 98
                    fprintf('DOWN')
                    G = G + [0; 0; -d];
                  [ g, Theta  ,Pose] = CamposPotenciaisRobo( Theta, G,Pose ,Gb,obst);
%                     a.servoWrite(3,Thetadeg(1));
%                     a.servoWrite(10,Thetadeg(2));
%                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    disp(G);
                 case 99
                     st = 97;
                 case 100
                     st = 0;
            end
        case 100
            st = 0;
    end
    if(abs(G-Gb))<0.5
        disp('Objetivo Alcançado')
         st = 0;
        
    end
            
end

disp('FIM')
