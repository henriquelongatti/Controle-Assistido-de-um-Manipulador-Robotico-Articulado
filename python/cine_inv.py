import robo_articulado as ra
import numpy as np

class Cine_Inver(ra.Plot_Robo):
    @property
    def jacobiano(self):
        return np.array([
           [-np.sin(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)), -np.cos(self.th1)*(self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)), -self.link3*np.sin(self.th2 + self.th3)*np.cos(self.th1)],
     [np.cos(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)), -np.sin(self.th1)*(self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)), -self.link3*np.sin(self.th2 + self.th3)*np.sin(self.th1)],
     [                                          0,             self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2),           self.link3*np.cos(self.th2 + self.th3)]
        ])

robo = Cine_Inver(1,1,1,0,0,0)
print(robo.jacobiano)
