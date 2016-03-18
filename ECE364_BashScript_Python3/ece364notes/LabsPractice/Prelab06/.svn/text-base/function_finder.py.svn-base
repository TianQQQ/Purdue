#! /usr/bin/env python3.4

import sys, os, math, re, os.path

def Load_File(filename):
    f = open(filename,'r')
    return_str = f.readlines()
    f.close()
    return return_str

def function_finder(string):
    for i in string:
        temp = re.match(r'\w{3}',i)
        if(temp != None):
            if(temp.group() == 'def'):
                func = re.match(r'(?P<def>[\w]{3})\s(?P<name>[\w.-_]{1,})\((?P<param>[\w.=-_,\s]{1,})',i)
                parameters = re.findall(r'[\w.=-_]{1,}',func.group("param"))
                print(func.group("name"))
                argn = 0
                for i in parameters:
                    argn += 1
                    print('Arg{}:'.format(argn),i)
                

def main(argv):
    if(len(argv) != 2):
        print('Usage: ./python3.4 function_finder.py <input_file>')
        return 1
    if(os.path.isfile(argv[1]) and os.access(argv[1], os.R_OK)):
        str = Load_File(argv[1])
    else:
        print('Error: Could not read',argv[1])
        return 1
    function_finder(str)
    return 0

if __name__ == "__main__":
    main(sys.argv)
