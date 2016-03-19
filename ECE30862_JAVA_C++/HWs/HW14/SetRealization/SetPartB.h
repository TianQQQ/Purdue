//
//  SetB.h
//  SetRealization
//
//  Created by Tian Qiu on 11/15/15.
//  Copyright © 2015 Tian Qiu. All rights reserved.
//

#ifndef SetB_h
#define SetB_h

#include <vector>
#include <iostream>
using namespace std;

int count;



class Set{
public:
    Set(const int len) { vec.clear();  ::count++;}

    int getCopyCount();
    friend void print(const Set &c);
    //friend ostream& operator<<(ostream &os, const  Set & n);
    vector<int> vec;
    vector<int>::iterator it;
};

Set operator +(const Set &c, const int d);
Set operator -(const Set &c, const int d);
Set operator &(const Set &c, const Set &d);
Set operator /(const Set &c, const Set &d);
Set operator ~(const Set &c);

ostream& operator<<(ostream &os, const Set & c)
{
    for (int i = 0; i < c.vec.size(); i++) {
        cout << c.vec[i] << ' ';
    }
    return os;
}

inline int Set::getCopyCount(){
    return ::count - 66;
}

inline Set operator +(const Set &c, const int a){
    Set b(63);
    b = c;
    b.it = find(b.vec.begin(),b.vec.end(),a);
    if (b.it == b.vec.end()){
        b.vec.push_back(a);
    }
    return b;
}

inline Set operator -(const Set &c, const int a){
    Set b(63);
    b = c;
    b.it = find(b.vec.begin(),b.vec.end(),a);
    if (b.it != b.vec.end()){
        b.vec.erase(b.it++);
    }
    return b;
}

inline Set operator &(const Set &d, const Set &c){
    Set a(63);
    for (int i = 0; i < c.vec.size(); i++) {
        for (int j = 0; j < d.vec.size(); j++) {
            if (c.vec[i] == d.vec[j]) {
                a.vec.push_back(d.vec[j]);
            }
        }
    }
    return a;
}

inline Set operator /(const Set &d, const Set &c){
    Set a(63);
    for (int i = 0; i < d.vec.size(); i++) {
        bool found = false;
        for (int j = 0; j < c.vec.size(); j++) {
            if (c.vec[j] == d.vec[i]) {
                found = true;
            }
        }
        if (!found) {
            a.vec.push_back(d.vec[i]);
            found = false;
        }
    }
    return a;
}

inline Set operator ~(const Set &c){
    Set a(63);
    for (int i = 0; i < 64; i++) {
        a = a + i;
    }
    for (int i = 0; i < c.vec.size(); i++) {
        a = a - c.vec[i];
    }
    return a;
}


void print(const Set &c)
{
    for (int i = 0; i < c.vec.size(); i++) {
        cout << c.vec[i] << ", ";
    }
}


#endif /* SetB_h */
