def LongLen():
    a = input("Enter a string:")
    mylist=a.split()
   
    n = len(mylist)
    b = 0
    for i in range(n-1):
        if  len(mylist[i]) > b:
            b = len(mylist[i])
        else:
            b = b
    if len(mylist[n-1]) - 1 > b:
        b = len(mylist[n-1]) - 1
    for i in range(n-1):
        if len(mylist[i]) == b:
            c = i
    if len(mylist[n-1]) == b + 1:
        c = n-1
    d = mylist[c]
    print("The longest word in the given string is",d)
    print("Its length is",b)
LongLen()
