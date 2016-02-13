from __future__ import division
from visual import *

# Define Constants
e=1.6e-19
oofpez=9e9
scalefactor=1e-5
L = 4
N = 100000
Q = 12e-6
deltax = L/N
deltaq = Q/N
obs = vector(-1.6e-2,-3e-2,0)
x = -L/(2*N) * (N-1)


# Initial Values
Enet = vector(0,0,0)


# Create Objects
while x < L/2 :
    sphere(pos=(x,0,0), radius=.1,color=color.cyan)
    x=x+deltax

    

# Calculations
x = -L/(2*N) * (N-1)
while x < L/2 :
    r = mag(obs - vector(x,0,0))
    Emag = oofpez*deltaq/(r**2)
    E = vector((obs.x-x)/r*Emag,obs.y/r*Emag,0)
    x=x+deltax
    Enet = Enet + E
Epointmag = oofpez*(2e-8)/((3.8e-2)**2)
Epoint = vector(Epointmag,0,0)
Enet = Enet + Epoint

Earrow = arrow(pos = obs, axis = Enet*scalefactor, color = color.orange)
    
print("Enet=")
print(Enet)
print("\nMagnitude of Enet=")
print(Enet.mag)
