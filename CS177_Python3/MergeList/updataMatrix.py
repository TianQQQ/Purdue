def updateMatrix(matrix):
    
    n = len(matrix)
    m = len(matrix[0])
    a = 0

    for i in range(0,n):
        if i % 2 == 0:
            while (a < m):
                matrix[i][a] += 1
                a += 1
            a = 0
        if i % 2 == 1:
            while (a < m):
                matrix[i][a]+= 2
                a += 1
            a = 0

def main():
    matrix = [[1,2,3],[4,5,6],[7,8,9]]
    updateMatrix(matrix)
    m = len(matrix[0])
    print(matrix[0][0], matrix[0][1], matrix[0][2])
    print(matrix[1][0], matrix[1][1], matrix[1][2])
    print(matrix[2][0], matrix[2][1], matrix[2][2])
main()
    
