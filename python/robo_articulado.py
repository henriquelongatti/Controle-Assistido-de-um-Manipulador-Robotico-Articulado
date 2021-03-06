import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import geometria_analitica as ga
import matplotlib.animation as animation


plt.rcParams['figure.figsize'] = (8,6)
ax = plt.axes(projection='3d');
ax.set(xlim3d=(-3, 3), xlabel='X')
ax.set(ylim3d=(-3, 3), ylabel='Y')
ax.set(zlim3d=(-3, 3), zlabel='Z')

class Artic_Robot():
    'Robô Articulado'
    """
    Essa classe cria um robô articulado de três juntas. Ela usa transformações Homogêneas 
    para calcular todas suas posições.
    Os valores de angulos das juntas do robô devem estar no intervalos de 0 a 2pi
    """
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

    
    def second_joy(self):
        """
        Na segunda junta eu coloquei um limite para evitar colisões entre o próprio robô. O robô
        não chega nas posições entre 7/6*pi e 11/6*pi.
        """
        if (self.th2 >= 0 and self.th2  <= (7/6)* np.pi)or(self.th2 > (11/6)*np.pi and self.th2 < 2*np.pi):
            return np.array([
                self.link2*np.cos(self.th1)*np.cos(self.th2),
                self.link2*np.cos(self.th2)*np.sin(self.th1),
                self.link1 + self.link2*np.sin(self.th2)
            ])
        else:
            if self.th2 < (3/2)*np.pi:
                self.th2 = (7/6)*np.pi
                return np.array([
                    self.link2*np.cos(self.th1)*np.cos(self.th2),
                    self.link2*np.cos(self.th2)*np.sin(self.th1),
                    self.link1 + self.link2*np.sin(self.th2)
                ])
            else:
                self.th2 = (11/6)* np.pi
                return np.array([
                    self.link2*np.cos(self.th1)*np.cos(self.th2),
                    self.link2*np.cos(self.th2)*np.sin(self.th1),
                    self.link1 + self.link2*np.sin(self.th2)
                ])

        
    
    def third_joy(self):
        """
        Na terceira junta eu coloquei um limite para evitar colisões entre o próprio robô. O robô
        não chega nas posições entre 2/3*pi e 4/3*pi.
        """

        if (self.th3 >= 0 and self.th3  <= (2/3)* np.pi)or(self.th3 > (4/3)*np.pi and self.th3 < 2*np.pi):
            return np.array([
                np.cos(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                np.sin(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                self.link1 + self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)
                ])
        else:
            if self.th3 < np.pi:
                self.th3 = (2/3)*np.pi
                return np.array([
                    np.cos(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                    np.sin(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                    self.link1 + self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)
                ])
            else:
                self.th3 = (4/3)*np.pi
                return np.array([
                    np.cos(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                    np.sin(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)),
                    self.link1 + self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)
                ])


class Plot_Robo(Artic_Robot):
    """
    Essa classe é usada apenas para testes. Ela herda da classe Artic_Robot e faz uma simulação
    do comportamento do robô.
    """
    def plot(self,trans):

        j_1 = self.first_joy
        j_2 = self.second_joy()
        j_3 = self.third_joy()
        
        l1 = ga.reta([0,0,0],j_1)
        l2 = ga.reta(j_1,j_2,50)
        l3 = ga.reta(j_2,j_3,50)

       
        ax.scatter3D([j_1[0],j_2[0]],
                    [j_1[1],j_2[1]],
                    [j_1[2],j_2[2]],s=100,color=(0.07, 0.03, 0.53),alpha = trans) 
        ax.scatter3D(j_3[0],j_3[1],j_3[2],marker = '.',s=50,color=(0.1,0.1,0.1),alpha = 0.8)

        
        ax.plot(l1[:,0],l1[:,1],l1[:,2],color=(0.07, 0.03, 0.53),alpha = trans)
        ax.plot(l2[:,0],l2[:,1],l2[:,2],color=(0.07, 0.03, 0.53),alpha = trans)
        ax.plot(l3[:,0],l3[:,1],l3[:,2],color=(0.07, 0.03, 0.53),alpha = trans)



def test_joy1():
    """
    Testa a primeira junta do robô para os valores entre 0 a 2*pi e mostra seu comportamento.
    """
    robo = Plot_Robo(1,1,1,0,0,np.pi/2)
    robo.plot(0.8)
    for d in np.arange(0,2*np.pi,0.1):
        robo.th1 = d
        robo.plot(trans=0.1)
        plt.pause(0.001)
    robo.plot(0.8)        
        
        
    plt.show()
    
def test_joy2():
    """
    Testa a segunda junta do robô para os valores entre 0 a 2*pi e mostra seu comportamento.
    """
    robo = Plot_Robo(1,1,1,0,0,np.pi/2)
    robo.plot(0.8)
    for d in np.arange(0,2*np.pi,0.1):
        robo.th2 = d
        robo.plot(0.1)
        plt.close
        plt.pause(0.001)
    robo.plot(0.8)
    plt.show()

def test_joy3():
    """
    Testa a terceira  junta do robô para os valores entre 0 a 2*pi e mostra seu comportamento.
    """
    robo = Plot_Robo(1,1,1,0,0,0)
    robo.plot(0.8)
    for d in np.arange(0,2*np.pi,0.1):
        robo.th3 = d
        robo.plot(0.1)
        plt.close
        plt.pause(0.001)
    robo.plot(0.8)
    plt.show()




#test_joy1()

#test_joy2()
#test_joy3()


