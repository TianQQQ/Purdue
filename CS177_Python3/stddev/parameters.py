y = input("Enter a file name:")

def factorial(n):
    x = 1
    for i in range(1,n+1):
        x = x * i
    return x

def GetNumbers():
    global y
    myFileA = open(y, 'r')
    lines = myFileA.readlines()
    
    for line in range(len(lines)):
        value = int(lines[line])
        lines[line] = value
        
    print(lines)
    myFileA.close()
    return lines

def Update(lines):
    n = lines
    for line in range(len(lines)):     
        lines[line] = factorial(lines[line])
    
    return lines
    

def main():
    lines = GetNumbers()    
    va = Update(lines)
    print(va)
main()
    
