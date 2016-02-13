import math

def series(n):
    sum = 0
    i = 1
    c = 1
    while i <= n * 2:
        term = c * 4 / i
        sum = sum + term
        i = i + 2
        c = -1 * c
    return sum
 
def main():
    print("Program that estimates pi")
    times = eval(input("Number of terms? "))
    sum = round(series(times), 11)
    print("Approximation of pi=", sum)
 
main()
