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

 
 //Return the size of the list and whether it is empty.
 T& top();
 void push ( const T&);
 void pop();
 //Get the top element, push new element to the top //and remove the top element .
 };
 
 

template<class T>
struct stack_stack_node {
    T * next;
    T val;
    stack_stack_node(T * n) : next(n) {};
};

template<class T>
class stack {
    typedef stack_stack_node<T> node ;
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
    
    bool empty(){
        return first == NULL;
    }
    size_t size (){
        return length;
    }
    
    T & top(){
        if (!empty()) return 0;
    }
    
    void push ( const T & x){
        stack_node<T> *p;
        p->val = x;
        p->next = iterator;
        iterator = p;
        return *this;
    }
    
    
};


 
 */


template <typename T>
class stack;

template <typename T>
class stack_node{
    T val;
    stack_node<T> *next;
    friend class stack<T>;
};

template <typename T>

class stack{
    stack_node<T> *iterator;
    
    size_t length;
    
    
    
    
public:
    stack(){ iterator = 0;}
    ~stack(){
        stack_node<T> *p;
        while(iterator ){
            p=iterator->next;
            delete iterator;
            iterator=p;
        }
    }
    
    
    
    bool empty() const {return iterator == 0;}
    
    size_t size (){               // get the iterator size
        return length;
    }
    
    T & top(){
        if (!empty()) return iterator->val;
        else throw;
    }
    
    
    
    void push ( const T & x){
        stack_node<T> * p = new stack_node<T>;
        p->val = x;    // linked list destructor important!!! infinite loop
        p->next = iterator;
        iterator = p;
        length ++;
    }
    
    void pop(){
        T x;
        if (!empty()) {
            x = iterator -> val;
            stack_node<T> *p = iterator;
            iterator = p -> next;
            delete p;
            length -- ;
        }
    }
};








int main()
{
    int s1,s2;
    s1='A';
    s2='Z';
    stack<char> s;
    for(int i=s2;i>=s1;--i){
        s.push(i);
    }
    
    while(!s.empty()){
        cout << s.top() <<" ";
        s.pop();
    }
    cout << endl;
    return 0;
}
















