__author__ = 'ee364d08'

from datetime import time


class Duration:
    def __init__(self, hours=0, minutes=0, seconds=0):
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        if (type(self.seconds) is not int) or (type(self.minutes) is not int) or (type(self.hours) is not int):
            raise TypeError
        if (self.seconds < 0) or (self.minutes < 0) or (self.hours < 0):
            raise ValueError
        self.minutes += int(self.seconds / 60)
        self.hours += int(self.minutes / 60)
        self.minutes %= 60
        self.seconds %= 60

    def __str__(self):
        self.hours = str(self.hours)
        self.minutes = str(self.minutes)
        self.seconds = str(self.seconds)
        if int(self.hours) < 10:
            self.hours = '0' + self.hours
        if int(self.minutes) < 10:
            self.minutes = '0' + self.minutes
        if int(self.seconds) < 10:
            self.seconds = '0' + self.seconds
        return self.hours + ':' + self.minutes + ':' + self.seconds


    def getTotalSeconds(self):
        return self.hours * 3600 + self.minutes * 60 + self.seconds

    def __add__(self, other):
        if isinstance(other, self.__class__):
            return Duration(self.hours + other.hours, self.minutes + other.minutes, self.seconds+ other.seconds)
        else:
            raise TypeError

    def __mul__(self, other):
        if other == 0:
            raise ValueError
        if isinstance(other, int):
            return Duration(self.hours * other, self.minutes * other, self.seconds * other)
        else:
            raise TypeError

    def __rmul__(self, other):
        if other == 0:
            raise        ValueError
        if isinstance(other, int):
            return Duration(self.hours * other, self.minutes * other, self.seconds * other)
        else:
            raise TypeError




















