# calculate 5 random array mean

import random
 
def calculate():
   total = 0
   for i in range(100):
      temp = random.randrange(11)
      total += temp
   return total
 
arr = []
for i in range(100):
   temp = calculate()
   arr.append(temp)
 
print(sum(arr)/len(arr))
