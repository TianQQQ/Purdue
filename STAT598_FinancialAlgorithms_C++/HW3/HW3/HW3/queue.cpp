//
//  queue.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/21.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <stdio.h>
#include <iostream>
using namespace std;



template<class T>
struct queue_node {
    T val;
    queue_node<T> * next;
    
    // constructor
    queue_node() : next(nullptr) {};
    
};


template <typename T>

class queue{
    queue_node<T> *iterator;
    size_t length;
    
public:
    
    queue(){ iterator = 0;}
    queue( T x){
        queue();
        push(x);
        length++;
    }
    queue (queue_node<T> * node){
        iterator->val = node->val;
        node->next = iterator;
        iterator = node;
        length++;
    }
    
    ~queue(){
        queue_node<T> *p;
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
    

    T& front(){
        if (!empty()) return iterator->val;
        else throw;
    }
    
    T& back(){
        queue_node<T> *p = iterator;
        while(p->next){
            p=p->next;
        }
        return p->val;
    }
    //Get the next and last element.
    
    void push ( const T & x){
        queue_node<T> * p = new queue_node<T>;
        p->val = x;    // linked list destructor important!!! infinite loop
        p->next = iterator;
        iterator = p;
        length ++;
    }
    
    void pop(){
        T x;
        if (!empty()) {
            x = iterator -> val;
            queue_node<T> *p = iterator;
            iterator = p -> next;
            delete p;
            length -- ;
        }
    }
};

int main()
{

    
    queue<char> a('x');
    cout << a.front() <<endl;
    
    int s2 = 20;
    int s1 = 1;
    
    queue<int> s;
    for(int i=s2;i>=s1;--i){
        s.push(i);
    }
    
    cout << s.back() << endl;
    
    while(!s.empty()){
        cout << s.front() <<" ";
        s.pop();
    }
    cout << endl;
    return 0;
}





