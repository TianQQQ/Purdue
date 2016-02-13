__author__ = 'ee364d08'


'''
'Looks the same visually. '
'''




from enum import Enum
import numpy as np
from glob import glob
import copy
from pprint import pprint as pp
from scipy import interpolate


class Effect(Enum):

    rotate90 = 'rotate90'
    rotate180 = 'rotate180'
    rotate270 = 'rotate270'
    flipHorizontally = 'flipHorizontally'
    flipVertically = 'flipVertically'
    transpose = 'transpose'




class Homography:

    def __init__(self, **kwargs):
        self.mat = 0
        self.sourcePoints = 0
        self.targetPoints = 0
        self.effect = 0
        self.rmat = 0
        if 'homographyMatrix' in kwargs:
            self.mat = kwargs['homographyMatrix']
            if len(self.mat) is not 3:
                raise ValueError
            for a in self.mat:
                for b in a:
                    if type(b) is not float:
                        raise ValueError
            self.rmat = np.linalg.inv(self.mat)
        elif 'sourcePoints' in kwargs and 'targetPoints' and 'effect' in kwargs:
            self.sourcePoints = kwargs['sourcePoints']
            self.targetPoints = kwargs['targetPoints']
            self.effect = kwargs['effect']
            if len(self.sourcePoints) is not 4:
                raise ValueError
            if self.effect is not None:
                if isinstance(self.effect, Effect) is False:
                    raise TypeError
            self.computeHomography()
            self.rmat = np.linalg.inv(self.mat)
        elif 'sourcePoints' in kwargs and 'targetPoints' in kwargs:
            self.sourcePoints = kwargs['sourcePoints']
            self.targetPoints = kwargs['targetPoints']
            if len(self.sourcePoints) is not 4:
                raise ValueError
            self.computeHomography()
            self.rmat = np.linalg.inv(self.mat)
        else:
            raise ValueError


    def forwardProject(self, point):
        self.point = point
        if self.sourcePoints == 0 and self.targetPoints == 0 and self.effect == 0 and self.mat != 0:
            lr = list(point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.mat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)
        elif self.effect == 0:    # calculate h by two points
            lr = list(self.point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.mat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)

        else:       # for rotation
            lr = list(self.point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.mat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)

            '''
            if #, content is right but edge is wrong.
            if not #, content is wrong, but edge is right, case cannot pass for compute.
            '''




    def inverseProject(self, point):
        self.point = point

        if self.sourcePoints == 0 and self.targetPoints == 0 and self.effect == 0 and self.mat != 0:

            lr = list(point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.rmat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)

        elif self.effect == 0:    # calculate h by two points
            lr = list(point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.rmat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)

        else:       # for rotation
            lr = list(point)
            r = [0,0,0]
            lr.append(1)
            r = np.dot(self.rmat, lr)
            return np.round(r[0]/r[2], 2), np.round(r[1]/r[2], 2)



    def computeHomography(self):

        if self.effect == Effect.rotate90:
            self.sourcePoints = [self.sourcePoints[2],self.sourcePoints[0],self.sourcePoints[3],self.sourcePoints[1]]
        if self.effect == Effect.rotate180:
            self.sourcePoints = [self.sourcePoints[3],self.sourcePoints[2],self.sourcePoints[1],self.sourcePoints[0]]
        if self.effect == Effect.rotate270:
            self.sourcePoints = [self.sourcePoints[1],self.sourcePoints[3],self.sourcePoints[0],self.sourcePoints[2]]
        if self.effect == Effect.flipHorizontally:
            self.sourcePoints = [self.sourcePoints[2],self.sourcePoints[3],self.sourcePoints[0],self.sourcePoints[1]]
        if self.effect == Effect.flipVertically:
            self.sourcePoints = [self.sourcePoints[1],self.sourcePoints[0],self.sourcePoints[3],self.sourcePoints[2]]
        if self.effect == Effect.transpose:
            self.sourcePoints = [self.sourcePoints[0],self.sourcePoints[2],self.sourcePoints[1],self.sourcePoints[3]]

        A = [[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]
        b=[0,0,0,0,0,0,0,0]
        for i in np.arange(0,4):
            sp = list(self.sourcePoints[i])
            tp = list(self.targetPoints[i])
            A[2*i][0] = sp[0]
            A[2*i][1] = sp[1]
            A[2*i][2] = 1
            A[2*i][6] = -sp[0] * tp[0]
            A[2*i][7] = -sp[1] * tp[0]
            A[2*i+1][3] = sp[0]
            A[2*i+1][4] = sp[1]
            A[2*i+1][5] = 1
            A[2*i+1][6] = -sp[0] * tp[1]
            A[2*i+1][7] = -sp[1] * tp[1]
            b[2*i] = tp[0]
            b[2*i+1] = tp[1]
        h=[1,1,1,1,1,1,1,1]
        h = np.linalg.solve(A,b)
        H = [[1,1,1],[1,1,1],[1,1,1]]
        z=0
        for i in np.arange(0,3):
            for j in np.arange(0,3):
                H[i][j] = h[z]
                if z < 7:
                    z += 1
        H[2][2] = 1
        self.mat = H

        # calculate the result point


class Transformation:

    def __init__(self, sourceImage, homography=None):
        self.homography = homography
        self.sourceImage = sourceImage
        if type(self.sourceImage) is not type(np.ones([10, 10], dtype=np.uint8)) or (self.homography is not None and isinstance(self.homography, Homography) is False):
            raise TypeError

        self.sbound = list(self.sourceImage.shape)
        self.sourcePoints = [(0.0,0.0), (0.0, self.sbound[0] - 1), (self.sbound[1] - 1, 0.0), (self.sbound[1] - 1, self.sbound[0] - 1)]




    def transformImage(self, containerImage):
            if type(containerImage) is not type(self.sourceImage):
                raise TypeError
            if np.ndim(containerImage) is not np.ndim(self.sourceImage):
                raise ValueError

            self.homography = Homography(sourcePoints=self.sourcePoints, targetPoints=self.targetPoints, effect=self.effect)
            x = [f[0] for f in self.targetPoints]
            y = [s[1] for s in self.targetPoints]

            rowmin, rowmax = min(y), max(y) + 1
            colmin, colmax = min(x), max(x) + 1



            if self.effect != None:
                self.sourcePoints = [(0,0), (self.sbound[1], 0), (0, self.sbound[0]), (self.sbound[1], self.sbound[0])]
                self.homography = Homography(sourcePoints=self.sourcePoints, targetPoints=self.targetPoints, effect=self.effect)
            else:
                self.homography = Homography(sourcePoints=self.sourcePoints, targetPoints=self.targetPoints, effect=self.effect)

            rbs =  interpolate.RectBivariateSpline(np.arange(0.0, self.sbound[0]), np.arange(0.0, self.sbound[1]), self.sourceImage, kx=1, ky=1)
            # Identify the target bounding box.
            # For every point within the box, perform an inverse projection of the coordinates.
            for i in np.arange(rowmin, rowmax):
                for j in np.arange(colmin, colmax):
                    a = j, i
                    px, py = self.homography.inverseProject(a)
                    if 0 <= px and px <= self.sbound[1] - 1 and 0 <= py and py <= self.sbound[0] - 1:
                        # read value of source and use 2D interpolation
                        containerImage[i][j] = rbs(py, px)

            return containerImage

            # If the result of the inverse projection falls within the bounds of the source image, read that value (potentially using 2D interpolation.)
            # If the result falls outside the source image, ignore that value.


    def setupTransformation(self, targetPoints,effect=None):
        self.targetPoints = targetPoints
        self.effect = effect



class ColorTransformation(Transformation):


    def __init__(self, sourceImage, homography=None):
        self.homography = homography
        self.sourceImage = sourceImage
        if type(self.sourceImage) is not type(np.ones([10, 10, 3], dtype=np.uint8)) or (self.homography is not None and isinstance(self.homography, Homography) is False):
            raise TypeError
        if self.sourceImage == np.ones([10, 10], dtype=np.uint8):
            raise ValueError


    def transformImage(self, containerImage):

        if type(containerImage) is not type(self.sourceImage):
            raise TypeError
        if np.ndim(containerImage) is not np.ndim(self.sourceImage):
            raise ValueError

        x = [f[0] for f in self.targetPoints]
        y = [s[1] for s in self.targetPoints]

        rowmin, rowmax = min(y), max(y) + 1
        colmin, colmax = min(x), max(x) + 1


        sx,sy,sz = self.sourceImage.shape
        a = np.ones([sx,sy])
        b = np.ones([sx,sy])
        c = np.ones([sx,sy])
        self.sbound = list(self.sourceImage.shape)
        for i in range(0,sx):
            for j in range(0,sy):
                a[i][j] = self.sourceImage[i][j][0]
        for i in range(0,sx):
            for j in range(0,sy):
                b[i][j] = self.sourceImage[i][j][1]
        for i in range(0,sx):
            for j in range(0,sy):
                c[i][j] = self.sourceImage[i][j][2]

        self.sourcePoints = [(0,0), (self.sbound[1], 0), (0, self.sbound[0]), (self.sbound[1], self.sbound[0])]

        if self.effect != None:
            self.homography = Homography(sourcePoints=self.sourcePoints, targetPoints=self.targetPoints, effect=self.effect)
        else:
            self.homography = Homography(sourcePoints=self.sourcePoints, targetPoints=self.targetPoints, effect=self.effect)

        rbs0 = interpolate.RectBivariateSpline(np.arange(0,self.sbound[0]), np.arange(0,self.sbound[1]), a, kx=1, ky=1)
        rbs1 = interpolate.RectBivariateSpline(np.arange(0,self.sbound[0]), np.arange(0,self.sbound[1]), b, kx=1, ky=1)
        rbs2 = interpolate.RectBivariateSpline(np.arange(0,self.sbound[0]), np.arange(0,self.sbound[1]), c, kx=1, ky=1)
        # Identify the target bounding box.
        # For every point within the box, perform an inverse projection of the coordinates.
        for i in np.arange(rowmin,rowmax + 1):
            for j in np.arange(colmin, colmax + 1):
                a = j,i
                px, py = self.homography.inverseProject(a)
                if 0 <= px and px <= self.sbound[1] - 1 and 0 <= py and py <= self.sbound[0] - 1:
                    # read value of source and use 2D interpolation
                    containerImage[i][j][0] = rbs0(py,px)
                    containerImage[i][j][1] = rbs1(py,px)
                    containerImage[i][j][2] = rbs2(py,px)

        return containerImage


        # If the result of the inverse projection falls within the bounds of the source image, read that value (potentially using 2D interpolation.)
        # If the result falls outside the source image, ignore that value.

    def setupTransformation(self, targetPoints,effect=None):
        self.targetPoints = targetPoints
        self.effect = effect






