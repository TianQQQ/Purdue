//
//  main.cpp
//  option pricing
//
//  Created by Tian Qiu on 16/4/6.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <iomanip>
#include <iostream>
#include <string>
#include <vector>
#include <cmath>
#include <random>

using namespace std;


class stock{
    
    int t = 0;
    double P = 0.0;
    double miu = 0.0;
    double sigma = 0.0;
    double z = 0.0;
    
public:
    void getval(int m, double n, double o, double q){
        t = m;
        P = n;
        miu = o;
        sigma =q;
    }
    void update(){
        z = random_zScore_producer();
        t += 1;
        P = P* exp(miu-0.5*pow(sigma,2) + sigma * z);
    }
    int &gettime(){
        return t;
    }
    double &getprice(){
        return P;
    }
    
    double random_zScore_producer(){
        random_device rd;
        mt19937 gen(rd());
        // values near the mean are the most likely
        // standard deviation affects the dispersion of generated values from the mean
        normal_distribution<> d(0,1);
        return d(gen);
    }
};


class option{
    int CT = 0;
    int MT = 0;
    double r = 0.0;
    double K = 0.0;
    string type;
    double price, c = 0;
    double P = 0.0;
    double miu = 0.0;
    double sigma = 0.0;

public:
    void getval(int CTs, int MTs, double rate, double strike ,double P1, double miu1, double sigma1){
        CT = CTs;
        MT = MTs;
        r = rate;
        K = strike;
        P = P1;
        miu = miu1;
        sigma = sigma1;
    }
    
    double judgetype(string types){
        type = types;
        if (type == "call") {
            return call();
        }else if(type == "put"){
            return put();
        }else{
            throw;
        }
        //else return put();
    }

    double call(){
        int dur = MT - CT;
        while (CT < MT){
            stock B;
            stock *p = &B;
            
            p -> getval(CT, P, miu, sigma);
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
            p -> getval(CT,P,miu,sigma);
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
    A.update();
    cout << A.getprice()<<endl;
    option C;
    C.getval(1,3, 0.04, 40, 100 ,1.5 ,3);
    cout << C.judgetype("call") << endl;
    return 0;
}
