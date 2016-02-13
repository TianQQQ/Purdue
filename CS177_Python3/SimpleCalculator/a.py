def calculator():
    x = int(input("Enter the first number: "))
    y = int(input("Enter the second number: "))
    n = input("Enter the arithmetic operation: ")
    if n == '+':
        a = x + y
        print("The result of the arithmetic operation",n,"on the two numbers is",a)
    if n == '-':
        a = x - y
        print("The result of the arithmetic operation",n,"on the two numbers is",a)
    if n == '*':
        a = x * y
        print("The result of the arithmetic operation",n,"on the two numbers is",a)
    if n == '/':
        a = x / y
        print("The result of the arithmetic operation",n,"on the two numbers is",a)
calculator()
                   
