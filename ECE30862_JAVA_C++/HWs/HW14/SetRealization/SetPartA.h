//
//  partA.h
//  HW14  Overload for Set
//
//  Created by Tian Qiu on 11/14/15.
//  Copyright © 2015 Tian Qiu. All rights reserved.
//

#include <vector>
#include <iostream>
using namespace std;

int count;

class Set{
public:
    Set(const int len) { vec.clear();  ::count++;}
    Set operator +(const int c);
    Set operator -(const int c);
    Set operator &(const Set &c);
    Set operator /(const Set &c);
    Set operator ~();
    int getCopyCount();
    //void operator <<(const Set &c);
    //friend void print(const Set &c);
    //friend ostream& operator<<(ostream &os, const  Set & n);

    
    vector<int> vec;
    vector<int>::iterator it;
};

ostream& operator<<(ostream &os, const Set & c)
{
    for (int i = 0; i < c.vec.size(); i++) {
        cout << c.vec[i] << ' ';
    }
    return os;
}

inline int Set::getCopyCount(){
    return ::count * 3;
}

inline Set Set::operator +(const int a){
    it = find(this->vec.begin(),this->vec.end(),a);
    if (it == this->vec.end()){
        this->vec.push_back(a);
    }
    return *this;
}

inline Set Set::operator -(const int a){
    it = find(vec.begin(),vec.end(),a);
    if (it != vec.end()){
        vec.erase(it++);
    }
    return *this;
}

inline Set Set::operator &(const Set &c){
    Set a(63);
    for (int i = 0; i < c.vec.size(); i++) {
        for (int j = 0; j < vec.size(); j++) {
            if (c.vec[i] == vec[j]) {
                a.vec.push_back(vec[j]);
            }
        }
    }
    return a;
}

inline Set Set::operator /(const Set &c){
    Set a(63);
    for (int i = 0; i < vec.size(); i++) {
        bool found = false;
        for (int j = 0; j < c.vec.size(); j++) {
            if (c.vec[j] == vec[i]) {
                found = true;
            }
        }
        if (!found) {
            a.vec.push_back(vec[i]);
            found = false;
        }
    }
    return a;
}

inline Set Set::operator ~(){
    Set a(63);
    for (int i = 0; i < 64; i++) {
        a = a + i;
    }
    for (int i = 0; i < vec.size(); i++) {
        a = a - vec[i];
    }
    return a;
}


void print(const Set &c)
{
    for (int i = 0; i < c.vec.size(); i++) {
        cout << c.vec[i] << ", ";
    }
}
