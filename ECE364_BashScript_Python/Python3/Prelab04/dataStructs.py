#! /usr/bin/env python3.4
__author__ = 'ee364d08'


import glob
import filecmp
from pprint import pprint as pp


def getWordFrequency():
    files = glob.glob('files/*.txt')
    text=""
    dic = {}
    for file in files:
        myfile = open(file, 'r')
        for string in myfile:
            for s in string:
                if(s != '.' and s!= ','):
                    text += s
        myfile.close()
    words = text.split()
    #print(words)
    for word in words:
        if word in dic:
            dic[word] +=1
        else:
            dic[word] = 1
    #pp(dic)
    return dic

def getDuplicates():
    files = glob.glob('files/*.txt')
    dic = {}
    for file in files:
        found = 0
        #print(dic)
        for key in dic:
            name = 'files/'+key+'.txt'
            if(filecmp.cmp(file,name)):
                dic[key].append(file[6:9])
                found = 1
        if(found == 0):
            dic[file[6:9]] = [file[6:9]]        # {'03C': ['03C']}
    for key in dic:
        unique = {}
        text = ""
        f = open('files/'+key+'.txt')
        for string in f:
            for s in string:
                if(s != '.' and s != ','):
                    text += s
        words = text.split()
        for word in words:
            if word in dic:     # word count
                unique[word] += 1
            else:
                unique[word] = 1
        dic.update({key:(len(unique),dic.get(key))})  # ,get(key) is the current elements
    return dic

def getPurchaseReport():
    ini_f = glob.glob('purchases/I*.txt')
    Iitem=[]
    Ifile = open(ini_f[0], 'r')
    Ilines = Ifile.readlines()
    for i in Ilines[2:]:
        Iitem.append(i.split())
    files = glob.glob('purchases/p*.txt')
    dic={}
    for file in files:
        sum=0
        Bfile = open(file,'r')
        Bitem = []
        Blines = Bfile.readlines()
        for line in Blines[2:]:
            Bitem.append(line.split())
        for i in Ilines[2:]:
            for j in Blines[2:]:
                price = i.split()
                q = j.split()
                if price[0] == q[0]:    # same item
                    sum += round(float((price[1].split('$'))[1]) * float(q[1]), 2)
        name = int(file[19:22])
        dic[name] = sum
        Bfile.close()
    return dic

def getTotalSold():
    ini_f = glob.glob('purchases/I*.txt')
    Iitem=[]
    Ifile = open(ini_f[0], 'r')
    Ilines = Ifile.readlines()
    for i in Ilines[2:]:
        Iitem.append(i.split())
    files = glob.glob('purchases/p*.txt')
    dic={}
    for i in Iitem:
        dic[i[0]] = 0
    for file in files:
        sum=0
        Bfile = open(file,'r')
        Bitem = []
        Blines = Bfile.readlines()
        for line in Blines[2:]:
            Bitem.append(line.split())
        for i in Bitem:
            if i[0] in dic:
                dic[i[0]] += int(i[1])
    return dic







