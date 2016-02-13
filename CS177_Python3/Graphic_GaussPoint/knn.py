import math
from graphics import *
from utility import *
from collections import Counter

def distance(x, y):
   x1 = x[0]
   x2 = x[1]
   y1 = y[0]
   y2 = y[1]
   dis = math.sqrt((x1-y1)**2+(x2-y2)**2)
   return dis


def majority(myList):
   myList.sort()
   mylistnew = []
   mylistcount = []
   maxi = 0
   mylistnew.append(myList[0])
   for i in range(len(myList)):
      if mylistnew[-1] != myList[i]:
         mylistnew.append(myList[i])
   for i in range(len(mylistnew)):
      a = myList.count(mylistnew[i])
      if (a > maxi):
         maxi = a
         ind1 = i
           
   return mylistnew[ind1]

def classify(bluePoints, redPoints, newPoint, k):

   disblue = []
   disred = []
   for i in range(len(bluePoints)):

      #print(bluePoints[i])
      #print(newPoint)
      #print(distance(bluePoints[i],newPoint))
      disblue.append(distance(bluePoints[i],newPoint))
   for i in range(len(redPoints)):
      disred.append(distance(redPoints[i],newPoint))
   merge = disblue + disred
   merge.sort()
   disblue.sort()
   disred.sort()
   try:
      a = disblue.index(merge[k - 1])
   except ValueError:
      print()
   else:
      if ( a > k / 2):
         return 'blue'
      else:
         return 'red'


   try:
      a = disred.index(merge[k - 1])
   except ValueError:
      print()
   else:
      if ( a > k / 2):
         return 'red'
      else:
         return 'blue'   



def main():
   win = GraphWin("K-NN Classifier", 500, 500)

   
   # Read blue points from blues.txt
   bluelist = readPoints('blue.txt')
   # Plot blue points on win
   plotPoints(bluelist, win, 'blue')
   # Read red points from reds.txt
   redlist = readPoints('red.txt')
   # Plot red points on win
   plotPoints(redlist, win, 'red')
   # Ask user to input k for the k-NN classifier
   k = eval(input("Please input k for the k-NN classifier: "))
   print("Please click for the new point to be classified.")
   pt1 = win.getMouse()
   mx1 = pt1.getX()
   my1 = pt1.getY()
   #    Plot the clicked point with its prediction (either blue or red)
   clr = classify(bluelist, redlist, (mx1, my1), k)
   print("The point is classified as: ", clr)
   
   #plotPoints(bluelist, win, clr)


   
main()
