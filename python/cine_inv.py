import robo_articulado as ra
import numpy as np
import matplotlib.pyplot as plt


class Cine_Inver(ra.Plot_Robo):
    @property
    def jacobiano(self):
        return np.array([
           [-np.sin(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)), -np.cos(self.th1)*(self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)), -self.link3*np.sin(self.th2 + self.th3)*np.cos(self.th1)],
     [np.cos(self.th1)*(self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2)), -np.sin(self.th1)*(self.link3*np.sin(self.th2 + self.th3) + self.link2*np.sin(self.th2)), -self.link3*np.sin(self.th2 + self.th3)*np.sin(self.th1)],
     [                                          0,             self.link3*np.cos(self.th2 + self.th3) + self.link2*np.cos(self.th2),           self.link3*np.cos(self.th2 + self.th3)]
        ])

    def cine_inv(self,G):
        # Parametros
        ksi = 1e-4
        n=0.2
        k=0

        #Criando o Objeto Robo
        Robo_inv = ra.Artic_Robot(self.link1,self.link2,self.link3,self.th1,self.th2,self.th3)

        #posição Atual do Robô

        #usa o mesmo robo !!!!  Descubra como
        P_J3 = Robo_inv.third_joy(self.th1,self.th2,self.th3)
        Theta = np.array([Robo_inv.th1,Robo_inv.th2,Robo_inv.th3])
        EQM = np.mean((G - P_J3)**2)
        
        while EQM > ksi:
            GradEQM = -(G - P_J3)
            J = self.jacobiano

            if np.linalg.det(J) == 0:
                 J = J + 1e-5 * np.eye(3)
            
            GradTh = np.linalg.inv(J) @ GradEQM

            Theta = (Theta - n * GradTh)%(np.pi*2)
            Robo_inv.th1 = Theta[0]
            Robo_inv.th2 = Theta[1]
            Robo_inv.th3 = Theta[2]

            P_J3 = Robo_inv.third_joy(Theta[0],Theta[1],Theta[0])
            EQM = np.mean((G - P_J3)**2)

        self.th1 = Theta[0]
        self.th2 = Theta[1]
        self.th3 = Theta[2]

        




G = np.array([-1.0000000e+00, -0.0000000e+00 , 1.2246468e-16])
test = Cine_Inver(1,1,1,0,0,0)
test.cine_inv(G)
test.plot()
plt.show()
"""
#-------Teste-----------------
G = np.array([1,1,1])
Robo = ra.Plot_Robo(1,1,1,0,0,0)
PJ_3 = Robo.third_joy()
EQM = np.mean((PJ_3 - G)**2)
print(EQM)
"""