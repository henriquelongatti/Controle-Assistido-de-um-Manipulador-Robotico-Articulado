function [ g, Theta, Thetadeg ] = CamposPotenciaisRobo( Theta, G)

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

%% Gaus

n = 50;
X = 1:n;
delt_s =3;
gx = gaussmf(X,[delt_s 0]);
gy =gaussmf(X,[delt_s 0]);
gz =gaussmf(X,[delt_s 0]);
deltx = gx*(rand(n)-rand(n));
delty = gy*(rand(n)-rand(n));
deltz = gz*(rand(n)-rand(n));

%% Posição das Juntas
P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));

%%Vetor Aleatório
V=[];


%% Campos Potenciais

Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);

while Dpg > ksi1
    Fatt = -Katt.*(P_J3 - G);
    %% Em um projeto utilizando algum tipo de sensor
    
    
    %%
    Ftot = Fatt; 
    g = P_J3 + (deltad/norm(Ftot)) .* Ftot;
    
    Dpg = ((P_J3-G)'*(P_J3-G)).^(1/2);
    if Dpg < deltad
        g = G;
    end
    
    
    Theta = cinematicainvdegtra(g,Theta);
    Theta = mod(Theta , 2*pi);
    if (max(Theta(1) > pi) < 1)&&(max(Theta(2) > pi) < 1)&& (max(Theta(3) > 1.7453) < 1)
        
        Thetadeg = round(rad2deg(Theta));
        
        P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
    else
        
        Cont = Cont+1;
        
        for i=1:n
            
            g1 = g + [deltx(i);delty(i);deltz(i)];
            Theta = cinematicainvdegtra(g1,Theta);
            Theta = mod(Theta , 2*pi);
            
            if (max(Theta(1) > pi) < 1)&&(max(Theta(2) > pi) < 1)&& (max(Theta(3) > 1.7453) < 1)
                V=[V,Theta];
            end
            
        end
        
        
        C = size(V);
        ind =C(2)-1;
        if isempty(V) == 0
         
            Theta = V(:,round(ind)+1);
            Thetadeg = round(rad2deg(Theta));
            P_J3 = double(thirdjoin(L1,L2,L3,Theta(1),Theta(2), Theta(3)));
            V=[];
            
            if(Cont>2)
               
                Dpg = ksi1;
            end
        else
          
            Dpg = ksi1;
            
        end
        
    end
end

