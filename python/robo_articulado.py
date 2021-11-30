import numpy as np
import matplotlib.pyplot as plt

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
        plt.rcParams['figure.figsize'] = (8,6)
        ax = plt.axes(projection='3d');
        ax.scatter3D([j_1[0],j_2[0],j_3[0]],
                    [j_1[1],j_2[1],j_3[1]],
                    [j_1[2],j_2[2],j_3[2]],s=1000); 
    
   
        plt.show()

robo = Plot_Robo(0.5,0.5,0.5,0,60,120)
robo.plot()

'''
robo = Artic_Robot(0.05,0.05,0.05)
j_1 = robo.first_joy
j_2 = robo.second_joy(90,90)
j_3 = robo.third_joy(90,90,90)

print(j_1)
print(j_2)
print(j_3)

plt.rcParams['figure.figsize'] = (8,6)
ax = plt.axes(projection='3d');
ax.scatter3D([j_1[0],j_2[0],j_3[0]],
            [j_1[1],j_2[1],j_3[1]],
            [j_1[2],j_2[2],j_3[2]]); 
   
plt.show() 
'''