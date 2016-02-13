import random
import numpy as np
import matplotlib.pyplot as plt

N = eval(input("Please enter iteration times: "))
INCREASE = 1.02
DECREASE = 1/1.02

a = [(1) for i in range(N*500)]
b = [(0) for i in range(N*500)]
randomList = a+b
random.shuffle(randomList)

expectationList=[]

for j in range(0,N):
    price = 1
    for i in range(0,1000):
        if randomList[j*1000+i] is 1:
            price = float(INCREASE * price)
        elif randomList[j*1000+i] is 0:
            price = float(DECREASE * price)
        if i is 500:
            break
    expectationList.append(price)



print("Average Stock price when t is 500: ", float(np.mean(expectationList)))
bins = np.arange(0, 5, 0.1)
plt.hist(expectationList, bins)
plt.title("Random N * 1000 before Stock price simulation")
plt.xlabel("Stock price when t is 500")
plt.ylabel("Frequency")
plt.show()