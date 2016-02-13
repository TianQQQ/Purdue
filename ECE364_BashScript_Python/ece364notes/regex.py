import re


str = 'an example word:cat!!'
match = re.search(r"word:\w\w\w", str)    #\w = [a-z0-9A-Z]

if match:
    print('found', match.group())
else:
    print('did not find')

print(r"word:\w\w\w\n\w")
print("word:\w\w\w\n\w")

match = re.search(r'[0-9]{3}', 'p123g')
print(match)
print(match.group())

match = re.search(r'...g', 'p123g')
print(match.group())

match = re.search(r'[0-9]{3}g', 'p123g')
print(match.group())

match = re.search(r'i+$', 'piigiiii')  #$ is go to the end  (flags) P36
print(match.group())

match = re.search(r'(i+).(i+)', 'piigiiii')  #$ is go to the end
print(match.group())
print(match.group(1))
print(match.group(2))
print(match.groups())
print(match.groupdict())


str = 'purple alice-b@google.com monkey disheasher'
match = re.search(r'\w@\w',str)
print(match.group())



# card? match car or card
# ab*c matches abbbbbc or ac
# be+f matches beeeeeeef

# fo{1, 5} 
