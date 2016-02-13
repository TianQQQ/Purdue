#mathFunctions.py
import math
 
def main():
    a = int(input("Enter length of side a: "))
    b = int(input("Enter length of side b: "))
    c = int(input("Enter length of side c: "))

    # calculation of angle between a and b
    angle_ab = round(math.degrees (math.acos( (math.pow(a,2) + math.pow(b,2) - math.pow(c,2)) / (2 * a * b))),2)
    print("The angle between a and b is: ", angle_ab,"degrees")

    # calculation of angle between b and c
    angle_bc = round(math.degrees (math.acos( (math.pow(c,2) + math.pow(b,2) - math.pow(a,2)) / (2 * c * b))),2)
    print("The angle between b and c is: ", angle_bc,"degrees")

    # calculation of angle between a and c
    angle_ac = round(math.degrees (math.acos( (math.pow(a,2) + math.pow(c,2) - math.pow(b,2)) / (2 * a * c))),2)
    print("The angle between a and c is: ",  angle_ac,"degrees")


 
main()
