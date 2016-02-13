import math
x = input("Please enter a file name:")
myFileB = open(x, 'r')
lines = myFileB.readlines()


def stddev(listname):
    s = 0
    std = 0
    n = len(listname)
    mean = sum(listname)/n
    for ind in range (n):
        s += (listname[ind] - mean)**2
    std = math.sqrt(s / n)
    print("mean: ",round(mean,2))
    print("stddev: ",std)
    print("\n")
    
def main():
    newlist = []
    for line in lines:
        for val in line.split():
            newlist.append(eval(val))
        stddev(newlist)
        newlist = []
main()
