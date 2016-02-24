import numpy
from pprint import pprint as pp
case1 = [[.1, .2, .3, .4], [.4, .3, .2, .1], [.5, .1, .1, .3], [.25, .25, .25, .25]]
pp(case1)

case1 = numpy.matrix(case1)
print(case1)
a = case1





for i in range(0,50):
    a *=case1
print(a)
