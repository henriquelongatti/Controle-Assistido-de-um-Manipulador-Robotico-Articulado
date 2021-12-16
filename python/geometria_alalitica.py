import numpy as np

def reta(p1,p2,n = 10):
    v = p2 - p1
    t = np.linspace(0,1,n)
    x = p1[0] + t*v[0]
    y = p1[1] + t*v[1]
    z = p1[2] + t*v[2]
    return np.array([x,y,z]).T


