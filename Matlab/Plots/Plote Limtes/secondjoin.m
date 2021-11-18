function [ f_J2] = secondjoin(l1,l2,th1,th2 )
f_J2=[l2*cos(th1)*cos(th2);
      l2*cos(th2)*sin(th1);
      l1 + l2*sin(th2)];

end

