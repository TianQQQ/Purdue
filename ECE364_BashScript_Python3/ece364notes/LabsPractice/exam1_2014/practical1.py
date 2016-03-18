#! /usr/bin/env python3.4

import sys
import os, math
import glob
import pprint

def getLargestProduct():
    f = open("Number Grid.txt","r")
    numbers = f.readlines()
    f.close()
    maxval = 0
    product = 0
    number_set = []
    for i in numbers:
        i = i.split();
        for j in range(16):
            product = int(i[j])*int(i[j+1])*int(i[j+2])*int(i[j+3])
            if (product > maxval):
                maxval = product
                number_set = [int(i[j]),int(i[j+1]),int(i[j+2]),int(i[j+3])]
                orientation = "H"
    new_numbers = []
    for i in numbers:
        i = i.split();
        new_numbers.append(i)
    for i in range(20):
        for j in range(16):
            product = int(new_numbers[i][j]) * int(new_numbers[i][j+1]) * int(new_numbers[i][j+2]) * int(new_numbers[i][j+3])
            if (product > maxval):
                maxval = product
                number_set = [int(new_numbers[i][j]), int(new_numbers[i][j+1]), int(new_numbers[i][j+2]), int(new_numbers[i][j+3])]
                orientation = "V"
                                                                             
    return (number_set,maxval,orientation)

def getDirectory():
    f = open("Phone Directory.txt", "r")
    phonebook = f.readlines()
    dic = {}
    for i in phonebook:
        i = i.split()
        name = (i[0],i[1],i[2])
        phone = i[3]+" "+i[4]
        if name in dic:
            dic.update({name: phone})
        else:
            dic.update({name: phone})
        #print(name, phone)
    return dic

def getPhoneByPartialName(partialName):
    f = open("Phone Directory.txt","r")
    phonebook = f.readlines()
    list = []
    for i in phonebook:
        i = i.split()
        name = (i[0],i[2])
        phone = i[3]+" "+i[4]
        if partialName in name:
            list.append(phone)
    return list

def reverseLookup(areaCode):
    f = open("Phone Directory.txt","r")
    phonebook = f.readlines()
    list = []
    for i in phonebook:
        i = i.split()
        name = (i[0],i[1],i[2])
        area_code = i[3]
        if areaCode == area_code[1:4]:
            list.append(name)
    return list
def main():
    a = getLargestProduct()
    #pprint.pprint(a)
    b = getDirectory()
    #pprint.pprint(b)
    c = getPhoneByPartialName("Wood")
    #pprint.pprint(c)
    d = reverseLookup("307")
    #pprint.pprint(d)

if __name__ == "__main__":
    main()
