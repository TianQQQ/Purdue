from __future__ import division
from visual import *


#Define Constants
e = 1.6e-19
oopfez = 9e9
scalefactor = 3e-12
#Set Initial Values
Obslocation = vector(0,0,0)

#Create Objects
atom1 = sphere(pos=vector(-500e-9,0,0), radius=10e-9,color=color.red)
atom2 = sphere(pos=vector(600e-9,0,0), radius=10e-9,color=color.red)
atom3 = sphere(pos=vector(-1.7121e-7,0,0), radius=10e-9,color=color.red)

atom1.q = 12*e
atom2.q = 5*e
atom3.q = -e
Earrow = arrow(pos=Obslocation, axis=vector(0,0,0), color=color.cyan)

#Calculations
r1 = Earrow.pos - atom1.pos
r1mag = sqrt(r1.x**2+r1.y**2+r1.z**2)
r1hat = r1 / r1mag
E1 = (oopfez * atom1.q)/(r1mag**2) * r1hat
r2 = Earrow.pos - atom2.pos
r2mag = sqrt(r2.x**2+r2.y**2+r2.z**2)
r2hat = r2 / r2mag
E2 = (oopfez * atom2.q)/(r2mag**2) * r2hat
r3 = Earrow.pos - atom3.pos
r3mag = sqrt(r3.x**2+r3.y**2+r3.z**2)
r3hat = r3 / r3mag
E3 = (oopfez * atom3.q)/(r3mag**2) * r3hat
Enet = E1 + E2 + E3
Earrow.axis = scalefactor * Enet


print "The magnitude of E1 field =",mag(E1),"N/C"

print "Enet =",Enet,"N/C"
