//
//  main.cpp
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
#include "binomialSimulation.cpp"
#include "blackScholes.cpp"


using namespace std;
int main()
{
    BinomialSimulation b(0.2, 0.05, 2, 4, 100, 110);
    double c = b.SingleEuropeanCall();
    cout << "The price of a single European call is: " << c << endl;
    double d = b.SingleAmericanCall();
    cout << "The price of a single American call is: " << d << endl;
    double h = b.SingleEuropeanPut();
    cout << "The price of a single European put is: " << h << endl;
    double f = b.SingleAmericanPut();
    cout << "The price of a single American put is: " << f << endl;
    
    
    double g = b.BarrierOption(100, "Down","In","Call");
    cout << "The price of a barrier option is " << g << endl;
    
    
    BlackScholes * k = new BlackScholes(100, 0.2, 90, 0.05, 3, "AssetOrNothingCall");
    BlackScholes * m = new BlackScholes(100, 0.2, 90, 0.05, 3, "put");
    double a = k->binary();
    cout << a << endl;
    double z = m->black_scholes();
    cout << z << endl;
    
    
    return EXIT_SUCCESS;
}

