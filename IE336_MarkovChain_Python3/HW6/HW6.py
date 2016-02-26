import numpy
from pprint import pprint
import copy
case1 = [[.1, .2, .3, .4], [.4, .3, .2, .1], [.5, .1, .1, .3], [.25, .25, .25, .25]]
case1 = numpy.matrix(case1)
case2 = numpy.matrix(((.1, .2, .3, .4), (0, 1, 0, 0),(.5, .1,.1,.3),(.25,.25,.25,.25)))
case3 = numpy.matrix(((0, .5, 0,.5),(.5,0,.5,0), (0,.4,0,.6),(.3,0,.7,0)))
case4 = numpy.matrix(((1, 0, 0, 0),(0,1,0,0), (0,0,1,0),(0,0,0,1)))
a = [1,1,1,1]
print('\n3.1\n')
for i in range(0,50):
    a[0] *=case1
print(a[0])

print('\n3.2\n')
for i in range(0,50):
    a[1] *=case2
print(a[1])

print('\n3.3\n')
for i in range(0,50):
    a[2] *=case3
print(a[2])

print('\n3.4\n')
for i in range(0,50):
    a[3] *=case4
print(a[3])

print('For interesting case 4, I find when the transition matrix is identity. It automatically becomes a steady state matrix.')

print('\n\n4.')
Matrix = [[0.729,0.081,0.081,0.009,0.081,0.009,0.009,0.001],[0.81,0,0.09,0,0.09,0,0.01,0]
,[0.81,0.09,0,0,0.09,0.01,0,0]
,[0,0.9,0,0,0,0.1,0,0]
,[0.81,0.09,0.09,0.01,0,0,0,0]
,[0,0.9,0,0.1,0,0,0,0]
,[0,0,0.9,0.1,0,0,0,0]
,[0,0,0,1,0,0,0,0]]

#pprint(Matrix)
Matrix = numpy.matrix(Matrix)
a = 1
for i in range(0,1000):
    a *= Matrix
print(a)
