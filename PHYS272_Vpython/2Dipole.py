from __future__ import division
from visual import *


#Define Constants
e = 1.6e-19
oopfez = 9e9
scalefactor = 2e-18
#Set Initial Values
Obslocation = vector(1.8e-9,1e-9,0)
theta = 0
phi = 0
r = 2e-9


#Create Objects
atom1 = sphere(pos=vector(0.5e-9,0,0), radius=1e-10,color=color.blue)
atom2 = sphere(pos=vector(-0.5e-9,0,0), radius=1e-10,color=color.red)

atom1.q = -1*e
atom2.q = 1*e

#Calculations
while r <= 10e-9:
    
    while phi < 2*pi:
        
        while theta < 2*pi:

            Obslocation = vector(r*sin(phi)*cos(theta),r*sin(phi)*sin(theta),r*cos(phi))

            r1=Obslocation-atom1.pos
            r1mag = sqrt(r1.x**2+r1.y**2+r1.z**2)
            r1hat = r1 / r1mag
            E1 = (oopfez * atom1.q)/(r1mag**2) * r1hat
            r2=Obslocation-atom2.pos
            r2mag = sqrt(r2.x**2+r2.y**2+r2.z**2)
            r2hat = r2 / r2mag
            E2 = (oopfez * atom2.q)/(r2mag**2) * r2hat
            Enet = E1 + E2
            Earrow = arrow(pos = Obslocation, axis = Enet*scalefactor, color = color.orange)
            theta = theta + pi/6
        phi = phi + pi/6
        theta = 0
    r = r + 1e-9
    phi = 0

print "The magnitude of E1 field =",mag(E1),"N/C"

print "Enet =",Enet,"N/C"
