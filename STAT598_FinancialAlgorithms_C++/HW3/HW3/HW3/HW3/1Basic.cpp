//
//  1Basic.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/18.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include "1Basic.hpp"


/*
 1. Reference.
 • A reference must be initialized when defined.
 • A reference can be used as return value, in which case we can do things like f () + +.
 • We can use const reference as input parameter for a function, in which situation we cannot
 modify the value of the original variable through this reference inside the function. 
*/

int f(int &a){
    a = 1;
    return a++;
}

int main(){
    int &a;
    f(a)
}

