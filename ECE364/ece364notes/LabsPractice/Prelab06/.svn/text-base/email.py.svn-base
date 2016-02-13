#! /usr/bin/env python3.4

import sys, os, math, re

def Load_File(filename):
    f = open(filename, 'r')
    return_text = f.readlines()
    f.close()
    return return_text

def email(string):
    for i in string:
        id = re.search(r'[\w.-]+',i)
        score = re.search(r'[0-9]*\.[0-9]+',i)
        print(id.group()+'@ecn.purdue.edu'+'    '+score.group()+'/100')

def main(argv):
    str = Load_File(argv[1])
    email(str)
    return 0

if __name__ == "__main__":
    main(sys.argv)
