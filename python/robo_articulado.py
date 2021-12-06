import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import geometria_alalitica as ga

class Artic_Robot():
    'Robô Articulado'
    def __init__(self,link1,link2,link3,th1,th2,th3):
        self.link1 = link1
        self.link2 = link2
        self.link3 = link3
        self.th1 = th1
        self.th2 = th2
        self.th3 = th3

    @property
    def first_joy(self):
        return np.array([0,0,self.link3])

    def second_joy(self,th1,th2):
        return np.array([
            self.link2*np.cos(th1)*np.cos(th2),
            self.link2*np.cos(th2)*np.sin(th1),
            self.link1 + self.link2*np.sin(th2)
        ])

    def third_joy(self,th1,th2,th3):
        return np.array([
            np.cos(th1)*(self.link3*np.cos(th2 + th3) + self.link2*np.cos(th2)),
            np.sin(th1)*(self.link3*np.cos(th2 + th3) + self.link2*np.cos(th2)),
            self.link1 + self.link3*np.sin(th2 + th3) + self.link2*np.sin(th2)
        ])

class Plot_Robo(Artic_Robot):

    def plot(self):
        j_1 = self.first_joy
        j_2 = self.second_joy(self.th1,self.th2)
        j_3 = self.third_joy(self.th1,self.th2,self.th3)
        
        l1 = ga.reta([0,0,0],j_1)
        l2 = ga.reta(j_1,j_2,50)
        l3 = ga.reta(j_2,j_3,50)

        plt.rcParams['figure.figsize'] = (8,6)
        ax = plt.axes(projection='3d');
        ax.scatter3D([j_1[0],j_2[0],j_3[0]],
                    [j_1[1],j_2[1],j_3[1]],
                    [j_1[2],j_2[2],j_3[2]],s=1000); 

        ax.plot(l1[:,0],l1[:,1],l1[:,2])
        ax.plot(l2[:,0],l2[:,1],l2[:,2])
        ax.plot(l3[:,0],l3[:,1],l3[:,2])
   
        plt.show()


robo = Plot_Robo(0.5,0.5,0.5,30,0,0)
robo.plot()


