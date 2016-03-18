import copy as cp
import numpy as np
from pprint import pprint as pp

l1 =[4,5,6]
l2 = cp.copy(l1)
l3 = cp.deepcopy(l1)
mymap = {"Original": l1, "Copy": l2, "deep copy": l3}
l1[0] = 10
pp(mymap)

l5 = [9,8,7]
map1 = {'IN': l5}
map2 = map1
map3 = cp.copy(map1)
map4 = cp.deepcopy(map1)
l5[0] = 100
print(map1['IN'])
print(map2['IN'])
print(map3['IN'])
print(map4['IN'])





