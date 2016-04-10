//
//  main.cpp
//  Determinent
//
//  Created by Tian Qiu on 16/4/6.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

//  矩阵的行列式计算
//  by fantuanxiaot
#include <iostream>
#include <cmath>
#include <iomanip>
#include <Matrix.h>
#include <MatrixIO.h>
#include <vector>
#include <string>
#include <random>
using namespace std;
using namespace Numeric_lib;
//  //////////////////////////////////////////////////////////////////////////////////////
//  //////////////////////////////////////////////////////////////////////////////////////
//  计算乘法
double Vector_Det(Matrix<double,2> a1,vector<int> num_list)
{
    if(a1.dim1()!=a1.dim2())
    {error("Not Square");}
    double result=1;
    for(int i=0;i<=a1.dim1()-1;i++)
    {
        result=result*a1[a1.dim1()-i-1][num_list[i]];
    }
    return result;
}
//  计算矩阵的行列式
double Matrix_Det(Matrix<double,2> a1)
{
    if(a1.dim1()!=a1.dim2())
    {error("Not Square");}
    int matrix_size=a1.dim1();
    //  判断
    if(matrix_size==1) return a1[0][0];
    const int list_num=matrix_size;
    //  构建排列对表
    vector<int> num_list(list_num);
    for(int i=0;i<=list_num-1;i++)
    {
        num_list[i]=list_num-i-1;
    }
    double sum=0;
    //  交换
    int temp;
    //  求代数和
    //  从大到小进行排列
    int n=0;
    int Time=1;
    while(Time<=list_num)
    {
        for(int j=0;j<=list_num-2;j++)
        {
            sum=sum+pow(-1,n)*Vector_Det(a1,num_list);
            n++;
            temp=num_list[j];
            num_list[j]=num_list[j+1];
            num_list[j+1]=temp;
        }
        Time=Time+1;
    }
    return sum;
}
//  //////////////////////////////////////////////////////////////////////////////////////
//  //////////////////////////////////////////////////////////////////////////////////////
//  试验
int main()
{
    Matrix<double,2> b(2,2);
    Matrix<double,2> a(3,3);
    Matrix<double,2> c(3,3);
    //  a矩阵的求值
    a[0]=0;
    a[1]=1;
    a[2]=2;
    //  b矩阵的求值
    b[0][0]=1;
    b[1][0]=2;
    b[0][1]=1;
    b[1][1]=6;
    //  c矩阵的求值
    c[0][0]=1;
    c[0][1]=1;
    c[0][2]=1;
    c[1][0]=1;
    c[1][1]=2;
    c[1][2]=3;
    c[2][0]=1;
    c[2][1]=2;
    c[2][2]=4;
    cout<<"一个矩阵"<<endl;
    cout<<b<<endl;
    cout<<"矩阵的行列式"<<endl;
    cout<<Matrix_Det(b)<<endl;
    cout<<"一个矩阵"<<endl;
    cout<<a<<endl;
    cout<<"矩阵的行列式"<<endl;
    cout<<Matrix_Det(a)<<endl;
    cout<<"一个矩阵"<<endl;
    cout<<c<<endl;
    cout<<"矩阵的行列式"<<endl;
    cout<<Matrix_Det(c)<<endl;
    return 0;
}