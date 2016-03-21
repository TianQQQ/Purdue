//
//  Set.h
//  Vector
//
//  Created by Tian Qiu on 16/3/19.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//


/*
class myVector {
    double ∗p ;
    int nElements ;
public :
    myVector ( int ) ;
    //Constructor with input of nElements.
    myVector ( myVector &);
    //Copy constructor that performs deep copy .
    ̃myVector ( ) ;
    //Destructor . You need to delete what you new in constructor .
    friend myVector operator+(const myVector&, const myVector&);
    friend myVector operator∗(double , const myVector&);
    friend myVector operator ∗( const myVector&, double ) ;
    friend double operator∗(const myVector&, const myVector&);
    //vector addition , scalar multiplication and inner product .
    //Need to consider that you cannot add and inner product
    //two vectors with different length .
    
    myVector& operator= ( const myVector &);
    //Overloading assignment operator .
    
    double& operator [ ] ( int ) ;
    //Get the ith element of the vector.
    //i should start from 0. Need to consider the case that i >= nElements.
    
    friend double norm(const myVector&); //Euclidean norm.
    friend ostream& operator<< (ostream&, const myVector&); 
    friend istream& operator>> ( istream&, const myVector&); //Overloading of ”<<” and ”>>”.
    //Also need to overload ++/−−, which plus/minus each elements by one. //Need to consider both prefix and postfix.
};*/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>

using namespace std;

class myVector {
    double *p;
    int nElements;
public:
    myVector(int i) {
        nElements(i);
        elem = int[i];
        for (int j = 0; j < i; j++)
            elem[j] = 0;
        int size = i;
    }
    /*myVector(myVector &c) {
        for (int i = 0; i < size; i++) {
            elem[i] = c.p[i];
        }
    }
    ~myVector();
    friend myVector operator+(const myVector&, const myVector&);
    friend myVector operator*(double, const myVector&);
    friend myVector operator*(const myVector&, double);
    friend double operator*(const myVector&, const myVector&);
    myVector& operator= (const myVector &);*/
    
    friend ostream& operator<< (ostream&, const myVector&);
    
};


ostream& operator<<(ostream& os, const myVector & c){
    for (int j = 0; j < c.nElements; j++)
        os << "myVector[" << j << "]" << " = " << c[j] << endl;
    return os;
}






int main() {
    myVector a(1);
    cout << a;
    
    return 0;
}









