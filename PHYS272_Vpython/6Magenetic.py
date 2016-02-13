from __future__ import division
from visual import *

# Define Constants
e=1.6e-19
oofpez=9e9
scalefactor=1e4
muzofp=1e-7
deltat=5e-10

# Initial Values

# Create Objects
atom = sphere(pos=(2e-9,0,0), radius=1e-10,color=color.cyan)
atom.q = 1*e
atom.v = vector(-4e-5,0,0)
Barrow1=arrow(pos=(0,0,-6e-10),axis=vector(0,0,0),color=color.green)
scene.autoscale = 0

Barrow2=arrow(pos=(0,0,6e-10),axis=vector(0,0,0),color=color.green)
Barrow3=arrow(pos=(0,-6e-10,0),axis=vector(0,0,0),color=color.green)
Barrow4=arrow(pos=(0,6e-10,0),axis=vector(0,0,0),color=color.green)


# Calculations

while atom.pos.x >= -2e-9:
    r1 = Barrow1.pos - atom.pos
    rmag1 = mag(r1)
    rhat1 = r1/rmag1
    B1 = muzofp*atom.q/(rmag1*rmag1) * cross(atom.v,rhat1)
    Barrow1.axis = B1*scalefactor

    r2 = Barrow2.pos - atom.pos
    rmag2 = mag(r2)
    rhat2 = r2/rmag2
    B2 = muzofp*atom.q/(rmag2*rmag2) * cross(atom.v,rhat2)
    Barrow2.axis = B2*scalefactor

    r3 = Barrow3.pos - atom.pos
    rmag3 = mag(r3)
    rhat3 = r3/rmag3
    B3 = muzofp*atom.q/(rmag3*rmag3) * cross(atom.v,rhat3)
    Barrow3.axis = B3*scalefactor

    atom.pos = atom.pos + deltat*atom.v
 


    
