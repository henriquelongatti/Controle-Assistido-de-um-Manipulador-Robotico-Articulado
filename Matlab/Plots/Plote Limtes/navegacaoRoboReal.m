clc; clear all; close all;

%%
% a.servoAttach(3);
% a.servoAttach(10);
% a.servoAttach(11);



%% Posi??o Inicial
Theta = [pi/2;pi/2;0];
Thetadeg = round(rad2deg(Theta));
% a.servoWrite(3,Thetadeg(1));
% a.servoWrite(10,Thetadeg(2));
% a.servoWrite(11,Thetadeg(3));

%%
fprintf('\nAperte A para come?ar ');
%% Posicao da base do robo
base.x = 0;
base.y = 0;
base.z = 0;

%% Tamanho dos links do braco
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%% Objetivo Inicial
G=[0;0;19.33];

%% Objetivo Global
%Gb = [5;3;10.33];
%Gb = [5;8;15];

%% Passo do Manipulador
d = 2;
%% Posi??o Inicial Das Juntas Do Robo
P_J1 = double(firtjoin(L1));
P_J2 = double(secondjoin(L1,L2,Theta(1),Theta(2)));
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
%% Vetor que Guarda Posi??o
Pose=[];
%%
st = getkey;
if (st == 97)
    fprintf('\nStart');
end





while (st == 97)
    sprintf('-------------------------------------\nMenu Principal:\nEscolha dentre as seguintes op??es:\nA para o eixo x\nB para o eixo y\nC para o eixo z\nD para sair\n-------------------------------------')
    ei= getkey;
    switch ei
        case 97
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes op??es:\nA 1 cm\nB -1cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('FRONT')
                    G = G + [ d ; 0 ; 0];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    
                    
             
                    G = g;
                case 98
                    fprintf('BACK')
                    G = G + [-d ; 0 ; 0];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    
                    
                 
                    G = g;
                   
                    
                case 99
                    st = 97;
                case 100
                    st = 0;
            end
        case 98
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes op??es:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('RIGHT')
                    G = G + [0;d; 0];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    
                    
            
               
                case 98
                    fprintf('LEFT')
                    G = G + [0 ;-d ;0 ];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    G = g;
                    
                    
               
      
                case 99
                    st = 97;
                case 100
                    st = 0;
            end
        case 99
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes op??es:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('UP')
                    G = G + [0 ; 0; d];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    
                    
                    
                
                    G = g;
                  
                case 98
                    fprintf('DOWN')
                    G = G + [0; 0; -d];
                    [ g, Theta, Pose ] = CamposPotenciaisRobo( Theta, G,Pose);
                    %                     a.servoWrite(3,Thetadeg(1));
                    %                     a.servoWrite(10,Thetadeg(2));
                    %                     a.servoWrite(11,Thetadeg(3));
                    
                    
                    
                    
                 
                    G = g;
                  
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
