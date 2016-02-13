__author__ = 'ee364d08'

import re

def verifySolution(filename):
    f=open (filename,'r')
    lines=f.readlines()
    Flag=True
    for line in lines:
        rlist=list(line)
        rset = set(rlist)
        if (rset != {'7', '4', '5', '9', '2', '8', '1', '3', '6'} and rset != {'7', '4', '5', '9', '2', '8', '1', '3', '6', '\n'}) :
            Flag=False
    clist=[]
    for i in range(0,len(lines[-1])):
        clist=[]
        for line in lines:
            clist.append(line[i])
        cset = set(clist)
        if (cset != {'7', '4', '5', '9', '2', '8', '1', '3', '6'}):
            Flag = False
    return Flag


def solvePuzzle(sfilename,tfilename):
    sf=open(sfilename,'r')
    lines=sf.readlines()
    tf=open(tfilename,'w')

    matrix=[[]]
    base = {'7', '4', '5', '9', '2', '8', '1', '3', '6'}
    for line in lines:
        rlist=list(line)
        rset = set(rlist)
        if (rset != {'7', '4', '5', '9', '2', '8', '1', '3', '6'} and rset != {'7', '4', '5', '9', '2', '8', '1', '3', '6', '\n'}) :
            rset.update(base.difference(rset))
    clist=[]
    for i in range(0,len(lines[-1])):
        clist=[]
        for line in lines:
            clist.append(line[i])
        cset = set(clist)
        if (cset != {'7', '4', '5', '9', '2', '8', '1', '3', '6'}):
            cset.update(base.difference(cset))
    tf=sf
    return tfilename




def getCallersOf(call):
    s = open('Students.txt','r')
    slines = s.readlines()
    c = open('Call Log.txt','r')
    clines = c.readlines()
    snlist = []
    for cline in clines[2:]:
        num = re.findall(r'\(\d\d\d\) \d\d\d\-\d\d\d\d', cline)
        if (call == num[1]):
            aim = re.search(r'\d\d\d\d', num[0])
            snlist.append(aim.group())
    slist=[]
    for sline in slines[2:]:
        name = (sline.split('|'))[0].rstrip()
        n = re.search(r'\d\d\d\d', sline)
        for item in snlist:
            if (n.group() == item):
                if name not in slist:
                    slist.append(name)
    return slist

def getCallActivity():
    s = open('Students.txt','r')
    slines = s.readlines()
    c = open('Call Log.txt','r')
    clines = c.readlines()
    dic={}
    tottime=0
    tc=0
    for sline in slines[2:]:
        counter=0
        ttime=0
        name = (sline.split('|'))[0].rstrip()
        n = re.search(r'\d\d\d\d', sline)
        for cline in clines[2:]:
            num = re.findall(r'\d\d\d\d', cline)
            time = re.findall(r'\d\d:\d\d', cline)
            min = time[0][0:2]
            sec = time[0][3:5]
            if (n.group() == num[0]):
                ttime += int(min)*60 + int(sec)
                tottime += ttime
                tc+=1
                counter+=1
        secs = int((ttime % 3600) % 60)
        mins = int((ttime % 3600) / 60)
        hours = int(ttime / 3600)
        t_o = "{0:02d}:{1:02d}:{2:02d}".format(hours, mins, secs)
        dic.update({name: (counter,t_o)})
    return dic

