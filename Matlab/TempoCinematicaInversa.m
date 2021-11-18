clc;clear all;close all

t = zeros(1,105);

L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

Theta=[0;0;0];
G =[ 1.7100;
    2.9618;
   17.2855];

for n = 1:105
    Theta=[0;0;0];
    G =[ 1.7100;
    2.9618;
   17.2855];
    tic;
    [Theta,k] = cinematicainvdegtra(G,Theta);
    t(n) = toc;
end


for k = 1:100
   tn(k) =t(4+k); 
end

media = mean(t)*10^3;
devio = std(t)*10^3;

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
axis([0 100 0 0.004])