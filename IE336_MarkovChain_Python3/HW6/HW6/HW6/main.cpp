//
//  main.cpp
//  HW6
//
//  Created by Tian Qiu on 16/2/24.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <vector>

using namespace std;


void matrixMultiplication(double p[][], int n) {
    int * * arr = (int * * )malloc(n * sizeof(int *));
    for (int i=0; i<n; i++) arr[i] = (int *)malloc(m * sizeof(int));
    
    
    for (int i = 0; i < n; i++) {
        arr[i][0] = 1;
        arr[i][i] = 1;
        for (int j = 1; j < i; j++) {
            arr[i][j] = arr[i-1][j] + arr[i-1][j-1];
        }
    }
    
    cout << arr[n-1][m-1] << endl;
    free(arr);

}

int main() {
    
    int n = 4;
    
    matrixmultiplication(p, n);
    
    
}