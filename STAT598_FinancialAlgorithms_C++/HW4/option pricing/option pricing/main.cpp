//
//  main.cpp
//  option pricing
//
//  Created by Tian Qiu on 16/4/6.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//


#include <iostream>
#include <string>
#include <vector>
#include <cmath>
using namespace std;


class stock{
    int t;
    double P;
    double miu;
    double sigma;
    int z = 0;
    
public:
    void getval(int m, double n, double o, double q){
        t = m;
        P = n;
        miu = o;
        sigma =q;
    }
    void update(){
        t += 1;
        P = P* exp(miu-0.5*pow(sigma,2) + sigma * z);
    }
    int &gettime(){
        return t;
    }
    double &getprice(){
        return P;
    }
};


class option{
    int CT;
    int MT;
    double r;
    double K;
    char type;
    int price, c;
public:
    void getval(int CTs, int MTs, double rate, double strike){
        CT = CTs;
        MT = MTs;
        r = rate;
        K = strike;
    }
    /*double judgetype(char types){
     type =types;
     if (type = "Call") return call();
     //else return put();
     }*/
    double call(){
        int dur = MT - CT;
        while (CT < MT){
            stock B;
            stock *p = &B;
            p -> getval(CT,100,2,1);
            p -> update();
            price = p -> getprice();
            CT = p -> gettime();
        }
        if (price > K)  c = (price - K) / pow((1+r),dur);
        else  c = 0;
        return c;
    }
    double put(){
        int dur = MT - CT;
        while (CT < MT){
            stock B;
            stock *p = &B;
            p -> getval(CT,100,2,1);
            p -> update();
            price = p -> getprice();
            CT = p -> gettime();
        }
        if (price < K) c = ( K - price )/ pow((1+r),dur);
        else c = 0;
        return c;
    }
};

int main(){
    stock A;
    A.getval(1,30,40,2);
    A.update();
    cout << A.getprice()<<endl;
    option C;
    C.getval(1,3,0.04,5);
    C.call();
    return 0;
}
