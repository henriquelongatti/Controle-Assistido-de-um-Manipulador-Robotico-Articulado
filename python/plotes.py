from errno import EISCONN
from tkinter import E
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import geometria_analitica as ga

plt.rcParams['figure.figsize'] = (8,6)
ax = plt.axes(projection='3d');
ax.set(xlim3d=(-2, 2), xlabel='X')
ax.set(ylim3d=(-2, 2), ylabel='Y')
ax.set(zlim3d=(-2, 2), zlabel='Z')

class eixo():
    def __init__(self):
        self.o = np.array([0,0,0,1])
        self.xi = np.array([1,0,0,1])
        self.yi = np.array([0,1,0,1])
        self.zi = np.array([0,0,1,1])

    def pitch(self,th):
        self.xi = np.array([
            [1,0,0,0],
            [0,np.cos(th),-np.sin(th), 0],
            [0,np.sin(th),np.cos(th),0],
            [0,0,0,1]
            ]) @ self.xi

        self.yi = np.array([
            [1,0,0,0],
            [0,np.cos(th),-np.sin(th), 0],
            [0,np.sin(th),np.cos(th),0],
            [0,0,0,1]
            ]) @ self.yi
        
        self.zi = np.array([
            [1,0,0,0],
            [0,np.cos(th),-np.sin(th), 0],
            [0,np.sin(th),np.cos(th),0],
            [0,0,0,1]
            ]) @ self.zi
        
    def yaw(self,th):
        self.xi = np.array([
            [np.cos(th), -np.sin(th), 0, 0],
            [np.sin(th), np.cos(th), 0, 0 ],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ])@ self.xi

        self.yi = np.array([
            [np.cos(th), -np.sin(th), 0, 0],
            [np.sin(th), np.cos(th), 0, 0 ],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ])@ self.yi

        self.zi = np.array([
            [np.cos(th), -np.sin(th), 0, 0],
            [np.sin(th), np.cos(th), 0, 0 ],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ])@ self.zi
    
    def roll(self,th):
        self.xi = np.array([
            [np.cos(th), 0, np.sin(th), 0],
            [0, 1, 0, 0],
            [-np.sin(th), 0, np.cos(th), 0],
            [0, 0, 0,1]
        ])@ self.xi

        self.yi = np.array([
            [np.cos(th), 0, np.sin(th), 0],
            [0, 1, 0, 0],
            [-np.sin(th), 0, np.cos(th), 0],
            [0, 0, 0,1]
        ])@ self.yi

        self.zi = np.array([
            [np.cos(th), 0, np.sin(th), 0],
            [0, 1, 0, 0],
            [-np.sin(th), 0, np.cos(th), 0],
            [0, 0, 0,1]
        ])@ self.zi

    def plot(self,trans):
        eixo_x = ga.reta(self.o,self.xi)
        eixo_y = ga.reta(self.o,self.yi)
        eixo_z = ga.reta(self.o,self.zi)



        ax.scatter3D(self.xi[0],self.xi[1],self.xi[2],marker = 'o',s=50,color=(0.1,0.1,0.1),alpha = trans)
        ax.scatter3D(self.yi[0],self.yi[1],self.yi[2],marker = 'o',s=50,color=(0.1,0.1,0.1),alpha = trans)
        ax.scatter3D(self.zi[0],self.zi[1],self.zi[2],marker = 'o',s=50,color=(0.1,0.1,0.1),alpha = trans)

        ax.plot(eixo_x[:,0],eixo_x[:,1],eixo_x[:,2],color=(0.07, 0.03, 0.53),alpha = trans)
        ax.plot(eixo_y[:,0],eixo_y[:,1],eixo_y[:,2],color=(0.07, 0.03, 0.53),alpha = trans)
        ax.plot(eixo_z[:,0],eixo_z[:,1],eixo_z[:,2],color=(0.07, 0.03, 0.53),alpha = trans)


def teste_pitch():
    e = eixo()
    e.pitch(0)
    e.plot(0.8)

    for d in np.ones(10)*((np.pi/2)/10):
        e.pitch(d)
        e.plot(0.1)
        plt.pause(0.1)
        
    e.plot(0.8)
    print(np.array(np.ones(10)*((np.pi/2)/10)))
    plt.show()

def teste_yaw():
    e = eixo()
    e.yaw(0)
    e.plot(0.8)

    for d in np.ones(10)*((np.pi/2)/10):
        e.yaw(d)
        e.plot(0.1)
        plt.pause(0.1)
        
    e.plot(0.8)
    print(np.array(np.ones(10)*((np.pi/2)/10)))
    plt.show()

def teste_roll():
    e = eixo()
    e.roll(0)
    e.plot(0.8)

    for d in np.ones(10)*((np.pi/2)/10):
        e.roll(d)
        e.plot(0.1)
        plt.pause(0.1)
        
    e.plot(0.8)
    print(np.array(np.ones(10)*((np.pi/2)/10)))
    plt.show()


#teste_pitch()
#teste_yaw()
#teste_roll()