#include"Matrix.h"
#include<iostream>
#include<vector>
using namespace std;


int main() {
	vector<double> a = { 1, 2, 3, 1,1,1,1,1,1};
	vector<double> b = { 2, 3, 4 };
	matrix<double, 2, 2>  B, C;
	//A.assign(a);
	B.assign(b);
    C.assign(a);
    matrix<double, 2, 2>  F(C);
    //F.print();
    //A =  B * 13;
    //A = B + B;
    //C.print();
    //A = C.transpose();
    //A.print();
    matrix<double,3, 4>  D, E;
    D.assign(a);
    D.print();
    E = D.GaussElimination();
    E.print();
    

}




