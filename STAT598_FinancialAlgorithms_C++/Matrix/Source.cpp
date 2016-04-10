#include"Matrix.h"
#include<iostream>
#include<vector>
using namespace std;


int main() {
	vector<double> a = { 1, 2, 3, 0, 1 , 1, 1, 0, 1};
	vector<double> b = { 2, 3, 4 };
    vector<double> c = { 1, 2, 3, 0,1,1,1};
    vector<double> d = { 1, 2, 0};
	matrix<double, 2, 2>  A, B, C;
	//A.assign(a);
	B.assign(b);
    C.assign(a);
    matrix<double, 2, 2>  F(C);
    F.print();
    A =  B * 13;
    A.print();
    A = B + B;
    A.print();
    A = C.transpose();
    cout << " A after transpose is :" << endl;
    A.print();
    
    matrix<double,3, 4>  D, E;
    D.assign(a);
    D.print();
    D.Solve(b);
    cout << "Rank is " << D.rank() << endl;
    E.assign(c);
    E.print();
    E.Solve(d);
    cout << "Rank is " << E.rank() << endl;
    
    
    cout << "------------------------------------SquareMatrix<T, n> class test start --------------------------------------------------------" << endl;
    SquareMatrix<double, 3> AA;
    AA.assign(a);
    AA.print();
    double res = AA.determinant(AA.elements, 3);
    cout << res << endl;
    cout << AA.isNonSingular() << endl;
    

    
}




