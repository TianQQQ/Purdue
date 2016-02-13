import random
import numpy as np
import matplotlib.pyplot as plt

INCREASE = 1.02
DECREASE = 1/1.02
N = eval(input("Please enter iteration times: "))

expectationList = []

for j in range(0,100):
    x = np.arange(0, 1000, 1)
    price = 1

    a = [(1) for i in range(500)]
    b = [(0) for i in range(500)]
    randomList = a+b
    random.shuffle(randomList)

    for i in range(0,1000):
        if randomList[i] is 1:
            price = float(INCREASE * price)
        elif randomList[i] is 0:
            price = float(DECREASE * price)
        if i is 500:
            break
    expectationList.append(price)


print("Average Stock price when t is 500: ", float(np.mean(expectationList)))
bins = np.arange(0, 5, 0.1)
plt.hist(expectationList, bins)
plt.title("Simulate 1000 times for N iterations")
plt.xlabel("Stock price when t is 500")
plt.ylabel("Frequency")
plt.show()