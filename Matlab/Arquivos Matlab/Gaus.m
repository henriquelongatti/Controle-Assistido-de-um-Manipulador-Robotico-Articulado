clc;clear all;close all

n = 1000;
X = 1:n;
delt_s =1.5;
gx = gaussmf(X,[delt_s 0]);
gy =gaussmf(X,[delt_s 0]);
gz =gaussmf(X,[delt_s 0]);
obstx = gx*(rand(n)-rand(n));
obsty = gy*(rand(n)-rand(n));
obstz = gz*(rand(n)-rand(n));
obst = [obstx;obsty;obstz];

%plot(X,deltx)
plot3(obst(1,:),obst(2,:),obst(3,:),'x')
xlabel('gaussmf, P=[2 5]')


