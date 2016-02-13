#! /usr/bin/env python3.4
__author__ = 'ee364d08'

def checkTypes(l):
    if type(l) == str:
        return None
    icounter=0
    fcounter=0
    scounter=0
    for i in range(len(l)):
         if type(l[i]) == int:
             icounter+=1
         elif type(l[i]) == float:
             fcounter+=1
         elif type(l[i]) == str:
             scounter+=1
    a=[icounter, fcounter, scounter]

    if a != [0,0,0]:
        return a
    else:
        return None

def normalizeVector(l):
    if l==[]:
        return None
    if type(l) == str:
        return None
    sum=0
    for i in range(len(l)):
        sum+=l[i]
    for i in range(len(l)):
        l[i] = l[i] / sum
    return l


def findMedian(l):
    for i in range(len(l)):
        if type(l[i]) == str:
            return None
    if l==[]:
        return None
    if type(l) == str:
        return None
    l=sorted(l)
    print(l)
    med=0
    k = len(l) % 2
    if k == 0:
        a = len(l)/2
        med = (l[int(a)] + l[int(a-1)])/2
    else:
        a = (len(l)+1)/2
        med = (l[int(a)])
    return med

def rectifySignal(l):
    for i in range(len(l)):
        if type(l[i]) == str:
            return None
    if l==[]:
        return None
    if type(l) == str:
        return None
    for i in range(len(l)):
        if l[i] < 0:
            l[i]=0
    return l

def convertToBoolean(l):
    if l > 256:
        return None
    lis=[]
    a=0
    newlis=[]
    for i in range(8):
        a=l%2
        if a==1:
            lis.append(True)
        else:
            lis.append(False)
        l=int(l/2)
    for i in range(0,8):
        newlis.append(lis[7-i])
    print(newlis)
    return newlis

def convertToInteger(l):
    if l==[]:
        return None
    for i in range(len(l)):
        if type(l[i]) == int:
            return None
    sum=0
    for i in range(len(l)):
        a=2**(7-i)*l[i]
        sum+=a
    return sum

def switchNames(l):
    if l==[]:
        return None
    if type(l) != list:
        return None
    retlist=[]
    a=[]
    b=[]
    k=[]
    for i in range(len(l)):
        a=l[i].split()
        k=a[0].split(",")
        b=a[1]+" " +k[0]
        retlist.append(b)
    return retlist



def getWeightAverage(l):
    if l==[]:
        return None
    if type(l) != list:
        return None
    retlist=[]
    a=[]
    aver=0
    sum=0
    for i in range(len(l)):
        a=l[i].split()
        sum+=float(a[2])
    aver=sum/len(l)
    return aver




















