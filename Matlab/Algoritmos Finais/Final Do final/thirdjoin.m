function [ f_J3 ] = thirdjoin( l1,l2,l3,th1,th2,th3 )
f_J3=[cos(th1)*(l3*cos(th2 + th3) + l2*cos(th2));
    sin(th1)*(l3*cos(th2 + th3) + l2*cos(th2));
     l1 + l3*sin(th2 + th3) + l2*sin(th2)];


end

