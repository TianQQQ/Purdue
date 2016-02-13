__author__ = 'ee364d08'

import re,os,sys,math


def isValidName(string):
    a = re.search(r'[_A-Za-z1-9]', string[0])
    if a is None:
        return False
    else:
        b = re.search(r'[?]', string)
        if b is None:
            return True
        else:
            return False

def parsePinAssignment(asmt):
    a = re.search(r'\.\w{1,}\([_A-Za-z0-9]{1,}\)', asmt)
    if a is None:
        raise ValueError()
    else:
        b = re.findall(r'[_a-zA-Z0-9]{1,}', a.group())
        return tuple(b)

def parseNetLine(line):
    p1 = re.search(r'\({2,}', line)
    p2 = re.search(r'\)\)', line)
    p4 = re.search(r'\) \)', line)
    p5 = re.search(r'\){3,}', line)
    p6 = re.search(r'\) \)\)', line)
    q1 = re.search(r'\?', line)
    p3 = re.search(r'%', line)
    if p1 is not None or  q1 is not None or p3 is not None or p5 is not None or p6 is not None:
        raise ValueError()
    if p2 is None and p4 is None:
        raise ValueError()

    a = line.split(',')
    b = []
    for element in a:
        b.append(parsePinAssignment(element))
    c = re.findall(r'[_0-9a-zA-Z]{1,}', line)
    if len(c) != (len(b)*2 + 2):
        raise ValueError()
    else:
        return c[0],c[1],tuple(b)



