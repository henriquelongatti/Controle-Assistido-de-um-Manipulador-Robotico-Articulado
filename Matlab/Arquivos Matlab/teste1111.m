 clc; clear all;close all

L1 = 4.07;
L2 = 11.05;
L3 = 4.21;

% a.servoAttach(3);
% a.servoAttach(10);
% a.servoAttach(11);

poseDireto1 = firtjoin( L1 );
poseDireto2 = secondjoin(L1,L2,0,pi/3 );
poseDireto3 = thirdjoin( L1,L2,L3,pi/3,pi/3,pi/3 );

Theta=[0;0;0];

G = poseDireto3;
%G=[4;5;12];

tic
[Theta,k] = cinematicainvdegtra(G,Theta);
toc

Thetadeg = round(rad2deg(Theta))
%Thetadeg = round(rad2deg(mod(Theta , 2*pi)))

poseInv1 = firtjoin( L1 );
poseInv2 = secondjoin(L1,L2,Theta(1),Theta(2) );
poseInv3 = thirdjoin( L1,L2,L3,Theta(1),Theta(2),(Theta(3)) );

base.x = 0;
base.y = 0;
base.z = 0;

% a.servoWrite(3,Thetadeg(1));
% a.servoWrite(10,Thetadeg(2));
% a.servoWrite(11,Thetadeg(3)+90);

figure('color',[1,1,1])
plot3(G(1) , G(2) , G(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
hold on

% plot3(poseDireto1(1) , poseDireto1(2) , poseDireto1(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
% plot3([base.x poseDireto1(1)] , [base.y poseDireto1(2)],[base.z poseDireto1(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
% plot3(poseDireto2(1) , poseDireto2(2) , poseDireto2(3) , 'ob' , 'linewidth' , 2 , 'markersize' , 10)
% plot3([poseDireto1(1) poseDireto2(1)] , [poseDireto1(2) poseDireto2(2)] , [poseDireto1(3) poseDireto2(3)] , 'b' , 'linewidth' , 2 , 'markersize' , 10)
% plot3(poseDireto3(1) , poseDireto3(2),poseDireto3(3) , 'xb' , 'linewidth' , 2 , 'markersize' , 10)
% plot3([poseDireto2(1) poseDireto3(1)] , [poseDireto2(2) poseDireto3(2)], [poseDireto2(3) poseDireto3(3)], 'b' , 'linewidth' , 2 , 'markersize' , 10)

plot3(poseInv3(1) , poseInv3(2),poseInv3(3) , 'xk' , 'linewidth' , 2 , 'markersize' , 12)
plot3(poseInv1(1) , poseInv1(2) , poseInv1(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
plot3([base.x poseInv1(1)] , [base.y poseInv1(2)],[base.z poseInv1(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)
plot3(poseInv2(1) , poseInv2(2) , poseInv2(3) , 'ok' , 'linewidth' , 2 , 'markersize' , 10)
plot3([poseInv1(1) poseInv2(1)] , [poseInv1(2) poseInv2(2)] , [poseInv1(3) poseInv2(3)] , 'k' , 'linewidth' , 2 , 'markersize' , 10)

plot3([poseInv2(1) poseInv3(1)] , [poseInv2(2) poseInv3(2)], [poseInv2(3) poseInv3(3)], 'k' , 'linewidth' , 2 , 'markersize' , 10)
plot3(base.x , base.y, base.z , 'sk' , 'linewidth' , 2 , 'markersize' , 10)

title(sprintf('O Algoritmo teve %.2d iterações',k));
hold off
grid
xlabel('X')
ylabel('Y')
zlabel('Z')
legend('Objetivo','End-Effector','Junta','Link','Location','northwest')
axis equal
drawnow