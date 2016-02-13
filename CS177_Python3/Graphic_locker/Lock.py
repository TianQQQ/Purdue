from random import randint
from graphics import * 
 
class Lock:
    def __init__(self):
        # Set the initial password of the lock to "LOCK"
        # Use an instance variable called self.password which specifies the password of the lock
        self.password = 'LOCK'
        self.password_tmp = ''
     
        # Set the error message to an empty string
        # Use an instance variable called self.errMsg
        self.errMsg = ''
     
        # Set the initial status of the lock to "New"   
        # Use an instance variable called self.status which specifies the current state of the lock
        self.status = 'New'
     
        # call the drawInitLock function  
        self.drawInitLock(self.password)  
 
    def drawInitLock(self, password):
        # Create a 500 x 500 graphics window. Name it "Resettable combination lock"
        self.win = GraphWin('Resettable combination lock',500,500)
     
        # Set the coordinate system of the window so that the lower left corner is (0, 0)
        self.win.setCoords(0, 0 , 500, 500)
     
        # Create a rectangle whose two opposite corners are at points (50, 100) and (450,400)
        # Set the color of the rectangle to "Lavender"
        # Draw the rectangle to the window you just created
        self.rect = Rectangle(Point(50, 100),Point(450,400))
        self.rect.setFill('Lavender')
        self.rect.draw(self.win)
     
        # Create 4 circles at points (100,300), (200,300), (300,300) and (400,300), respectively. 
        # The radius of all circles should be 40
        # Set the color of all circles to "Pink"
        # Draw the circles to the window
        cir1 = Circle(Point(100,300), 40)
        cir2 = Circle(Point(200,300), 40)
        cir3 = Circle(Point(300,300), 40)
        cir4 = Circle(Point(400,300), 40)
        self.circles = [cir1, cir2, cir3, cir4]
     
        for cir in self.circles:
            cir.setFill('Pink')
            cir.draw(self.win)
     
        # Create 4 text fields at the center points of the circles
        # From left to right, each text field contains one character of the lock's initial password which is "LOCK"
        # Set the font size of all text fields to 20 using the setSize() function
        # Draw the text fields to the window
        self.texts1 = list(password)
        text1 = Text(Point(100,300), self.texts1[0])
        text2 = Text(Point(200,300), self.texts1[1])
        text3 = Text(Point(300,300), self.texts1[2])
        text4 = Text(Point(400,300), self.texts1[3])
        self.texts = [text1, text2, text3, text4]
     
        for text in self.texts:
            text.setSize(20)
            text.draw(self.win)
     
        # Create another text field at point (250, 200), named it as self.label
        # The text in this field should be the current status of the lock which is "New" 
        # (remember that in the constructor function you have created self.status)  
        # Set the font size of this text field to 20
        # Draw it to the window 
        self.label = Text(Point(250, 200), self.status)
        self.label.setSize(20)
        self.label.draw(self.win)
 
    def updateTexts(self, value):
        self.password = value
        
    def updateLabel(self):
        a = self.status
        self.status = self.status + "\n" + self.errMsg
        self.win.close()
        self.drawInitLock(self.password.upper())
        self.status = a
 
    def reset(self, password):
        if password == "":
            self.errMsg = "(The password should not be empty.)"
            self.updateLabel()
            return 0
        if len(password) != 4:
            self.errMsg = "(The password length should be 4.)"
            self.updateLabel()
            return 0
        if len(password) == 4:
            
            self.password = password
            self.status = "Reset"
            self.updateTexts(password)
            self.updateLabel()
            
        return 1;
    
    def close(self):
        char1 = chr(ord('A') + randint(0,25))
        char2 = chr(ord('A') + randint(0,25))
        char3 = chr(ord('A') + randint(0,25))
        char4 = chr(ord('A') + randint(0,25))
        plist = []
        plist.append(char1)
        plist.append(char2)
        plist.append(char3)
        plist.append(char4)
        self.password_tmp = ''.join(plist)
        self.status = "Closed"
        self.win.close()
        self.drawInitLock(self.password_tmp.upper())
 
    def open(self, password):
        if password != self.password:
            self.errMsg = "(The password you entered is incorrect!)"
            self.status = "Closed"
            self.win.close()
            self.drawInitLock(self.password_tmp.upper())
            return 0;
        else:
            self.password = "PASS"
            self.status = "Opened"
            self.win.close()
            self.drawInitLock(self.password.upper())
            return 1;

def main():
    while(True):
        # Create a lock
        lock = Lock()
 
        # Ask users to enter the password they want to use to reset the lock
        # Repeat this until the reset operation is successful
        password = input('\nPlease enter a new password to reset: ')
        password.upper()
        while not lock.reset(password):
            password = input('\nPlease enter a new password to reset: ')
            attempt.upper()
        # Ask users if they want to play with lock (i.e., do close/open operations)
        # If yes: 
        # - close the lock
        # - ask users to enter password to open the lock. Note that users only have 3 chances to enter password
        # - if the open operation is successful, the lock will be opened.
        # - if the open operation fails for 3 times, users will not be allowed to enter password anymore
        answer = input('\nWant to play with the lock you just created? (yes/no) ')
        if answer.lower() == 'yes':
            lock.close()
 
            attempt = input("\nPlease enter the password to open: ")
            attempt.upper()
            count = 0
            while not lock.open(attempt):
                count += 1
                if count < 3:           
                    print('\nYou only have ' + str(3-count) + ' chances left to enter password.')
                    attempt = input("Try again: ")
                    attempt.upper()
                else:
                    print('\nYou have failed 3 times! You cannot open it anymore!')
                    break
 
        # Ask users if they want to play with a new lock
        # If yes: close the lock window you draw
        # If no: close the lock window you draw and quit the while loop
        answer = input('\nWant to play with a new lock?(yes/no) ')
        if answer.lower() == 'no':
            lock.win.close()
            break
        else:
            lock.win.close()

main()
