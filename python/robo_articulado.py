import numpy as np

def first_joy(l1):
    return np.array([0,0,l1])

def second_joy(l1,l2,th1,th2):
    return np.array([
        l2*np.cos(th1)*np.cos(th2),
        l2*np.cos(th2)*np.sin(th1),
        l1 + l2*np.sin(th2)
    ])

def third_joy(l1,l2,l3,th1,th2,th3):
    return np.array([
        np.cos(th1)*(l3*np.cos(th2 + th3) + l2*np.cos(th2)),
        np.sin(th1)*(l3*np.cos(th2 + th3) + l2*np.cos(th2)),
        l1 + l3*np.sin(th2 + th3) + l2*np.sin(th2)

    ])

j3 = third_joy(50,100,100,np.pi,np.pi/2,np.pi)
print(j3)