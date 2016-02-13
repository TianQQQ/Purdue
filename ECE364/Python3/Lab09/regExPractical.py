__author__ = 'ee364d08'

import re, os, sys, math
from pprint import pprint as pp


def getAttributes(xml):
    a = re.findall(r'\w{1,}', xml)
    b = []
    if (a[0] == 'person'):
        b.append((a[6], a[7]))
        b.append((a[4], a[5]))
        b.append((a[1], a[2] + ' ' + a[3]))
    if (a[0] == 'student'):
        b.append((a[1], a[2] + ' ' + a[3] + ' ' + a[4]))
        b.append((a[8], a[9] + '.' + a[10]))
        b.append((a[5], a[6] + ' ' + a[7]))
    if (a[0] == 'book'):
        b.append((a[1], a[2] + ' ' + a[3] + '\'' + a[4]))
        b.append((a[9], '$' + a[10] + '.' + a[11]))
        b.append((a[5], a[6] + ' ' + a[7] + ' ' + a[8]))
    return b

def getAddressParts(url):
    a = re.findall(r'[a-zA-Z0-9.]{1,}', url)
    if (len(a) == 4) and (a[0] == 'https' or a[0] == 'http') and ('.' not in a[2]) and ('.' not in a[3]):
        return a[1], a[2], a[3]
    return None

def getOptions(c):
    a = re.findall(r'\-[a-z] {1,}[a-zA-Z0-9.:/]{1,}', c)
    r = []
    for element in a:
        b = element[1]
        c = re.findall(r'[a-zA-Z0-9.:/]{1,}', element)
        r.append((b, c[1]))
    r.sort()
    return r

def getNumber(s):
    a = re.search(r'[+1-9]{1,2}\.[0-9]{1,}[Ee]{1}[+-]{1}[0-9]{1,}', s)
    if a is not None:
        return a.group()
    return None



