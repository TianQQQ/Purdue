#! /usr/bin/env python3.4

import sys
import os, math


def checkIfMatrixIsValid(matrix):
    if type(matrix[0]) != list:
        return False
    if len(matrix) == 1:   # just have one element
        return True
    init_length = len(matrix[0])
    for i in matrix:
        if len(i) != init_length:
            return False
    return True

def getMatrixSize(matrix):
    if checkIfMatrixIsValid(matrix) == False:
        return []
    columnCount = len(matrix[0])
    counter = 0
    for i in matrix:
        counter += 1
    rowCount = counter
    return [rowCount, columnCount]

def getRow(matrix, rowIndex):
    if checkIfMatrixIsValid(matrix) == False:
        return []
    matrixinfo = getMatrixSize(matrix)
    if matrixinfo[0] <= rowIndex: # greater than largest row
        return []
    return matrix[rowIndex]

def getColumn(matrix, columnIndex):
    if checkIfMatrixIsValid(matrix) == False:
        return []
    matrixinfo = getMatrixSize(matrix)
    if matrixinfo[1] <= columnIndex:
        return []
    counter = 0
    column = []
    for i in matrix:
        column.append(i[columnIndex]) # append elements of specific column
    return column

def transposeMatrix(matrix):
    if checkIfMatrixIsValid(matrix) == False:
        return None
    matrixinfo = getMatrixSize(matrix)
    return_matrix = []
    for i in range(matrixinfo[1]):
        return_matrix.append(getColumn(matrix, i))
    return return_matrix

def dotProduct(row, column):
    if len(row) != len(column) or len(row) <= 0:
        return None
    sum = 0
    for i in range(len(row)):
        sum += row[i] * column[i]
    return sum

def multiplyMatrices(matrix1, matrix2):
    if checkIfMatrixIsValid(matrix1) == False or checkIfMatrixIsValid(matrix2) == False:
        return None
    matrixinfo_1 = getMatrixSize(matrix1)
    matrixinfo_2 = getMatrixSize(matrix2)
    if matrixinfo_1[1] != matrixinfo_2[0]:
        return None
    matrix2t = transposeMatrix(matrix2)
    return_matrix = [[0] * matrixinfo_1[0] for i in range(matrixinfo_2[1])]
    #set range for matrix [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    for j in range(matrixinfo_1[0]):
        for k in range(matrixinfo_2[1]):
            return_matrix[j][k] = dotProduct(matrix1[j], matrix2t[k])
    return return_matrix

def main():
    mat1 = [[3, 2, 1], [4, 5], [3, 1, 0]]
    c = checkIfMatrixIsValid(mat1)
    #print(c)
    mat2 = [[9, 1], [1, 3], [3, 1]]
    d = checkIfMatrixIsValid(mat2)
    #print(d)
    mat3 = [[9, 8, 5, 2]]
    e = checkIfMatrixIsValid(mat3)
    #print(e)
    mat4 = [[1], [4], [7], [2]]
    f = checkIfMatrixIsValid(mat4)
    #print(f)
    mat5 = [1, 6, 1, 2, 3]
    g = checkIfMatrixIsValid(mat5)
    #print(g)
    t = getMatrixSize(mat2)
    #print(t)
    w = getMatrixSize(mat1)
    #print(w)
    r = getRow(mat2, 1)
    #print(r)
    r = getRow(mat2, 3)
    #print(r)
    r = getRow(mat1, 0)
    #print(r)
    c = getColumn(mat2, 0)
    #print(c)
    c = getColumn(mat2, 3)
    #print(c)
    c = getColumn(mat1, 0)
    #print(c)
    t = transposeMatrix(mat2)
    #print(t)
    t = transposeMatrix(mat1)
    #print(t)

    row1 = [6, 2, 9, 0]
    column1 = [1, 3, 2, 1]
    d = dotProduct(row1, column1)
    #print(d)

    
    t = transposeMatrix(mat2)
    m = multiplyMatrices(mat2, t)
    print(m)

    return 0

if __name__ == "__main__":
    main()
