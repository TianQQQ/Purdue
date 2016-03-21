//
//  main.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/18.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <iostream>
#include "complex.hpp"



int main(int argc, const char * argv[]) {
    complex c1(3, 4), c2(4.0, -2.0) , c4;
    complex c3 = c2;
    cout<<"c1+c2 = "<<(c1+c2);
    cout<<"c1-c2 = "<<(c1-c2);
    cout<<"c1*c2 = "<<(c1*c2);
    cout<<"c1/c2 = "<<(c1/c2);
    cout<<"c3 = "<<(c3);
    
    cin>>c4;
    cout<<"c4 = "<< c4;
    
    cout << re(c1) << endl;
    cout << im(c1) << endl;
    cout << abs(c1) << endl;
    arg(c1);
    conj(c1);
    cout << pow(c1, 3) << endl; // c1 's power 2
    
    return 0;
}
