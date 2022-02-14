import robo_articulado as ra
import numpy as np
import matplotlib.pyplot as plt
import geometria_analitica as ga
import time



# Em python eu posso passar um objeto como um parametro de uma função!    
def jacobiano(robo):
    return np.array([
    [-np.sin(robo.th1)*(robo.link3*np.cos(robo.th2 + robo.th3) + robo.link2*np.cos(robo.th2)), -np.cos(robo.th1)*(robo.link3*np.sin(robo.th2 + robo.th3) + robo.link2*np.sin(robo.th2)), -robo.link3*np.sin(robo.th2 + robo.th3)*np.cos(robo.th1)],
[np.cos(robo.th1)*(robo.link3*np.cos(robo.th2 + robo.th3) + robo.link2*np.cos(robo.th2)), -np.sin(robo.th1)*(robo.link3*np.sin(robo.th2 + robo.th3) + robo.link2*np.sin(robo.th2)), -robo.link3*np.sin(robo.th2 + robo.th3)*np.sin(robo.th1)],
[                                          0,             robo.link3*np.cos(robo.th2 + robo.th3) + robo.link2*np.cos(robo.th2),           robo.link3*np.cos(robo.th2 + robo.th3)]
    ])

def cine_inv(robo,G):
    # Parametros
    ksi = 1e-4
    n=0.2
    k=0


    #posição Atual do Robô

    P_J3 = robo.third_joy()
    Theta = np.array([robo.th1,robo.th2,robo.th3]) 
    EQM = np.mean((G - P_J3)**2)
    t = time.time_ns()
    while EQM > ksi:
        GradEQM = -(G - P_J3)
        J = jacobiano(robo)

        if np.linalg.det(J) == 0:
                J = J + 1e-5 * np.eye(3)
        
        GradTh = np.linalg.inv(J) @ GradEQM

        Theta = (Theta - n * GradTh)%(np.pi*2)
        robo.th1 = Theta[0]
        robo.th2 = Theta[1]
        robo.th3 = Theta[2]

        P_J3 = robo.third_joy()
        EQM = np.mean((G - P_J3)**2)
        tempo = time.time_ns()- t
        if tempo > 2* 9848623:
            break
    

    robo.th1 = Theta[0]
    robo.th2 = Theta[1]
    robo.th3 = Theta[2]

        
def test_reta(p1,p2):
    """
    robo desenha uma reta
    """
    Robo = ra.Plot_Robo(1,1,1,0,0,0)
    reta = ga.reta(p1,p2,20)
    cine_inv(Robo,p1)
    Robo.plot(0.8)
    for p in reta:
        cine_inv(Robo,p)
        Robo.plot(0.1)
        plt.close
        plt.pause(0.1)
    Robo.plot(0.8)
    plt.show()

p1 = np.array([-1,1,0])
p2 = np.array([1,1,2])
test_reta(p1,p2)





