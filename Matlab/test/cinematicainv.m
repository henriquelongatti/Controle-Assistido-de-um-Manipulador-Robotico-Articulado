function [ Theta , flag_pipino ] = cinematicainv( G ,T ,L)


%--------------------
%-----Parametros-----
%--------------------
Theta = T;
% ------- Tamanho dos links do braco -------

%----- Declaração de Katt,Krep,eps0,deltad---------

ksi = 1e-4;
n=0.1;

%---------Posição do Robo----------------------
P_J3 = double(thirdjoin(L(1),L(2),L(3),Theta(1),Theta(2),Theta(3)));
EQM = mean((G - P_J3).^2);
flag_pipino = 0;
t = 0;
while EQM > ksi
    tic;
    GradEQM = -(G - P_J3);
    J = double(jacobiano(L(1),L(2),L(3),Theta(1),Theta(2), Theta(3)));
    if det(J) == 0
        J = J + 1e-5 * eye(size(J));
    end
    GradTh = inv(J) * GradEQM;
    Theta = Theta - n * GradTh;
    P_J3 = double(thirdjoin(L(1),L(2),L(3),Theta(1),Theta(2),Theta(3)));
    % Erro Quadratico Medio atual
    EQM = mean((G - P_J3).^2);
    t = t + toc;
    if t > 10
        %disp('Posicao nao alcancavel.')
        flag_pipino = 1;
        break
    end
end
% Theta(3)=Theta(3)+pi/2;% Devido a construção do robo
end

