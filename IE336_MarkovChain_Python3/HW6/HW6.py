import numpy
from pprint import pprint
import copy
case1 = [[.1, .2, .3, .4], [.4, .3, .2, .1], [.5, .1, .1, .3], [.25, .25, .25, .25]]
case1 = numpy.matrix(case1)
case2 = numpy.matrix(((.1, .2, .3, .4), (0, 1, 0, 0),(.5, .1,.1,.3),(.25,.25,.25,.25)))
case3 = numpy.matrix(((0, .5, 0,.5),(.5,0,.5,0), (0,.4,0,.6),(.3,0,.7,0)))
a = [1,1,1]
for i in range(0,50):
    a[0] *=case1
print(a[0])

for i in range(0,50):
    a[1] *=case2
print(a[1])

for i in range(0,50):
    a[2] *=case3
print(a[2])


'''
case1 = copy.copy(case1)
pprint(case1)
'''
