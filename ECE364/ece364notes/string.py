#
#  main.c
#  Created by Tian Qiu on 15/4/19.
#  Copyright (c) 2015  Tian Qiu. All rights reserved.
#

#strip
s = " abcdefg "
print(s.rstrip(),s.lstrip())
print(s.strip())

#split
s = "ab c d e f g hhh"
delim=" " 
sItems=s.split(delim, 3)
print(sItems)
print(sItems[-1]) # last elements

#join
sRecover = delim.join(sItems)
print(sRecover)
print("?".join(sItems))







