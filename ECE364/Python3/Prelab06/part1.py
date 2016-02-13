__author__ = 'ee364d08'
import re
#1
str = "  AA  "
match = re.search(r' A{2,5}', str)
print (match.group())

#2
str = "123123.12 3.3"
match = re.sub(r'[0-9]*\.[0-9]+','float',str)
print (match)

#3
print(re.subn(r'[0-9]*\.[0-9]+','float',str)[0])

#4
str='123 123 123 123'
match = re.findall(r'[0-9]+',str)
sum=0
counter = 0
for i in match:
    sum += int(i)
    counter +=1
print(sum / counter)

#5
str='EE364 EE364'
print(re.subn(r'EE364', 'EE461', str, 1)[0])

#6
IPv4='111.111.111.111'
match = re.search(r'\w{1,}\.\w{1,}\.\w{1,}\.\w{1,}', IPv4)
byte=re.findall(r'\d{1,3}',match.group())
for i in byte:
    if(int(i) <0 or int(i) >255):
        print('invalid')
        break

#7
input='asdfEasdfeee'
print(re.search('e', input, re.IGNORECASE).group())

#1. Searches for e in input string ignoring upper or lower case.
#2. Finds through input string for string "is a" regardless of what is in front or behind
#3. Searches for string which has I only once, you 1-2 times, like at least 10 times.
