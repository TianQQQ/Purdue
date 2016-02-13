import random
import numpy as np
import matplotlib.pyplot as plt

INCREASE = 1.02
DECREASE = 1/1.02

x = np.arange(0, 1000, 1)
price = 1


a = [(1) for i in range(500)]
b = [(0) for i in range(500)]
randomList = a+b
random.shuffle(randomList)


y=[]
for i in range(0,1000):
    if randomList[i] is 1:
        price = float(INCREASE * price)
    elif randomList[i] is 0:
        price = float(DECREASE * price)
    y.append(price)

print(y)
plt.plot(x, y)
plt.show()