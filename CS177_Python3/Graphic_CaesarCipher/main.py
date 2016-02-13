from graphics import *
import math


def caesarEncipher(message,shift):
    n = len(message)
    let = []
    for i in range(n):
        x = ord(message[i])
        y = x + int(shift)
        if y <= 90 and y >= 65:
            y=y
        if y > 90:
            y = y - 26
        if y < 65:
            y = y + 26
        a = chr(y)
        let.append(a)
    content = ''
    content = ''.join(let)
    return(content)
        
    
def caesarDecipher(message,shift):
    n = len(message)
    for i in range(n):
        x = ord(message[i])
        y = x - shift
        if y <= 90 and y >= 65:
            y=y
        if y > 90:
            y = y - 26
        if y < 65:
            y = y + 26
        a = chr(y)
        print (a, end="")


def Cipher_wheel(message,cipher):
    win = GraphWin("My Window",600,600)
    win.setCoords(600, 600 , 0, 0)
    win.setBackground("Yellow")
    
    cir1 = Circle(Point(300,250),160)
    cir1.draw(win)

    cir2 = Circle(Point(300,250),200)
    cir2.draw(win)

    cir3 = Circle(Point(300,250),240)
    cir3.draw(win)

    n = len(message)

    for i in range(n):
   
        x = 2*math.pi/n
       
        a = 300 + 160*math.cos(x*i)
        b = 250 + 160*math.sin(x*i)
        c = 300 + 240*math.cos(x*i)
        d = 250 + 240*math.sin(x*i)
        line = Line(Point(a,b), Point(c, d))
        line.draw(win)

        y = math.pi/n
        e = 300 + 180*math.cos(x*i+y)
        f = 250 + 180*math.sin(x*i+y)
        g = 300 + 220*math.cos(x*i+y)
        h = 250 + 220*math.sin(x*i+y)

        textIn = Text(Point(e,f), cipher[i])
        textout = Text(Point(g,h), message[i])

        textIn.draw(win)
        textout.draw(win)

    win.getMouse()
    win.close()



def main():
    message = input("Please input the message to encode:")
    shift = input("Please input a shift value:")
    cipher = caesarEncipher(message,shift)   
    c = Cipher_wheel(message,cipher)
    print("CaesarCipher:", cipher)
    print("CaesarDec:", message)

    
main()
