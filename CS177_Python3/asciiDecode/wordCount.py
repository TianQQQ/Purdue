myFileC = open('c.txt', 'r')
myFileD = open('d.txt', 'w')
lines = myFileC.readlines()
sum = 0
 
for line in lines:
    global sum
    for word in line.split():
        if word == 'apple':
            sum += 1
    myFileD.write(str(sum) + '\n')
    sum = 0
 
myFileC.close()
myFileD.close()
