__author__ = 'ee364d08'
import sys
from PySide.QtGui import *
from PySide.QtCore import *
from HomographyGUI import *
import re
import numpy as np
from PIL import Image

from Homography import *


class HomographyApp(QMainWindow, Ui_Dialog):
    def __init__(self, parent=None):
        super(HomographyApp, self).__init__(parent)
        self.setupUi(self)

        # all push buttons
        self.loadpb = [self.LoadSource, self.LoadTarget]
        self.pointspb = [self.AcquirePoints, self.Point0, self.Point1, self.Point2, self.Point3]
        self.Bonuspointspb = [self.AcquirePoints2, self.Point0_1, self.Point1_1]
        self.effectpb = [self.Effect, self.Transform, self.Reset, self.Save]
        self.Views = [self.SourceView, self.TargetView]


        # initial state
        for i in self.pointspb + self.effectpb + self.Bonuspointspb:
            i.setEnabled(False)

        self.LoadSource.clicked.connect(self.FLoadSource)
        self.LoadTarget.clicked.connect(self.FLoadTarget)

        # Loaded State and Point-Selection State
        self.pointlist = []
        self.AcquirePoints.clicked.connect(self.FAcquirePoints)

        # Ready State
        self.effect = 0
        self.Transform.clicked.connect(self.Ftransform)
        self.Save.clicked.connect(self.Fsave)   ########## not finished
        self.Reset.clicked.connect(self.Freset)

    def Freset(self):
        for i in self.pointspb:
            i.setEnabled(True)
        x = QPixmap(self.TargetFilename)
        self.TargetScene = QGraphicsScene(self)
        self.TargetScene.addPixmap(QPixmap(self.TargetFilename))
        self.TargetView.setScene(self.TargetScene)
        self.TargetView.fitInView(self.TargetScene.sceneRect())

        for i in self.loadpb:
            i.setEnabled(True)



    def Ftransform(self):
        for i in self.pointspb:
            i.setEnabled(False)
        self.FGetEffect()
        self.SourceArray = np.array(self.SourcePath)
        self.TargetArray = np.array(self.TargetPath)


        if len(self.SourceArray.shape) == 2:
            transformer = Transformation(self.SourceArray, None)
            transformer.setupTransformation(self.pointlist,self.effect)
            self.TargetArray = transformer.transformImage(self.TargetArray)
        elif len(self.SourceArray.shape) == 3:
            transformer = ColorTransformation(self.SourceArray, None)
            transformer.setupTransformation(self.pointlist, self.effect)
            self.TargetArray = transformer.transformImage(self.TargetArray)

        img = Image.fromarray(self.TargetArray)
        img.save("output.png")
        x = QPixmap('output.png')
        self.TargetScene = QGraphicsScene(self)
        self.TargetScene.addPixmap(QPixmap('output.png'))
        self.TargetView.setScene(self.TargetScene)
        self.TargetView.fitInView(self.TargetScene.sceneRect())






    def Fsave(self):
        outputfilepath,_ = QFileDialog.getSaveFileName(self, caption = 'Save png file ...', filter = 'png files (*.png)')
        img = Image.fromarray(self.TargetArray)
        try:
            img.save(outputfilepath + '.png')
        except:
            pass



    def FGetEffect(self):
        self.Effect.currentIndexChanged
        if  self.Effect.currentText() == 'Nothing':
            self.effect = None
        if self.Effect.currentText() == 'Rotate 90':
            self.effect = Effect.rotate90
        if self.Effect.currentText() == 'Rotate 180':
            self.effect = Effect.rotate180
        if self.Effect.currentText() == 'Rotate 270':
            self.effect = Effect.rotate270
        if self.Effect.currentText() == 'Flip Horizontally':
            self.effect = Effect.flipHorizontally
        if self.Effect.currentText() == 'Flip Vertically':
            self.effect = Effect.flipVertically
        if self.Effect.currentText() == 'Transpose':
            self.effect = Effect.transpose




    def FLoadSource(self):
        filename,_ = QFileDialog.getOpenFileName(self, caption='Open png file ...', filter="png files (*.png)")
        x = QPixmap(filename)
        self.SourceScene = QGraphicsScene(self)
        self.SourceScene.addPixmap(QPixmap(filename))
        self.SourceView.setScene(self.SourceScene)
        self.SourceView.fitInView(self.SourceScene.sceneRect())
        try:
            self.SourcePath = Image.open(filename)
        except:
            pass



    def FLoadTarget(self):
        self.TargetFilename,_ = QFileDialog.getOpenFileName(self, caption='Open png file ...', filter="png files (*.png)")
        filename = self.TargetFilename
        x = QPixmap(filename)
        self.TargetScene = QGraphicsScene(self)
        self.TargetScene.addPixmap(QPixmap(filename))
        self.TargetView.setScene(self.TargetScene)
        self.TargetView.fitInView(self.TargetScene.sceneRect())
        self.TargetPath = Image.open(filename)
        self.TargetArray = np.array(self.TargetPath)


        for i in self.pointspb:
            i.setEnabled(True)

    def FAcquirePoints(self):
        if len(self.pointlist) >= 4:
            for i in self.effectpb:
                i.setEnabled(True)
        else:
            for i in self.pointspb[1:4]:
                i.setText('')
            self.pointlist.clear()
            for i in self.effectpb:
                i.setEnabled(False)
        for i in self.loadpb:
            i.setEnabled(False)

        self.TargetScene.mouseReleaseEvent = self.mouseReleaseEvent
        self.TargetScene.keyPressEvent = self.keyPressEvent


    def mouseReleaseEvent(self, event):
        try:
            x = round(event.scenePos().x(), 1)
            y = round(event.scenePos().y(), 1)
        except:
            pass
        if len(self.pointlist) < 4:
            tup = x,y
            self.pointlist.append(tup)
        try:
            self.Point0.setText(str(self.pointlist[0]))
            self.Point1.setText(str(self.pointlist[1]))
            self.Point2.setText(str(self.pointlist[2]))
            self.Point3.setText(str(self.pointlist[3]))
        except:
            pass




    def keyPressEvent(self, event):
        key = event.key()
        if key == QtCore.Qt.Key_Backspace:
            self.pointlist.pop()
            try:
                if len(self.pointlist) == 0:
                    self.Point0.clear()
                if len(self.pointlist) == 1:
                    self.Point1.clear()
                if len(self.pointlist) == 2:
                    self.Point2.clear()
                if len(self.pointlist) == 3:
                    self.Point3.clear()
            except:
                pass
















if __name__ == "__main__":
    currentApp = QApplication(sys.argv)
    currentForm = HomographyApp()

    currentForm.show()
    currentApp.exec_()
