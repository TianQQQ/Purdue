//
//  SingleLinkedlist.cpp
//  HW3
//
//  Created by Tian Qiu on 16/3/21.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//


#include <stdio.h>
#include <iostream>
using namespace std;



template<class T>
struct linkedlist_node {
    T val;
    linkedlist_node<T> * next;
    
    // constructor
    linkedlist_node() : next(nullptr) {};
    
};


template <typename T>

class linkedlist{
    typedef linkedlist_node<T> * iterator_type;
    linkedlist_node<T> *iterator;
    size_t length;
    
public:
    
    linkedlist(){ iterator = 0;}
    linkedlist( T x){
        linkedlist();
        push_front(x);
        length++;
    }
    linkedlist (linkedlist_node<T> * node){
        iterator->val = node->val;
        node->next = iterator;
        iterator = node;
        length++;
    }
    
    ~linkedlist(){
        /*linkedlist_node<T> *p;
        while(iterator){
            p=iterator->next;
            delete iterator;
            iterator=p;
        }*/
    }
    
    iterator_type begin (){}  // useless
    
    iterator_type end(){    // useless
        linkedlist_node<T> *p = iterator;
        while(p->next->next){
            p=p->next;
        }
        return p->next;
    }
    //Return the iterator (pointer) to the first and last element.
    
    
    
    bool empty() const {return iterator == 0;}
    
    size_t size (){               // get the iterator size
        return length;
    }
    
    
    T & front(){
        if (!empty()) return iterator->val;
        else throw;
    }
    
    T & back(){
        linkedlist_node<T> *p = new linkedlist_node<T>;
        p = iterator;
        while(p->next){
            p = p->next;
        }
        return p->val;
    }
    //Get the next and last element.
    
    void push_front ( const T & x){
        linkedlist_node<T> * p = new linkedlist_node<T>;
        p->val = x;    // linked list destructor important!!! infinite loop
        p->next = iterator;
        iterator = p;
        length ++;
    }
    
    void push_back ( const T & x){
        linkedlist_node<T> *p = new linkedlist_node<T>;
        linkedlist_node<T> *pInsert;
        pInsert = (linkedlist_node<T> *)malloc(sizeof(linkedlist_node<T> *));
        pInsert->val = x;
        p = iterator;
        while(p->next){
            p=p->next;
        }
        p->next = pInsert;
        length++;
    }
    
    void pop_front(){
        T x;
        if (!empty()) {
            x = iterator -> val;
            linkedlist_node<T> *p = iterator;
            iterator = p -> next;
            length -- ;
        }
    }
    
    void pop_back(){
        linkedlist_node<T> *p = new linkedlist_node<T>;
        //p = end();
        //p = nullptr;
        p = iterator;
        while(p->next->next){
            p=p->next;
        }
        p->next = nullptr;
    }
    
    void remove ( const T & x){
        linkedlist_node<T> *p = new linkedlist_node<T>;
        linkedlist_node<T> *q = new linkedlist_node<T>;
        p = iterator;
        if (!p) {
            return;
        }
        
        if (p->val == x) {
            iterator = p->next;
            delete p;
            return;
        }
        
        q = p->next;
        while(q){
            if (x == q->val) {
                p->next = q->next;
                q = q->next;
                delete q;
            }else{
                p=q;
                q=q->next;
            }
        }
    }
    
    iterator_type GetPartion(iterator_type pBegin, iterator_type pEnd){
        int key = pBegin->val;
        iterator_type p = pBegin;
        iterator_type q = p->next;
        
        while(q != pEnd)
        {
            if(q->val < key)
            {
                p = p->next;
                swap(p->val,q->val);
            }
            
            q = q->next;
        }  
        swap(p->val,pBegin->val);
        return p;  
    }
    
    void Sort(iterator_type pBegin, iterator_type pEnd)
    {

        
        if(pBegin != pEnd)
        {
            iterator_type partion = GetPartion(pBegin,pEnd);
            Sort(pBegin,partion);
            Sort(partion->next,pEnd);
        }  
    }
    
    void Sort(){
        linkedlist_node<T> * pBegin = new linkedlist_node<T>;
        linkedlist_node<T> * pEnd = new linkedlist_node<T>;
        pBegin = iterator;
        pEnd = end();
        Sort(pBegin, pEnd);
    }
    
};

int main()
{
    
    
    linkedlist<char> a('x');
    cout << a.front() <<endl;
    
    int s1 = 1;
    int s2 = 20;
    
    
    linkedlist<int> s;
    for(int i = s2; i >= s1; --i ){
        s.push_front(i);
    }
    
    s.push_front(22);
    cout << s.back() << endl;
    s.push_back(25);
    s.push_back(5);
    cout << s.back() << endl;
    s.pop_back();
    cout << s.back() << endl;


    
    s.Sort();

    while(!s.empty()){
        cout << s.front() <<" ";
        s.pop_front();
    }
    cout << endl;
    
    
    
    for(int i = s2; i >= s1; --i ){
        s.push_front(i);
    }
    
    s.remove(10);
    
    while(!s.empty()){
        cout << s.front() <<" ";
        s.pop_front();
    }
    cout << endl;
    
    return 0;
}





