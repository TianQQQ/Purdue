//
//  blackScholes.cpp
//  Finacial Algorithms
//
//  Created by Tian Qiu on 16/4/16.
//  Copyright © 2016年 Tian Qiu. All rights reserved.
//

#include <iostream>
#include <string>
#include <cmath>
#include <stdio.h>
#include <math.h>

#define e 2.718281828
using namespace std;


double max(double a, double b) {
    double c = a, d = b;
    if (a >= b) return a;
    else return b;
}

double normal_cdf(double x) {
    double a1 = 0.254829592;
    double a2 = -0.284496736;
    double a3 = 1.421413741;
    double a4 = -1.453152027;
    double a5 = 1.061405429;
    double p = 0.3275911;
    
    int sign = 1;
    if (x < 0)
        sign = -1;
    x = fabs(x) / sqrt(2.0);
    // A&S formula
    double t = 1.0 / (1.0 + p*x);
    double y = 1.0 - (((((a5*t + a4)*t) + a3)*t + a2)*t + a1)*t*exp(-x*x);
    
    return 0.5*(1.0 + sign*y);
}
double binary(double price, double volatility, double strike, double rate, int time_to_maturity, string type) {
    double S = price, sigma = volatility, K = strike, r = rate;
    int T = time_to_maturity;
    string types = type;
    
    double d1 = (log(S / K) + r + pow(sigma, 2)*T / 2) / (sigma*sqrt(T));
    double d2 = d1 - sigma*sqrt(T);
    
    if (types == "CashOrNothingCall") {
        return max(pow(e, -r*T)*normal_cdf(d2),0);
    }
    if (types == "CashOrNothingPut") {
        return max(pow(e, -r*T)*normal_cdf(-d2),0);
    }
    if (types == "AssetOrNothingCall") {
        return max(S*normal_cdf(d1),0);
    }
    if (types == "AssetOrNothingPut") {
        return max(S*normal_cdf(-d1),0);
    }
    else return 0.0;
}

double black_scholes(double price, double volatility, double strike, double rate, int time_to_maturity, string type) {
    double S = price, sigma = volatility, K = strike, r = rate;
    int T = time_to_maturity;
    string types = type;
    
    double d1 = (log(S / K) + r + pow(sigma, 2)*T / 2) / (sigma*sqrt(T));
    double d2 = d1 - sigma*sqrt(T);
    
    if (types == "call") {
        return max(S*normal_cdf(d1) - K * pow(e, -r*T)*normal_cdf(d2),0);
    }
    if (types == "put") {
        return max(K*pow(e, -r*T)*normal_cdf(-d2) - S*normal_cdf(-d1),0);
    }
    else return 0.0;
}
