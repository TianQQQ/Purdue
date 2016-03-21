//
//  Set.h
//  Vector
//
//  Created by Tian Qiu on 16/3/19.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

/*
    //Also need to overload ++/−−, which plus/minus each elements by one. //Need to consider both prefix and postfix.
};*/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>

using namespace std;

class myVector {
    double * p;
    int nElements;
    
public:
    myVector(){
        nElements = 0;
    }
    
    myVector(int i) {
        p = (double * )malloc(sizeof(int)*i);
        for (int j = 0; j < i; j++)
            p[j] = 0;
        nElements = i;
    }
    
    ~myVector( ){
        //free(p);
    }
    
    myVector(myVector &c) {
        p = (double * )malloc(sizeof(int)*c.nElements);
        for (int i = 0; i < c.nElements; i++) {
            p[i] = c.p[i];
        }
        nElements = c.nElements;
    }
    
    double & operator [ ] ( int ind) {
        double result = p[ind];
        return result;
    }
    
    friend myVector operator+(const myVector&, const myVector&);
    friend myVector operator*(double, const myVector&);
    friend myVector operator*(const myVector&, double);
    friend double operator*(const myVector&, const myVector&);
    
    friend myVector operator++(const myVector&);
    friend myVector operator--(const myVector&);
    
    
    friend ostream& operator<< (ostream&, const myVector&);
    friend istream& operator>> (istream&, myVector&);
    
    friend double norm(const myVector&); //Euclidean norm.
    
};

myVector operator++(const myVector& V1 ){
    myVector result(V1.nElements);
    for (int i = 0; i < V1.nElements; i++) {
        result.p[i] = V1.p[i] + 1;
    }
    return result;
}

myVector operator--(const myVector& V1 ){
    myVector result(V1.nElements);
    for (int i = 0; i < V1.nElements; i++) {
        result.p[i] = V1.p[i] - 1;
    }
    return result;
}

double norm(const myVector& V){
    double r = 0.0;
    for (int i = 0; i < V.nElements; i++) {
        r += V.p[i] * V.p[i];
    }
    
    r = sqrt(r);
    return r;
}

ostream& operator<<(ostream& os, const myVector & c){
    for (int j = 0; j < c.nElements; j++)
        os << "myVector[" << j << "]" << " = " << c.p[j] << endl;
    return os;
}

istream& operator>>(istream & input, myVector & V){                 // myVector should not be constant!!!!!
    cout << "please enter elements number: ";
    input >> V.nElements;
    V.p = (double * )malloc(sizeof(int)*V.nElements);
    cout << "please enter each element: ";
    for (int i = 0; i < V.nElements; i++) {
        input >> V.p[i];
    }
    return input;
}

myVector operator+(const myVector & V1, const myVector & V2){
    if (V1.nElements != V2.nElements){
        throw ;
    }else{
        myVector result(V1.nElements);
        for (int i = 0; i < V1.nElements; i++) {
            result.p[i] = V1.p[i] + V2.p[i];
        }
        return result;
    }
}

myVector operator*(double x, const myVector& V1){
    myVector result(V1.nElements);
    for (int i = 0; i < V1.nElements; i++) {
        result.p[i] = V1.p[i] * x;
    }
    return result;
}


myVector operator*(const myVector& V1,  double x){
    myVector result(V1.nElements);
    for (int i = 0; i < V1.nElements; i++) {
        result.p[i] = V1.p[i] * x;
    }
    return result;
}

double operator*(const myVector& V1, const myVector& V2){
    if (V1.nElements != V2.nElements){
        throw ;
    }else{
        double result = 0.0;
        for (int i = 0; i < V1.nElements; i++) {
            result += V1.p[i] * V2.p[i];
        }
        return result;
    }

}



int main() {
    myVector a(3);
    myVector b(a),d;
    
    //cout << b;
    //cout << a;
    cin >> d;
    myVector c(3);
    c = a + d;
    cout << c;
    d = 2 * c;
    cout << d;
    double x = c * d;
    cout << " c * d is " << x << endl;
    
    cout << "second element of d is " << d[1] << endl;
    
    cout << "norm of d is " << norm(d) << endl;
    
    cout << --d;
    cout << ++d;

    
    return 0;
}









