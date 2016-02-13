import math

def sum_geoSeries(a, r, n):
    sum = 0
    for i in range(n):          
        term = a * math.pow(r, i)
        sum = sum + term
        print("Term" ,i + 1, "=", term) 
    return sum
 
def main():
    print("Calculate the sum of geometric series")    
    a = int(input("a? "))
    r = int(input("r? "))
    n = int(input("n? "))
    sum = sum_geoSeries(a, r, n)
    print("sum = ",sum)
 
main()
