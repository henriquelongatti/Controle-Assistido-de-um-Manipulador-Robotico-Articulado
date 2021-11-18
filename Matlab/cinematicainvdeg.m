function [ Theta ,k] = cinematicainvdeg( G ,T )


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
    P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2),Theta(3)));
    % Erro Quadratico Medio atual
    EQM = mean((G - P_J3).^2);
    k=k+1;
end
Theta = mod(Theta,2*pi);

Theta = atan2(sin(Theta),cos(Theta));
% 
% if Theta(1)<0;
%     Theta(1)= Theta(1)+pi;
% end
% 
% if Theta(2)<0;
%     Theta(2)= Theta(2)+pi;
% end
% 
% if Theta(3)<0;
%     Theta(3)= Theta(3)+pi;
% end

% if acot(cot(Theta(1)))<0
%     Theta(1)= -Theta(1);
% end
% 
% if acot(cot(Theta(2)))<0
%     Theta(2)= -Theta(2) ;
% end
% 
% if acot(cot(Theta(3)))<0
%     Theta(3)= -Theta(3);
% end
% 
% Theta = acot(cot(Theta))
% 
% if atan(tan(Theta(1)))<0
%     Theta(1)= -Theta(1);
% end
% 
% if atan(tan(Theta(2)))<0
%     Theta(2)= -Theta(2) ;
% end
% 
% if atan(tan(Theta(3)))<0
%     Theta(3)= -Theta(3);
% end
% 
% % Theta = [atan(tan(Theta(1)));atan(tan(Theta(2)));atan2(tan(Theta(3)))];
%  Theta = atan(tan(Theta));
end
