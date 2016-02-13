__author__ = 'ee364d08'

import sys, os, math, re

def email(filename):
    f = open(filename, 'r');
    lines = f.readlines()
    f.close()
    for i in lines:
        score = re.search(r'\d\d\.\d\d', i)
        id = re.search(r'\w+', i)
        print(id.group()+ '@ecn.purdue.edu ' + score.group() + '/100')

def main(argv):
    email('Part2.in')
    return 0

if __name__ == "__main__":
    main(sys.argv)