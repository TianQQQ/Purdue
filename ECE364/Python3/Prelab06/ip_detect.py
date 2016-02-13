__author__ = 'ee364d08'

import sys, os, math, re

def detect(filename):
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    for line in lines:
        match = re.search(r'\w{1,}\.\w{1,}\.\w{1,}\.\w{1,}\:\w{1,}', line)
        if(match != None):
            n = re.findall(r'\w{1,}', line)
            ip = n[0:4]
            port = n[4]
            ipflag=False
            portflag=False
            root=False
            for i in ip:
                if not i.isdigit():
                    ipflag=True
                else:
                    if (int(i) < 0 or int (i) > 255):
                        ipflag=True
            if not port.isdigit():
                portflag=True
            else:
                if int(port) not in range(1,32767):
                    portflag=True
                elif int(port) < 1024:
                    root =True

            if ipflag is True:
                print(match.group()+' - Invalid IP Address')
            elif portflag is True:
                print(match.group()+' - Invalid Port Number')
            elif ipflag is False and portflag is False and root is True:
                print(match.group()+' - Valid(root privileges required)')
            else:
                print(match.group()+' - Valid')

def main(argv):
    detect(argv[1])
    return 0

if __name__ == "__main__":
    main(sys.argv)
