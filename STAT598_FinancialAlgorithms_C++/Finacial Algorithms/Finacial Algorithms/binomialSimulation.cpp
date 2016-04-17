#include <iostream>
#include <string>
#include <cmath>
#include <stdio.h>
#include <math.h>


using namespace std;

#define e 2.718281828

class BinomialSimulation{
public:
    
    double sigma, r, T, K, u, d, qu, qd, R, h, P;
    int nPeriod, num, TP;
    
public:
    
    
    
    BinomialSimulation(double volatility, double rate, double maturity, int n_Period, double Price, double strike){
        sigma = volatility;
        r = rate;
        T = maturity;
        K = strike;
        nPeriod = n_Period;
        h = T / nPeriod, P = Price;
        R = pow((1 + r), h) - 1;
        u = pow(e, sigma*sqrt(h));
        d = 1 / u;
        qu = (pow(e, R*h) - d) / (u - d);
        qd = 1 - qu;
        num = pow(2, nPeriod + 1) - 2;
        TP = pow(2, nPeriod + 1) - 2;
    }
    
    double max(double a, double b) {
        if (a >= b) return a;
        else return b;
    }

    double SingleEuropeanCall() {

        double* s = new double[num];
        double* c = new double[num];
        s[0] = P;
        for (int i = 0; i <= (num - pow(2, nPeriod)); i++) {
            s[2*i+1] = s[i] * u;
            s[2*i+2] = s[i] * d;
        }
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {   //It is the range for the last period in binomial tree.
            c[j] = max((s[j] - K), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
        }
        
        return c[0];
    }

    double SingleAmericanCall() {

        double* s = new double[num];
        double* c = new double[num];
        s[0] = P;
        for (int i = 0; i <= (num - pow(2, nPeriod)); i++) {
            s[2 * i + 1] = s[i] * u;
            s[2 * i + 2] = s[i] * d;
        }
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {   //It is the range for the last period in binomial tree.
            c[j] = max((s[j] - K), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            double a = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            double b = s[m] - K;
            c[m] = max(a, b);
        }
        
        return c[0];
    }

    double SingleEuropeanPut() {

        double* s = new double[num];
        double* c = new double[num];
        s[0] = P;
        for (int i = 0; i <= (num - pow(2, nPeriod)); i++) {
            s[2 * i + 1] = s[i] * u;
            s[2 * i + 2] = s[i] * d;
        }
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {   //It is the range for the last period in binomial tree.
            c[j] = max((K - s[j]), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
        }
        
        return c[0];
    }

    double SingleAmericanPut() {

        double* s = new double[num];
        double* c = new double[num];
        s[0] = P;
        for (int i = 0; i <= (num - pow(2, nPeriod)); i++) {
            s[2 * i + 1] = s[i] * u;
            s[2 * i + 2] = s[i] * d;
        }
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {   //It is the range for the last period in binomial tree.
            c[j] = max((K - s[j]), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            double a = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            double b = K - s[m];
            c[m] = max(a, b);
        }
        
        return c[0];
    }

    double BarrierOption(double barrier, string UpOrDown, string InOrOut, string CallOrPut){
        double* s = new double[num];
        double* c = new double[num];
        s[0] = P;
        for (int i = 0; i <= (num - pow(2, nPeriod)); i++) {
            s[2 * i + 1] = s[i] * u;
            s[2 * i + 2] = s[i] * d;
        }
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {
            c[j] = max((s[j] - K), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
        }
        double OrdinaryCall = c[0];
        
        for (int j = pow(2, nPeriod) - 1; j <= pow(2, nPeriod + 1) - 2; j++) {
            c[j] = max((K - s[j]), 0);
        }
        for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
            c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
        }
        double OrdinaryPut = c[0];
        
        
        
        if (UpOrDown == "Up" && CallOrPut == "Call") {
            for (int j = pow(2, nPeriod) - 1; j <= TP; j++) { //The sum of an In & Out call price with same K, S... = Price of Ordinary Call
                if (s[j] > barrier) c[j] = 0;
                else c[j] = max((s[j] - K), 0);
            }
            
            for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
                if (s[m] > barrier) c[m] = 0;
                else c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            }
            
            if (InOrOut == "Out") return c[0];
            if (InOrOut == "In") return OrdinaryCall - c[0];
        }
        
        if (UpOrDown == "Up" &&   CallOrPut == "Put") {
            for (int j = pow(2, nPeriod) - 1; j <= TP; j++) {
                if (s[j] > barrier) c[j] = 0;
                else c[j] = max((- s[j] + K), 0);
            }
            
            for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
                if (s[m] > barrier) c[m] = 0;
                else c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            }
            
            if (InOrOut == "Out") return c[0];
            if (InOrOut == "In") return OrdinaryPut - c[0];
        }
        if (UpOrDown == "Down" &&   CallOrPut == "Call") {
            for (int j = pow(2, nPeriod) - 1; j <= TP; j++) {
                if (s[j] < barrier) c[j] = 0;
                else c[j] = max((s[j] - K), 0);
            }
            
            for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
                if (s[m] < barrier) c[m] = 0;
                else c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            }
            
            if (InOrOut == "Out") return c[0];
            if (InOrOut == "In") return OrdinaryCall - c[0];
        }
        if (UpOrDown == "Down" &&  CallOrPut == "Put") {
            for (int j = pow(2, nPeriod) - 1; j <= TP; j++) {
                if (s[j] < barrier) c[j] = 0;
                else c[j] = max((-s[j] + K), 0);
            }
            
            for (int m = pow(2, nPeriod) - 2; m >= 0; m--) {
                if (s[m] < barrier) c[m] = 0;
                else c[m] = (qu*c[m * 2 + 1] + qd*c[m * 2 + 2]) / (1 + R);
            }
            
            if (InOrOut == "Out") return c[0];
            if (InOrOut == "In") return OrdinaryPut - c[0];
        }
        return 0.0;
    }
};

//double AsianOption



