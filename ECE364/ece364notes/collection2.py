# l_out = [f(x) for x in l_in if predicate(x)]       
# dict_out = {key: value for x in dict_in if predicate(x)}
# set_out = {value for x in set_in if predicate(x)}


x = [4, 3, -2, 11, 0, 9]
y = [3 * i for i in x]
# y = [12, 9, -6, 33, 0, 27]

names = ['jack', 'alex', 'mike', 'john', 'nancy', 'joan']
n = [name.capitalize() for name in names if name.startswith('j')]
# n = ['Jack', 'John', 'Joan']
n = [name.capitalize() if name.startswith('j') else name for name in names ]
# n = ['Jack', 'alex', 'mike', 'John', 'nancy', 'Joan']



people = [('Steve', 'Martin', 55), ('Thomas', 'Will', 37), ('Michelle', 'Angelo', 26)]
tags = ['"{0}, {1}" is {2} years old.'.format(last, first, age) for first, last, age in people]
# ['"Martin, Steve" is 55 years old.',
# '"Will, Thomas" is 37 years old.',
# '"Angelo, Michelle" is 26 years old.']

grades = [('Juan', 68), ('Rodney', 36), ('Edward', 57), ('Christine', 98)]
highest_grade = max([grade for _, grade in grades])
# highest_grade = 98

numbers = [91, 4, 27, 74, 63]
nums = [(x, x % 3 == 0) for x in numbers]
# nums = [(91, False), (4, False), (27, True), (74, False), (63, True)]

x = [2, 3, 6]
y = [0, 4, 7]
cart_prod = [i * j for i in x for j in y]
# cart_prod = [0, 8, 14, 0, 12, 21, 0, 24, 42]
cart_prod2 = [i * j for i in x for j in y if i * j > 0] # cart_prod2 = [8, 14, 12, 21, 24, 42]
cart_prod3 = [i * j for j in y for i in x]
# cart_prod3 = [0, 0, 0, 8, 12, 24, 14, 21, 42]

values = [28, 12, 71, 64, 26, 97, 1, 7, 100, 68, 57, 92, 29, 53, 8, 13, 84, 58, 69, 90]
result = [index for index, value in enumerate(values) if value <= 50]
# result = [0, 1, 4, 6, 7, 12, 14, 15] enumerate returns an iterator of list of tuples, which can be unpacked.






# zip() and zip(* ) function
from math import sqrt
x = [2, 3, 6]; y = [0, 4, 7]; z=[0,0,0]

#for z in zip(x,y,z):
#	print (z)	
#(2, 0, 0)
#(3, 4, 0)
#(6, 7, 0)
#        print (x,y)	
#[2, 3, 6] [0, 4, 7]
#[2, 3, 6] [0, 4, 7]
#[2, 3, 6] [0, 4, 7]
dist = sqrt(sum([(i - j) ** 2 for i, j in zip(x, y)]))
# dist = 2.449489742783178

#Example 2: Unpacking a list of tuples.
rep_list = [('Juan', 68), ('Rodney', 36), ('Edward', 57), ('Christine', 98)]
names, grades = zip(*rep_list)
# names = ('Juan', 'Rodney', 'Edward', 'Christine') # grades = (68, 36, 57, 98)







# map() and filter()
def scaleBy5(v):
    return 5 * v
vec = range(0,11)
sVec = map(scaleBy5, vec)
# list(sVec) = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]

def getSquaredDiff(x, y): return x * y
lstX = [2, 3, 6]
lstY = [2, 4, 1]
pProd = map(getSquaredDiff, lstX, lstY)
# list(pProd) = [4, 12, 6]


def isEven(n):
    return (n % 2 == 0)
vec = range(0, 11)
evenVec = filter(isEven, vec)
print(list(evenVec))
# list(evenVec) = [0, 2, 4, 6, 8, 10]

d = {1 : 'a', 2: 'b', 3: 'b'}
reversedD = {value:key for key, value in d.items()}
#print(reversedD)













