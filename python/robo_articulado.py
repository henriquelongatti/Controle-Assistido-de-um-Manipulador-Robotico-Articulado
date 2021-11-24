import numpy as np

class Artic_Robot():
    def __init__(self,link1,link2,link3):
        self.link1 = link1
        self.link2 = link2
        self.link3 = link3

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

robo = Artic_Robot(50,50,50)
print(robo.first_joy)
print(robo.second_joy(90,90))
print(robo.third_joy(90,90,90))