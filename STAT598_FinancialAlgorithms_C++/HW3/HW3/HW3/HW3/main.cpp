//
//  main.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/18.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <iostream>
#include "complex.cpp"



int main(int argc, const char * argv[]) {
    complex c1(2.0, 3.0), c2(4.0, -2.0), c3;
    c3 = c1 + c2;
    cout<<"/nc1+c2=";
    printf(c3);
    c3 = c1 - c2;
    cout<<"/nc1-c2=";
    print(c3);
    c3 = c1 * c2;
    cout<<"/nc1*c2=";
    print(c3);
    c3 = c1 / c2;
    cout<<"/nc1/c2=";
    print(c3);
    c3 = (c1+c2) * (c1-c2) * c2/c1;
    cout<<"/n(c1+c2)*(c1-c2)*c2/c1=";
    print(c3);
    cout<<endl;
    std::cout << "Hello, World!\n";
    return 0;
}
