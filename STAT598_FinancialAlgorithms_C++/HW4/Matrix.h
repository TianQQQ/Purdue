#ifndef _MATRIX_
#define _MATRIX_
//Usually, at the beginning of a .h file, we write things like this.
//Here "_MATRIX_" is an identifier for this header file, so that
//things inside this file will not be defined several times.
//Also pay attention to the last line in this file.

//When we try to define template class, it is usually better to
//include everything in a single .h file. This can solve some bugs.

#include <iostream>
#include <vector>
using namespace std;

template<class T, int m, int n>
class matrix {
	int nrow;
	int ncol;
	vector<vector<T>> elements;
public:
	matrix();
	void assign(const vector<T>&);
	friend matrix<T, m, n> operator+ <>(const matrix<T, m, n>&, const matrix<T, m, n>&);
	friend ostream& operator<< <>(ostream&, const matrix<T, m, n>&);
	//Pay attention to the "<>" after the operator.
	//For operator overloading that involves template, this can solve some bugs.
};

template<class T, int m, int n>
matrix<T, m, n>::matrix() {
	vector<T>temp(n, 0);
	elements.assign(m, temp);
	//Pay attention to the usage of member functions of vector class.
	nrow = m;
	ncol = n;
}

template<class T, int m, int n>
void matrix<T, m, n>::assign(const vector<T>& input) {
	int size = input.size();
	int i;
	for (i = 0; i < size && i < m * n; ++i) {
		elements[i / n][i % n] = input[i];
	}
	for (; i < m * n; ++i)
		elements[i / n][i % n] = 0;
	return;
}

template<class T, int m, int n>
matrix<T, m, n> operator+ <>(const matrix<T, m, n>& a, const matrix<T, m, n>& b) {
	matrix<T, m, n> res = a;
	for (int i = 0; i < m; ++i)
		for (int j = 0; j < n; ++j)
			res.elements[i][j] += b.elements[i][j];
	return res;
}

template<class T, int m, int n>
ostream& operator<< <>(ostream& o, const matrix<T, m, n>& input) {
	for (int i = 0; i < m; ++i) {
		for (int j = 0; j < n; ++j)
			o << input.elements[i][j] << " ";
		o << endl;
	}
	return o;
}

#endif