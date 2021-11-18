function [ Jf ] = jacobiano( l1,l2,l3,th1,th2,th3 )
Jf=[-sin(th1)*(l3*cos(th2 + th3) + l2*cos(th2)), -cos(th1)*(l3*sin(th2 + th3) + l2*sin(th2)), -l3*sin(th2 + th3)*cos(th1);
    cos(th1)*(l3*cos(th2 + th3) + l2*cos(th2)), -sin(th1)*(l3*sin(th2 + th3) + l2*sin(th2)), -l3*sin(th2 + th3)*sin(th1);
    0,             l3*cos(th2 + th3) + l2*cos(th2),           l3*cos(th2 + th3)];
end

