//
//  stack_test.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/20.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <stdio.h>
#include <iostream>
using namespace std;



//............................................................................................................
/*
 
 
 public :

 
 //Destructor .
 size t size ();
 bool empty ( ) ;
 //Return the size of the list and whether it is empty.
 T& top();
 void push ( const T&);
 void pop();
 //Get the top element, push new element to the top //and remove the top element .
 };
 
 */

template<class T>
struct stack_node {
    T * next;
    T val;
    stack_node(T * n) : next(n) {};
};

template<class T>
class stack {
    typedef stack_node<T> node ;
    typedef stack_node<T> * iterator ;
    typedef stack_node<T> & reference ; //Some type define .
    
    iterator first ;
    iterator last ;
    size_t length ;
    //Three variables we keep.
    
    public :
    stack (){
        
    }//Constructor with no parameter .
    stack (T){
        
    }
    stack ( node ) {
        
    }//Copy constructor with one node as parameter .
    stack ( stack &){
        
    }
    ~stack (){
        
    }
};

int main(){
    stack<int> a;
}

