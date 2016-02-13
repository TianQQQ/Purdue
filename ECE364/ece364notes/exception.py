mapEx = {1: "Hello"}

try:
    x = 1
    y = 1


    #print(mapEx[33])
    z = x / 0




except(KeyError):
    print("Caught a KeyError")
except(ZeroDivisionError, KeyError):
    print("Caught a ZeroDivisionError or a KeyError")
except:
    print("Caught general exception")
else:
    print("in the 'else' clause")
finally:
    print("Finally")


#  exception hierarchy
