//
//  complex.hpp
//  HW3
//
//  Created by Tian Qiu on 16/3/18.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#ifndef complex_hpp
#define complex_hpp

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>

using namespace std;

class complex {
    double re;
    double im;
    
public :
    complex(){ re=im=0; }
    complex(double re):re(re), im(0){};
    complex(double re, double im):re(re), im(im){};
    //Why don’t we write a copy constructor and destructor?
    // Becasue we dont need it.
    
    complex operator+(const complex & c){
        return complex(re+c.re, im+c.im);
    }
    complex operator-(const complex & c){
        return complex(re-c.re, im-c.im);
    }
    complex operator*(const complex & cp){
        int a = re;
        int b = im;
        int c = cp.re;
        int d = cp.im;
        return complex(a*c-b*d, b*c+a*d);
    }
    complex operator/(const complex & cp){
        int a = re;
        int b = im;
        int c = cp.re;
        int d = cp.im;
        return complex((a*c+b*d)/(c^2+d^2), (b*c-a*d)/(c^2+d^2));
    }
    complex operator=(const complex & c){
        return complex(re, im);
    }
    


    friend ostream& operator<<(ostream&, const complex&);
    friend istream& operator>>(istream&, complex&);
    friend double re (const complex &);
    friend double im (const complex &);
    friend double abs (const complex &);
    friend void arg (const complex &);
    friend void conj (const complex &);
    friend double sqrt (const complex &);
    //friend complex pow (const complex ,int p);
    //Also need to implement im, obs , arg , conj , sqrt , pow as friend functions .
    //Need to use appropriate type of parameters and return value.
};


ostream& operator<<(ostream& os, const complex& c){
    os << '(' << c.re << ',' << c.im << ')' << endl;
    return os;
}

istream& operator>>(istream& input, complex& c){
    cout << "please enter real and imaginary number: " << endl;
    input  >> c.re >> c.im ;
    return input;
}
double re (const complex & c){
    return c.re;
}
double im (const complex & c){
    return c.im;
}
double abs (const complex & c){
    return sqrt(int(c.im*c.im + c.re*c.im));
}
void arg (const complex & c){
    cout << acos(c.re/(sqrt(pow(c.re,2)+pow(c.im,2))))<< endl;
}
void conj (const complex & c){
    cout << '(' << c.re << ',' << -c.im << ')' << endl;
}
complex pow (const complex c, int p){
    complex c1 = c;
    for (int i = 1; i<p; i++) {
        c1 = c1 * c;
    }
    return c*c;
}





#endif /* complex_hpp */
