import matplotlib.pyplot as pyplot
 
pos1 = [1,2,3,4,5]
data1 = [10, 16,20,30,40]
 
bar1 = pyplot.bar(pos1, data1, width=1, color='yellow', align='center')
 
pyplot.savefig('test.png')
