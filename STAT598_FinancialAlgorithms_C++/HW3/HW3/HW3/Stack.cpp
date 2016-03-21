//
//  Stack.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/20.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <stdio.h>


/*一）、类模板的定义
 template  <类型形参表>
 class  <类名>
 {     //类说明体  }；
 template  <类型形参表>
 <返回类型> <类名> <类型名表>::<成员函数1>（形参表）
 {     //成员函数定义体  }
 template  <类型形参表>
 <返回类型> <类名> <类型名表>::<成员函数2>（形参表）
 {     //成员函数定义体  }
 …
 template  <类型形参表>
 <返回类型> <类名> <类型名表>::<成员函数n>（形参表）
 {     //成员函数定义体  }*/
/*
template<class T>
struct stack_node{
    T next;
    T val;
    stack node(T∗ next) : next( next) {}
};*/