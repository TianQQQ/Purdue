def leapYear():
    n = int(input("Enter the year: "))
    if (n % 400) == 0:
        print("The year",n,"is a leap year")
    elif n % 4 == 0 and n % 100 == 0:
        print("The year",n,"is not a leap year")
    elif n % 4 == 0 and n % 100 != 0:
        print("The year",n,"is a leap year")
    else:
        print("The year",n,"is not a leap year")
leapYear()
            
