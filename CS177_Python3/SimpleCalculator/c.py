def secLargest():
    mylist = eval(input("Enter a list of numbers: "))
    n = len(mylist)
    a = 0
    b = 0
    for i in range(n):
        if  mylist[i] > a:
            a = mylist[i]
        else:
            a = a
    for i in range(n):
        if  mylist[i] > b:
            c = mylist[i]
            if c < a:
                b = c
            else:
                a = a
        else:
            b = b
    d = mylist.index(b)+1
    if d == 1:
        d = "1st"
    elif d == 2:
        d = "2nd"
    elif d == 3:
        d = "3rd"
    else:
        d = str(d)+"th"
    print("The second largest number is",b,"and is found at the",d,"position in the list.")

secLargest()
