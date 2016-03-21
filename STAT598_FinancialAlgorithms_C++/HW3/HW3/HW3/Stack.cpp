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



template<class T>
struct stack_node {
    T val;
    stack_node<T> * next;
    
    // constructor
    stack_node() : next(nullptr) {};
    
};


template <typename T>

class stack{
    stack_node<T> *iterator;
    size_t length;

public:
    
    stack(){ iterator = 0;}
    stack( T x){
        stack();
        push(x);
        length++;
    }
    stack (stack_node<T> * node){
        iterator->val = node->val;
        node->next = iterator;
        iterator = node;
        length++;
    }
    
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
    
    stack_node<int> * node;
    node->val = 1;
    stack<int> b(node);
    
    stack<char> a('x');
    cout << a.top() <<endl;
    
    int s2 = 20;
    int s1 = 1;

    stack<int> s;
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













