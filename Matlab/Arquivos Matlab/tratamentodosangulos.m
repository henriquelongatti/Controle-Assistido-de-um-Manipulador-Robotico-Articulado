clc; clear all;close all

L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

Theta=[0;0;0];

G=[4;5;12];

ksi = 1e-4;
n=0.2;
k=0;

%---------Posição do Roboz
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
    Theta = mod(Theta,2*pi);
    Theta = atan2(sin(Theta),cos(Theta));
    if(Theta(1) < 0)||(Theta(2) < 0)||(Theta(3) < 0)
        Theta = abs(Theta);
    end
    P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2),Theta(3)));
    % Erro Quadratico Medio atual
    EQM = mean((G - P_J3).^2);
    k=k+1;
end
Thetadeg = round(rad2deg(Theta))


