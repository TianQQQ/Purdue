# Created by Tian Qiu on 2015

#          indexable mutable
# lists       1         1
# strings     1         0    (kind of list)
# tuples      1         0
# sets        0         0.5  (can add,delete, but not change element)
# maps        0         0.5

# list:    .append(1) .extend([1,1]) .count(2) +["aa"] .insert(2,'OH')
#          .remove(2) .index(2) .sort() .reverse() b.copy()= b=a[:] a.clear()=del a[:]
#           A[M:] A[M:N] A[:N] A[:]

# tuples:  for first, _, age in namesAndAges: (not to use all elements)

# sets:      set_list = set(list)     # eliminate same element, alphabet order
#            x.append( n.pop() )

# strings: .find('a') .count() .endswith(substr) ( returns True if ends with substr)
#          .replace(p,q,n) replace nth p with q
#          .isalnum() .isalpha() .isdigit() .isspace() .isupper() .islower() .title() .lower() .upper() .lstrip() .rstrip()

# maps:    .get("red","not found value") A.update(B) map A updated by B
#          .pop(key) (get value directed by key)  key, value= A.popitem()(get both key and value)
#           del A[key] .items() .keys()
#           if user_name in dic:
#               dic.update({user_name:(sum,cost)})
#           else
#               dic[key] = abc;
#           info_1st = dic.get(key)[1]  get key info lsit which the first element of list



x = [100,0,12,2,2,2,2,2,2]
y = type(x) is list; print (y)

print (format(type(x)))


x.append(2)
print (x)

y = [10,20]
x.extend(y)
print (x)

print(x[1])
print(x.index(0))
print(x.count(2))
print(x.count(-1))

s = reversed(x)  # index reverse
print(x)
print("reversed x:", s)

k = sorted(x)
print(k)
k=x.sort()
print(k)

# typeError: 'tuple' object does not support item assignment
t = 3,4,[5,4]
print(t[1])
x,y,z = t

# setS    get all single elements
l = list(range(10)) + list(range(9))
print(l)

s=set(l)  #{}
print(s)
8 in s

s1 = set("Apples")
s2 = set("Chickens")
setDiff = s1.difference(s2)
s1.union(s2)
s1.intersection(s2,s)
print(setDiff)

# Maps(dictionarys)
myMap = {
        2222:   "IU",
        121: "a",
        339: "Tian",
        222: "Q"}
print(myMap[222])


print(myMap)
from pprint import pprint as pp
pp(myMap)


#unique set of keys
for k in myMap.keys():
    print(k)

for v in myMap.values():
    print(v)


for k, v in myMap.items():
    print("for key {}, the value is {}".format(k,v))

myMap['233'] = 'HA'
print(myMap)
print(120 not in myMap.keys())


#filename
#filename = 'names.txt'
#with open(filename, 'r') as f:
    


















