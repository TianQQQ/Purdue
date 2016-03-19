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
#include <ostream>

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
        return complex(c.re, c.im);
    }
    


    friend ostream& operator<<(ostream&, const complex&); //Also need to include >> in istream.
    
    friend double re (const complex &);
    //Also need to implement im, obs , arg , conj , sqrt , pow as friend functions .
    //Need to use appropriate type of parameters and return value.
};
#endif /* complex_hpp */
