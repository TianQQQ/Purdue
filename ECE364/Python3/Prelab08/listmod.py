__author__ = 'ee364d08'


from lists import *

Sortedl = []
first  = list(map(int,input("Enter the first list of numbers: ").split()))
second = list(map(int,input("Enter the second list of numbers: ").split()))
Median, Sortedl = find_median(first,second)
print('First list:', first)
print('Second list:', second)
print('Merged list:', Sortedl)
print('Median:', Median)
