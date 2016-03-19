//
//  Set.h
//  Vector
//
//  Created by Tian Qiu on 16/3/19.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#ifndef Set_h
#define Set_h
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
    friend ostream& operator<< (ostream&, const myVector&); friend istream& operator>> ( istream&, const myVector&); //Overloading of ”<<” and ”>>”.
    //Also need to overload ++/−−, which plus/minus each elements by one. //Need to consider both prefix and postfix.
};
#endif /* Set_h */
