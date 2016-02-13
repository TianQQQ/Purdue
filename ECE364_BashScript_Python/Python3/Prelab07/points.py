# !/usr/bin/env python3.4
# author: ee364d08

import math,os,sys,re,operator
from pprint import pprint as pp

class PointND:

    def __init__(self, *args):
        self.n = len(args)
        self.t = args
        for element in args:
            if type(element) is not float:
                raise ValueError("Cannot instantiate an object with non-float values.")

    def __str__(self):
        string = '(' + str('%.2f' %self.t[0])
        for i in range(1, len(self.t)):
            a = str('%.2f' %self.t[i])                 # change float to two decimal
            string = string + ', ' + a
        string += ')'
        return string

    def __hash__(self):
        return hash(self.t)

    def distanceFrom(self, other):
        if other.n != self.n:
            raise ValueError("Cannot calculate distance between points of different cardinality.")
        else:
            sum = 0
            for i in range(0, other.n):
                sum += (self.t[i] - other.t[i]) ** 2
        return math.sqrt(sum)

    def nearestPoint(self, points):
        min = 10000000
        aim = None
        if (len(points) == 0):
            raise ValueError("Input cannot be empty.")
        for point in points:
            dist = self.distanceFrom(point)
            if min > dist:
                min = dist
                aim = point
        return aim

    def clone(self):
        point = PointND(*self.t)
        return point

    def __add__(self, o):
        if isinstance(o, PointND):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            point = PointND(*tuple(map(operator.add, o.t, self.t)))
            return point
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] + o)
            point = PointND(*tuple(l))
            return point

    def __radd__(self,o):
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] + o)
            point = PointND(*tuple(l))
            return point

    def __sub__(self, o):
        if isinstance(o, self.__class__):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            l=[]
            for i in range(0, o.n):
                l.append(-o.t[i] + self.t[i])
            point = PointND(*tuple(l))
            return point
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] - o)
            point = PointND(*tuple(l))
            return point

    def __mul__(self, o):
        if isinstance(o, self.__class__):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            l=[]
            for i in range(0, o.n):
                l.append(o.t[i] * self.t[i])
            point = PointND(*tuple(l))
            return point
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] * o)
            point = PointND(*tuple(l))
            return point

    def __rmul__(self, o):
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] * o)
            point = PointND(*tuple(l))
            return point

    def __truediv__(self, o):
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] / o)
            point = PointND(*tuple(l))
            return point

    def __neg__(self):
        l = []
        for i in range(0, self.n):
            l.append(-self.t[i])
        point = PointND(*tuple(l))
        return point

    def __getitem__(self, index):
        return self.t[index]

    def __eq__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")

        if isinstance(o, self.__class__):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            for i in range(0, o.n):
                if o.t[i] is not self.t[i]:
                    return False
            return True

    def __nq__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")
        if isinstance(o, self.__class__):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            for i in range(0, o.n):
                if o.t[i] is self.t[i]:
                    return False
            return True

    def __gt__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")
        l=[]
        for i in range(0, o.n):
            l.append(0.0)
        origin = PointND(*tuple(l))
        if (self.distanceFrom(origin) > o.distanceFrom(origin)):
            return True
        else:
            return False
    def __ge__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")
        l=[]
        for i in range(0, o.n):
            l.append(0.0)
        origin = PointND(*tuple(l))
        if (self.distanceFrom(origin) >= o.distanceFrom(origin)):
            return True
        else:
            return False


    def __lt__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")
        l=[]
        for i in range(0, o.n):
            l.append(0.0)
        origin = PointND(*tuple(l))
        if (self.distanceFrom(origin) < o.distanceFrom(origin)):
            return True
        else:
            return False

    def __le__(self, o):
        if (self.n != o.n):
            raise ValueError("Cannot operate on points with different cardinalities.")
        l=[]
        for i in range(0, o.n):
            l.append(0.0)
        origin = PointND(*tuple(l))
        if (self.distanceFrom(origin) <= o.distanceFrom(origin)):
            return True
        else:
            return False

class Point3D(PointND):
    def __init__(self, x = 0.0, y = 0.0, z = 0.0):
        self.x = x
        self.y = y
        self.z = z
        self.t = (self.x, self.y, self.z)
        self.n = 3
        for element in self.t:
            if type(element) is not float:
                raise ValueError("Cannot instantiate an object with non-float values.")

    def __add__(self, o):
        if isinstance(o, Point3D):
            point = PointND(*tuple(map(operator.add, o.t, self.t)))
            return point
        if isinstance(o, PointND):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] + o)
            point = PointND(*tuple(l))
            return point
    def __sub__(self, o):
        if isinstance(o, self.__class__):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
            l=[]
            for i in range(0, o.n):
                l.append(-o.t[i] + self.t[i])
            point = PointND(*tuple(l))
            return point
        if isinstance(o, PointND):
            if (self.n != o.n):
                raise ValueError("Cannot operate on points with different cardinalities.")
        if isinstance(o, float):
            l = []
            for i in range(0, self.n):
                l.append(self.t[i] - o)
            point = PointND(*tuple(l))
            return point


class PointSet:
    def __init__(self, **kwargs):
        self.points = set(kwargs['pointList'])
        if len(kwargs['pointList']) == 0:
                raise ValueError("'pointList' input parameter cannot be empty.")
        self.n = kwargs['pointList'][0].n
        for i in kwargs['pointList']:
            if self.n != i.n:
                raise ValueError("Expecting a point with cardinality {0}.".format(self.n))

    def addPoint(self, p):
        if p.n == self.n:
            self.points.add(p)
        else:
            raise ValueError("Expecting a point with cardinality {0}.".format(self.n))

    def count(self):
        return len(self.points)

    def computeBoundingHyperCube(self):
        minl=[]
        maxl=[]
        for i in range(0,self.n):
            minl.append(1000000)
            maxl.append(0)
        for i in range(0,self.n):
            for point in list(self.points):
                    if minl[i] > point.t[i]:
                        minl[i] = point.t[i]
                    if maxl[i] < point.t[i]:
                        maxl[i] = point.t[i]
        print(PointND(*tuple(minl)))
        print(PointND(*tuple(maxl)))
        return PointND(*tuple(minl)), PointND(*tuple(maxl))

    def computeNearestNeighbors(self,other):
        closest = []
        for point in self.points:
            nearest = point.nearestPoint(other.points)
            closest.append(tuple([point,nearest]))
        return closest

    def __add__(self, p):
        if p.n == self.n:
            self.points.add(p)
            return self
        else:
            raise ValueError("Expecting a point with cardinality {0}.".format(self.n))

    def __sub__(self, p):
        if p in self.points:
            self.points.remove(p)
            return self
        return self


    def __contains__(self, p):
        if p in self.points:
            return True
        return False









if __name__ == "__main__":
    main()
