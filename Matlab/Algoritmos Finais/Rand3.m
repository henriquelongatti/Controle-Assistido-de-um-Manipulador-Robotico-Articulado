clear all ;close all;clc
%---------------------------------
%-------Random Walk---------------
%---------------------------------


delt_s= 0.3;
x=0;
y=0;
n=50;
pose=[];
al=(rand(n,1));
g = [0;0;0];



 for i=1:n
              if al(i)<=0.166
                  al(i) = 1;
              else if al(i) <=0.3333
                      al(i) = 2;
                  else if al(i) <=0.5
                          al(i) = 3;
                      else if al(i) < 0.6667
                              al(i) = 4;
                          else if al(i) < 0.8333
                                  al(i) = 5;
                              else
                                  al(i) = 6;
                              end
                          end
                      end
                  end
              end
          
              switch al(i)
                  case 1
                     g = g + [delt_s;0;0];
                  case 2
                      g = g + [-delt_s;0;0];
                  case 3
                      g = g + [0;delt_s;0];
                  case 4
                      g = g + [0;-delt_s;0];
                  case 5
                      g = g + [0;0;-delt_s];
                  case 6
                      g = g + [0;0;delt_s];
              end
               pose=[pose,g];
    
    plot3(g(1),g(2),g(3),'o');
    hold on
    plot3(pose(1,:),pose(2,:),pose(3,:),'r');
    hold off
    axis equal
    drawnow
 end