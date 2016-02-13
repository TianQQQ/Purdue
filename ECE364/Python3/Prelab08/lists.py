#! /usr/bin/env python3.4

import sys, os, math, pprint
import numpy

def find_median(list1, list2):
    if (len(list1 + list2) % 2) == 0:
        return int((numpy.median((list1 + list2)[0:-1]))), sorted(list1 + list2)
    else:
        return int(numpy.median(list1 + list2)), sorted(list1 + list2)



def main():
    first  = list(map(int,input("Enter the first list of numbers: ").split()))
    second = list(map(int,input("Enter the second list of numbers: ").split()))
    Median, Sortedl = find_median(first,second)
    print('First list:', first)
    print('Second list:', second)
    print('Merged list:', Sortedl)
    print('Median:', Median)

if __name__ == "__main__":
    main()