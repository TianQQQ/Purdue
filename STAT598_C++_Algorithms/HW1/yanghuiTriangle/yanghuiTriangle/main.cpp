//
//  main.cpp
//  yanghuiTriangle
//
//  Created by Tian Qiu on 16/1/25.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <iostream>
#include "stdio.h"
#include "stdlib.h"
#include "vector"

using namespace std;

void yanghuiTri(int n, int m){
    //int arr[n][m];
    //int * arr;
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



int main(int argc, const char * argv[]) {
    // insert code here...
    yanghuiTri(5, 3);
    std::cout << "Hello, World!\n";
    return 0;
}
