__author__ = 'ee364d08'
#! /usr/bin/env python3.4
from pprint import pprint

def getUserPermissions():
    file = open('Permissions.txt','r')
    lines = file.readlines()
    user=[]
    contr=[]
    dic={}
    final=[]
    for line in lines[2:]:
        elements = line.split(':')
        user= (elements[0].split())[0]
        contr = (elements[1].split())[0]
        final.append(contr)
        if user in dic:
            dic.update({user: set(final)})
        else:
            dic[user] = contr
            final=[]
            final.append(contr)
    #pprint(dic)
    return dic

def getControllerActions():
    file = open('Users.txt','r')
    lines = file.readlines()
    dic=getUserPermissions()
    dic1={
            'Wiki' : {},
            'Reports' : {}
    }
    list=[]
    list2=[]
    for line in lines[2:]:
        element=line.split()
        name=element[0]+' '+element[1]
        id=element[3]
        if 'Wiki' in dic[id]:
            list.append(name)
        if 'Reports' in dic[id]:
            list2.append(name)
    dic1.update({'Wiki' : set(list)})
    dic1.update({'Reports' : set(list2)})
    pprint(dic1)
    return dic1






def getControllerActions():
    file = open('ActivityLog.txt','r')
    lines = file.readlines()
    contr=[]
    dic={}
    page=[]
    final=[]
    for line in lines:
        elements = line.split('/')
        page = elements[4]
        contr = elements[3]
        page = page[0:5]
        final.append(page)
        if contr in dic:
            dic.update({contr: set(final)})
        else:
            dic[contr] = page
            final=[]
            final.append(page)
    #pprint(dic)
    return dic

def parseLogFile():
    file = open('ActivityLog.txt','r')
    lines = file.readlines()
    list=[]
    for line in lines:
        elements = line.split('/')
        id=(elements[0].split())[0]
        page = elements[4]
        contr = elements[3]
        web=(line.split())[2]
        page = page[0:5]
        list.append((id, web, contr, page, True))
   # print(list)
    return(list)

def canGrantAccess(userID, url):
    dic = getUserPermissions()
    file = open('ActivityLog.txt','r')
    lines = file.readlines()
    list=[]
    for line in lines:
        elements = line.split('/')
        id=(elements[0].split())[0]
        contr = elements[3]
        web=(line.split())[2]
        if (id == userID):
            if(url == web):
                if contr in dic[id]:
                    return True
    return False

def checkUserActivity(userID):
    dic = getUserPermissions()
    file = open('ActivityLog.txt','r')
    lines = file.readlines()
    list=[]
    for line in lines:
        elements = line.split('/')
        id=(elements[0].split())[0]
        page = elements[4]
        contr = elements[3]
        if (id==userID):
            if contr in dic[id]:
                a=True
            else:
                a=False
            web=(line.split())[2]
            list.append((web, a))
    pprint(list)
    return(list)

def getActivityByUser():
    file = open('Users.txt','r')
    lines = file.readlines()
    dic=getUserPermissions()
    dic1={}
    list=[]
    list2=[]
    countt=0
    countf=0
    for line in lines[2:]:
        element=line.split()
        name=element[0]+' '+element[1]
        id=element[3]
        list=checkUserActivity(id)
        for i in list:
            if i[1] == True:
                countt +=1
            else:
                countf +=1
        dic1.update({name: (countt, countf)})
        countt=0
        countf=0

    return dic1


def getActivityByController():
    file = open('Users.txt','r')
    lines = file.readlines()
    dic=getUserPermissions()
    dic1={}
    list=[]
    list2=[]
    countt=0
    countf=0
    for line in lines[2:]:
        element=line.split()
        name=element[0]+' '+element[1]
        id=element[3]
        list=checkUserActivity(id)
        for i in list:
            if i[1] == True:
                countt +=1
            else:
                countf +=1
        dic1.update({name: (countt, countf)})
        countt=0
        countf=0
    return dic1






















