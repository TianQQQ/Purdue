from graphics import *
from utility import *
import random

def generatePoint(meanX, meanY, sigmaX, sigmaY):
   x = random.gauss(meanX,sigmaX)
   y = random.gauss(meanY,sigmaY)
   return (x, y)
   

def generatePoints(meanX, meanY, sigmaX, sigmaY, numPoints):
   mylist =[]
   for i in range(numPoints):
      x = random.gauss(meanX,sigmaX)
      y = random.gauss(meanY,sigmaY)
      mylist.append((x,y))
   return mylist

def main():
   win = GraphWin("Data Collector", 500, 500)
   #win.getMouse()
   print("Please click on window for meanX and meanY for blue samples.")
   pt1 = win.getMouse()
   mx1 = pt1.getX()
   my1 = pt1.getY()
   sX1 = eval(input("Please enter sigmaX for blue: "))
   sY1 = eval(input("Please enter sigmaY for blue: "))
   n1 = eval(input("How many blue samples: "))
   mylist1 = generatePoints(mx1, my1, sX1, sY1, n1)
   plotPoints(mylist1, win, 'blue')
   savePoints(mylist1, 'blue.txt')
   print(n1,"blue samples has written to blues.txt")

   print("Please click on window for meanX and meanY for red samples.")
   pt2 = win.getMouse()
   mx2 = pt2.getX()
   my2 = pt2.getY() 
   sX2 = eval(input("Please enter sigmaX for red: "))
   sY2 = eval(input("Please enter sigmaY for red: "))
   n2 = eval(input("How many red samples: "))
   mylist2 = generatePoints(mx2, my2, sX2, sY2, n2)
   plotPoints(mylist2, win, 'red')
   savePoints(mylist2, 'red.txt')
   print(n2,"red samples has written to reds.txt")

   print("Please click to close the window.")
   win.getMouse()
   win.close()
            
    
   # Ask user to input sigmaX and sigmaY for blue samples
 
   # Ask user to input how many blue samples?
 
   # Generate blue samples with given information 
 
   # Plot these blue samples on window using utility functions
 
   # Write these blue samples on blues.txt using utility functions
 
   # Ask user to click on window for meanX and meanY for red samples
 
   # Ask user to input sigmaX and sigmaY for red samples
 
   # Ask user to input how many red samples?
 
   # Generate red samples with given information
 
   # Plot these red samples on window using utility functions
 
   # Write these red samples on reds.txt using utility functions

main()
