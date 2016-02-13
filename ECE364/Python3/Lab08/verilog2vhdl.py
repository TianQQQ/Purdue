__author__ = 'ee364d08'

from vtools import *


def convertLine(line):
    try:
        a = list(parseNetLine(line))
        b = list(a[2])
        string = a[1] + ': ' + a[0] + ' PORT MAP('
        for i in b:
            x = list(i)
            string += x[0] + '=>' + x[1] + ', '
        string = string[0:-2] + ');'
        return string
    except ValueError:
        return 'Error: Bad Line.'
    finally:
        pass


def convertFile(so, ac):
    so = open(so, 'r')
    ac = open(ac, 'w')
    slines = so.readlines()
    a = []
    for line in slines:
        a.append(convertLine(line))
    c = '\n'.join(a)
    ac.write(c)
