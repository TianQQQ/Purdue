import math

def horizontalHit(d1,d2,h,g):
    t = round(math.sqrt(2 * h / g), 2)
    print("\nIt takes",t,"seconds for the bird to hit the pig.")
    v = round((d1 + d2)/(2 * t), 2)
    print("The bird must travel at a velocity of",v,".")

def ramphit(d1,d2,h,a,g):
    t = round(math.sqrt(((2 * h - math.tan(math.radians(a)) * (d1 + d2)) / g)), 2)
    print("\nIt takes",t,"seconds for the bird to hit the pig when the bird is running on the ramp.")
    v = round((d1 + d2) / (2 * (math.cos(math.radians(a))) *t), 2)
    print("The bird must travel at a velocity of",v,"when the bird is running on the ramp.")

def main():
    d1 = eval(input("Enter the distance d1: "))
    d2 = eval(input("Enter the distance d2: "))
    h = eval(input("Enter the height of the stage: "))
    a = eval(input("Enter the angle of the ramp: "))
    g = 9.8
    horizontalHit(d1,d2,h,g)
    ramphit(d1,d2,h,a,g)
main()
