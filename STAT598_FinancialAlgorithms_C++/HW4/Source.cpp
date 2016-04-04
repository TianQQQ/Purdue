#include"Matrix.h"
#include<iostream>
#include<vector>
using namespace std;
int main() {
	vector<double> a = { 1, 2, 4, 5 ,6 };
	vector<double> b = { 2, 3, 4 };
	matrix<double, 2, 2> A, B, C;
	A.assign(a);
	B.assign(b);
	C = A + B;
	cout << A << B << C;
	return 0;
}
