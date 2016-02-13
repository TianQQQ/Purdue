__author__ = 'ee364d08'

import sys, os, math, re

def finder(filename):
    f = open(filename, 'r');
    lines = f.readlines()
    f.close()
    for line in lines:
        first = re.search(r'^\w{3}', line)
        if (first != None):
            if (first.group() == 'def'):
                arg = re.findall(r'[a-z0-9A-Z=_]{1,}', line)
                print(arg[1])
                for i in range(2, len(arg)):
                    print('Arg' + str(i-1) + ':' + arg[i])

def main(argv):
    finder('module1.py')
    return 0

if __name__ == "__main__":
    main(sys.argv)