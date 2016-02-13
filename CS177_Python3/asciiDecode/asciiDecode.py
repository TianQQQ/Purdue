# generate b.txt which has 200 char by decoding of a.txt

myFileA = open('a.txt', 'r')
myFileB = open('b.txt', 'w')
lines = myFileA.readlines()
 
for line in lines:
    val = int(line)
    myFileB.write(chr(val) + '\n')
 
myFileA.close()
myFileB.close()
