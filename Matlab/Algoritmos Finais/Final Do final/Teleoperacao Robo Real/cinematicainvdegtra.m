function [ Theta ,k] = cinematicainvdegtra( G ,T )
tic

%--------------------
%-----Parametros-----
%--------------------
Theta = T;
% ------- Tamanho dos links do braco -------
% L1 = L(1);
% L2 = L(2);
% L3 = L(3);

L1 = 4.07;
L2 = 11.05;
L3 = 4.21;
%----- Declaração de Katt,Krep,eps0,deltad---------

ksi = 1e-4;
n=0.2;
k=0;

%---------Posição do Robo----------------------
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2),Theta(3)));
EQM = mean((G - P_J3).^2);
while EQM > ksi
    GradEQM = -(G - P_J3);
    J = double(jacobiano(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
    if det(J) == 0
        J = J + 1e-5 * eye(size(J));
    end
    GradTh = inv(J) * GradEQM;
    Theta = Theta - n * GradTh;
%     Theta = mod(Theta,2*pi);
%     Theta(Theta > pi) = Theta(Theta > pi) - 2*pi; 
%     Theta = atan2(sin(Theta),cos(Theta));
%      if(Theta(1) < 0)||(Theta(2) < 0)||(Theta(3) < 0)
%         Theta = abs(Theta);
%     end
    P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2),Theta(3)));
    % Erro Quadratico Medio atual
    EQM = mean((G - P_J3).^2);
    k=k+1;
    t =toc;
    if(t>0.1)
        EQM = ksi;
    end
    
end

end
