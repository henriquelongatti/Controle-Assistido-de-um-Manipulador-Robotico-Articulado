import numpy as np

for d in np.arange(0,2*np.pi,0.1):
    if (d >= 0 and d  <= (2/3)* np.pi)or(d > (4/3)*np.pi and d < 2*np.pi):
            print("{0:.2f}  {1:.2f} {2:.2f}".format(d,(2/3)* np.pi,(4/3)*np.pi ))
    else:
        print('-')
    