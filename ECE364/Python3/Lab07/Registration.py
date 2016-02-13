__author__ = 'ee364d08'


import os, sys, re, math, operator
from pprint import pprint as pp

class Course:
    def __init__(self,course,a,b,c):
        self.courseID = course
        self.fst = a
        self.snd = b
        self.final = c
        self.total = a*0.25 + b*0.25 + c*0.5
        if self.total > 90:
            self.letter = 'A'
        elif self.total >= 80:
            self.letter = 'B'
        elif self.total >= 70:
            self.letter = 'C'
        else:
            self.letter = 'D'

    def getLetterGrade(self):
        return self.letter

    def __str__(self):
        string = self.courseID + ": (" + str('%.2f' %self.fst) + ", " + str('%.2f' %self.snd) + ", " + str('%.2f' %self.final) + ") = (" +  str('%.2f' %self.total) + ", " + self.letter + ")"
        return string

class Student:
    def __init__(self, name):
        self.name = name
        self.courses = {}

    def addCourse(self, course):
        self.courses.update({course.courseID:course} )

    def __str__(self):
        string = self.name + ": ("
        c = list(self.courses.keys())
        c.sort()
        a = ''
        for i in c:
            a += i + ': ' + self.courses[i].letter + "), ("
        string += a
        return string[0:-3]

    def generateTranscript(self):
        c = list(self.courses.keys())
        c.sort()
        a = self.name + '\n'
        for i in c:
            a += str(self.courses[i]) + '\n'
        return a[:-1]

class School:
    def __init__(self,s):
        self.name = s
        self.students={}

    def loadData(self,filename):
        f = open(filename, 'r')
        lines = f.readlines()
        for line in lines:
            f = re.findall(r'\d\d', line)
            f1 = re.search(r'\d\d', line)
            name = re.search(r'[A-Z][a-z]{1,} [A-Z][a-z]{1,}', line)
            if name is not None:
                student = Student(name.group())
                self.students.update({name.group(): student})
                b = name.group()
            if f1 is not None:
                a = Course(line[4:10], int(f[1]), int(f[2]), int(f[3]))
                self.students[b].addCourse(a)

    def __str__(self):
        a = list(self.students.keys())
        b = []
        b.append(self.name + ": " + str(len(self.students)) + ' Students')
        a.sort()
        for i in a:
            b.append(i)
        c = '\n'.join(b)
        return c

    def saveData(self, filename):
        f = open(filename, 'w')
        names =[]
        for name in self.students:
            names.append(name)
        names.sort()
        b = []
        for name in names:
            a = self.students[name].generateTranscript()
            b.append(a)
        print(b)
        c = '\n\n'.join(b)
        f.write(c)












