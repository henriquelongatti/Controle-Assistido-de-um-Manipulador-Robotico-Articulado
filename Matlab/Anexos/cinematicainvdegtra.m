function [ Theta ,k] = cinematicainvdegtra( G ,T )

Theta = T;
%% Tamanho dos links do braco
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

%% Parâmetros

ksi = 1e-4;
n=0.2;
k=0;

%% Posição da Ferramenta de Trabalho
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
    %% Erro Quadratico Medio atual
    EQM = mean((G - P_J3).^2);
    k=k+1;
    t =toc;
    if(t>0.1)
        EQM = ksi;
    end
    
end

end
