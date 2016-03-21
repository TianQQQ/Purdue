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


/*
 typedef int T;
 
 //链表类
 class LinkedList
 {
 struct Node
 {
 T data;
 Node* next;
 //初始化data next 阻止垃圾数据
 Node(const T& t=T()):data(t),next(NULL)
 {
 }
 };
 public:
 //构造  析构  清空
 LinkedList():head(NULL)
 {
 }
 ~LinkedList()
 {
 clear();
 }
 
 void clear()
 {
 Node *p=head;
 while (p!=NULL)
 {
 Node *q = p->next;
 delete p;//释放p所在空间
 p=q;
 }
 }
 //判断empty 求size  遍历(travel)
 bool empty()
 {
 //判断头指针是否为空 为空表示链表不存在
 return head==NULL ? true : false;
 }
 unsigned int size()
 {
 unsigned int size=0;
 Node* p =head;
 while (p!=NULL)
 {
 size++;
 p=p->next;
 }
 return size;
 }
 
 void travel()
 {
 //利用while循环一次次的输出来，直到指针为NULL结束
 Node* p = head;
 while (p!=NULL)
 {
 cout<<p->data<<endl;
 p=p->next;
 }
 }
 //增(insertAfter insertFront)删改查(find)
 void insertFront(const T& t)
 {
 Node* p = new Node(t);
 p->next=head;  //讲头指针所指向的地址给p的next
 head = p;       //让*p作为头
 }
 void insertAfter(const T& t)
 {
 Node *p = new Node(t);
 Node *tail = getPointer(size()-1);
 tail->next = p;
 }
 void erase(const T& t)
 {
 unsigned int position = find(t);
 Node* cur = getPointer(position);
 if (position!=0)
 {
 Node* pre = getPointer(find(t)-1);
 pre->next = cur->next;
 }else{
 head = cur->next;
 }
 delete cur;
 }
 void update(const T& t,const T& target)
 {
 Node *p=getPointer(find(target));
 p->data=t;
 }
 unsigned int  find(const T& t)
 {
 unsigned int position=0;
 Node* p = head;
 while(p!=NULL)
 {
 if (p->data==t)
 {
 return position;
 }
 p=p->next;
 position++;
 }
 return position;
 }
 
 //取头 取尾
 T getHead()
 {
 return head->data;
 }
 T getTail()
 {
 Node *p=getPointer(this->size()-1);
 return p->data;
 }
 //去指定位置取指针  辅助作用
 Node* getPointer(int position)
 {
 Node* p =head;
 for(int i = 0;i<position;i++)
 {
 p=p->next;
 }
 return p;
 }
 private:
 //头指针 最重要的部分
 Node* head;
 };
 
 class Stack
 {
 public:
 //构造器 析构器（和clear）压入 (push) 弹出pop 取出top 大小和非空empty
 Stack()
 {
 list = new LinkedList;
 }
 ~Stack()
 {
 clear();
 }
 void clear()
 {
 list->clear();
 }
 void push(const T& t)
 {
 list->insertFront(t);
 }
 void pop()
 {
 list->erase(list->getHead());
 }
 T top()
 {
 return list->getHead();
 }
 unsigned int size()
 {
 return list->size();
 }
 bool empty()
 {
 return list->empty();
 }
 
 private:
 LinkedList* list;
 };
 
 
 
 
 
 */
//............................................................................................................
/*
 
 
 public :
 stack ();//Constructor with no parameter .
 stack(T);
 stack ( node ) ; //Copy constructor with one node as parameter .
 stack ( stack &);
 ~stack ();
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
    stack_node(T * _next) : next( _next) {}
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
    stack ();//Constructor with no parameter .
};

int main(){
    stack<int> a;
}

