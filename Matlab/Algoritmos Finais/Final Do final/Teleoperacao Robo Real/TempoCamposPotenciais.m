clc, close all,clear all

t = zeros(1,105);

L1 = 4.07;
L2 = 11.05;
L3 = 4.21;



for n = 1:105
    G=[0;0;19.33];
    G = G + [0;0;-2];
    Theta = [pi/2;pi/2;0];
    tic
    [ g, Theta, Thetadeg ] = CamposPotenciaisRobo( Theta, G);
    t(n) = toc;
end

for k = 1:100
   tn(k) =t(4+k); 
end

median = mean(tn)*10^3;
devion = std(tn)*10^3;

figure('color',[1,1,1])
bar(t)
grid
title(sprintf('Média: %.2f ms; Desvio Padrão: %.2f ms',media,devio ));
xlabel('Amostragem')
ylabel('Tempo(s)')
axis([0 100 0 0.02])

figure('color',[1,1,1])
bar(tn)
grid
title(sprintf('Média: %.2f ms; Desvio Padrão: %.2f ms',median,devion ));
xlabel('Amostragem')
ylabel('Tempo(s)')
axis([0 100 0 0.001])