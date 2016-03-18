#! /usr/bin/env python3.4

import sys, os, math, re

def Load_File(filename):
    f = open(filename,'r')
    return_text = f.readlines()
    f.close()
    return return_text

def ip_detect(string):
    for i in string:
        match = re.search(r'\w{1,}\.\w{1,}\.\w{1,}\.\w{1,}\:\w{1,}',i)
        if(match != None):
            byte = re.findall(r'\w{1,}',match.group())
            byte_ip = byte[0:4]
            byte_port = byte[4]
            invalid_ip = 0
            invalid_port = 0
            root = 0
            for j in byte_ip:
                if(j.isdigit()):
                    if(int(j) < 0 or int(j) > 255):
                        invalid_ip = 1
                else:
                    invalid_ip = 1
            if(byte_port.isdigit()):
                if(int(byte_port) > 32767):
                    invalid_port = 1
                elif(int(byte_port) < 1024):
                    root = 1
            else:
                invalid_port = 1
            if(invalid_ip == 1):
                print(match.group()+' - Invalid IP Address')
            elif(invalid_port == 1):
                print(match.group()+' - Invalid Port Number')
            elif(invalid_ip == 0 and invalid_port == 0 and root == 1):
                print(match.group()+' - Valid (root privileges required)')
            else:
                print(match.group()+' - Valid')
            

def main(argv):
    str = Load_File(argv[1])
    ip_detect(str)
    return 0


if __name__ == "__main__":
    main(sys.argv)
