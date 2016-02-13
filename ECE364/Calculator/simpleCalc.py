import sys
from PySide import QtCore, QtGui
from calculator import *
from PySide.QtCore import *
from PySide.QtGui import *

sumAll = 0.0
operator = ""
opVar = False   # check previous one is operator variable
optimes = 0
pnum = 0.0
newNum = 0.0
de = False   # double equal flag
dotf = False

class CalculatorApp(QMainWindow, Ui_MainWindow):

    def __init__(self, parent = None):
        super(CalculatorApp, self).__init__(parent)
        self.setupUi(self)

        nums = [self.zero, self.one, self.two, self.three, self.four, self.five, self.six, self.seven, self.eight, self.nine]
        ops = [self.div, self.mul, self.minus, self.add]
        for i in ops:
            i.clicked.connect(self.Operator)
        for i in nums:
            i.clicked.connect(self.Nums)

        self.clear.clicked.connect(self.Clear)
        self.equals.clicked.connect(self.Equal)
        self.dot.clicked.connect(self.Dot)
        self.setGeometry(0,0,500,220)              # for line
        self.setFixedSize(600,300)
        self.setWindowTitle("Calculator")
        self.show()


    def Dot(self):
        if '.' not in self.line.text():
            setNum = '.'
        else:
            setNum = ''
        #print(self.line.text() + setNum)
        self.line.setText(self.line.text() + setNum) # inputting number

    def Operator(self):
        global pnum
        global opVar
        global operator
        global optimes
        global de
        de = False
        optimes += 1
        if optimes > 1:
            self.Equal()
        pnum = self.line.text()
        operator = self.sender().text()   # send the name of object
        opVar = True

    def Nums(self):
        global pnum
        global newNum
        global opVar
        global optimes
        global de
        de = False
        optimes = 0
        newNum = int(self.sender().text())
        setNum = str(newNum)
        if opVar == False:
            self.line.setText(self.line.text() + setNum) # inputting number
        else:
            self.line.setText(setNum)                    # inputting operator
            opVar = False
        if len(self.line.text()) > 12:
            self.line.setText("Restrict the maximum number of digits to display to be 12 digits")

    def Clear(self):
        global newNum
        global sumAll
        global pnum
        global de
        de = False
        self.line.clear() # clear all the variable
        pnum = 0.0
        newNum = 0.0
        sumAll = 0.0

    def Thousands(self,num_string):
        decimal = self.comboBox.currentText()
        nums = num_string[0:-(int(decimal)+1)]
        num_display = ''
        comma = 1
        for i in range(len(nums)):
            num_display = nums[-1-i] + num_display
            if comma == 3:
                comma = 0
                num_display = ',' + num_display
            comma = comma + 1
        if num_display[0] == ',':
            num_display = num_display[1:]
        return num_display


    def Equal(self):
        global pnum
        global newNum
        global sumAll
        global operator
        global opVar
        global de
        if de is False:
            newNum = self.line.text()
            newNum = newNum.replace(",","")
        else:
            pnum = sumAll
        # operator
        if operator == "+":
            sumAll = float(pnum) + float(newNum)
        elif operator == "-":
            sumAll = float(pnum) - float(newNum)
        elif operator == "/":
            sumAll = float(pnum) / float(newNum)
        elif operator == "x":
            sumAll = float(pnum) * float(newNum)
        else:
            sumAll = newNum
        sumAll = ('{0:.'+str(self.comboBox.currentText())+'f}').format(float(sumAll))
        # for thousands
        if(self.thousands.isChecked()) == True:
            self.line.setText(self.Thousands(str(sumAll)))
        else:
            self.line.setText(str(sumAll))
        opVar = True
        de = True
        if len(self.line.text()) > 12:
            self.line.setText("Restrict the maximum number of digits to display to be 12 digits")


def main():
    app = QtGui.QApplication(sys.argv)
    main = CalculatorApp()
    main.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
