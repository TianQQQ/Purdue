from graphics import *

# Writes points to a file. If the file already exists, you should overwrite.
# You can write your points to a file such that all lines will have one point in csv format
# ========
# Example:
# 10.3,5.4
# 21.2,5.3
# 5.1,2.7
# ...
# ========
# points: points to be saved, type: list of tuples containing two floats 
# fileName: file name of the file, type: string
def savePoints(points, fileName):
   myFile = open(fileName,'w')
   for i in range(len(points)):
      myFile.write(str(points[i][0])+ "," + str(points[i][1]) + '\n')
   myFile.close()
   pass # remove this line
   
# Reads points from a file. If the file do not exist, return an empty list.
# fileName: file name of the file, type: string
# RETURNS: points, type: list of tuples containing two floats
# fileName = 'blue.txt'
def readPoints(fileName):
   mylist = []
   myFileA = open(fileName, 'r')
   lines = myFileA.readlines()
   
   for line in lines:
      mylist.append(eval(line))
   #print(mylist)
   return(mylist)
      



# Plots given points to the given window with the given color.
# You can plot small Circle's to make your points visible.
# points: points to be plotted, type: list of tuples containing two floats 
# win: window object to plot points on, type: GraphWin
# color: color of the points, type: string
def plotPoints(points, win, color):
   for i in range(len(points)):
      
      p = Point(points[i][0],points[i][1])
      p.draw(win)
      p.setFill(color)

