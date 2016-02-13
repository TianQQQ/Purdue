from graphics import *
import time

def main():
    
    # GraphWin(title, width, height)
    win = GraphWin("Lab04", 400, 400)

    
    # setCoords(x lower left, y lower left, x upper right, y upper right) 
    win.setCoords(0, 0, 400, 400)


    # Circle(centerPoint, radius)  
    cir = Circle(Point(100, 50), 40)
    # Circle draw on the windows
    cir.draw(win)
    
    cir.setFill("red")

    # Rectangle(point1, point2)   
    rect = Rectangle(Point(300, 300), Point(350, 350))
    # Rect draw on the windows
    rect.draw(win)

    rect.setFill("blue")

    for t in range(0,100):
        # move(dx,dy)
        cir.move(10, 0)
        rect.move(-10,0)
        time.sleep(0.02)

    win.getMouse()
    

main()
