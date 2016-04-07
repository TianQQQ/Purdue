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
#include <cmath>
using namespace std;

#define MAXNUM 50



template<class T>
void print_vvector(vector< vector<T> > A) {
    int n = A.size();
    for (int i=0; i<n; i++) {
        for (int j=0; j<n+1; j++) {
            cout << A[i][j] << "\t";
            if (j == n-1) {
                cout << "| ";
            }
        }
        cout << "\n";
    }
    cout << endl;
}




template<class T, int m, int n>
class matrix {

protected:
    int nrow;
	int ncol;
	vector<vector<T>> elements;
    
public:
	matrix();
    matrix ( matrix<T, m, n> & );

	void assign(const vector<T>&);
    matrix<T, m, n> operator+ (const matrix<T, m, n> b){
        matrix<T, m, n> res;
        for (int i = 0; i < m; ++i)
            for (int j = 0; j < n; ++j)
                res.elements[i][j] += b.elements[i][j];
        return res;
    }
    
    void print (){
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j)
                cout << elements[i][j] << " ";
            cout << endl;
        }
    }

    matrix<T, m, n> operator*(const T& b){
        matrix<T, m, n> res;
        for (int i = 0; i < m; ++i)
            for (int j = 0; j < n; ++j)
                res.elements[i][j] = b * elements[i][j];
        return res;
    }
    
    matrix<T, m, n> operator*(const matrix<T, m, n> b){
        matrix<T, m, n> res;
        for (int i = 0; i < m; ++i)
            for (int j = 0; j < n; ++j)
                res.elements[i][j] = b.elements[i][j] + elements[i][j];
        return res;
    }
    
    vector<T> row(int i){
        return elements[i];
    }
    
    vector<T> col(int j){
        vector<T> col;
        for (int i = 0; i < ncol; i++)
        {
            col.push_back(elements[i][j]);
        }
        return col;
    }
    
    matrix<T, n , m> transpose () {
        matrix<T, m, n> res;
        for (int i = 0; i < m; ++i)
            for (int j = 0; j < n; ++j)
                res.elements[j][i] = elements[i][j];
        return res;
    }// return the transpose of the matrix
    
    vector<vector<T>> GaussElimination (vector< vector<T> >   A){
        
        for (int i=0; i<nrow; i++) {
            // Search for maximum in this column
            double maxEl = abs(A[i][i]);
            int maxRow = i;
            for (int k=i+1; k<nrow; k++) {
                if (abs(A[k][i]) > maxEl) {
                    maxEl = abs(A[k][i]);
                    maxRow = k;
                }
            }
            
            // Swap maximum row with current row (column by column)
            for (int k=i; k<nrow+1;k++) {
                double tmp = A[maxRow][k];
                A[maxRow][k] = A[i][k];
                A[i][k] = tmp;
            }
            
            // Make all rows below this one 0 in current column
            for (int k=i+1; k<nrow; k++) {
                double c = -A[k][i]/A[i][i];
                for (int j=i; j<nrow+1; j++) {
                    if (i==j) {
                        A[k][j] = 0;
                    } else {
                        A[k][j] += c * A[i][j];
                    }
                }
            }
        }
        print_vvector(A);
        elements = A;
        return A;

    }//return the Gauss elimination*/
    
    vector<T> Solve(const vector<T> & b){

        vector<double> line(nrow+1,0);
        vector< vector<double> > A(nrow,line);
        
        // Read inrowput data
        for (int i=0; i<nrow; i++) {
            for (int j=0; j<nrow; j++) {
                A[i][j] = elements[i][j];
            }
        }
        
        for (int i=0; i<nrow; i++) {
            A[i][nrow] = b[i];
        }
        
        A = GaussElimination(A);
        // Solve equation Ax=b for an upper triangular matrix A
        vector<double> x(nrow);
        for (int i=nrow-1; i>=0; i--) {
            x[i] = A[i][nrow]/A[i][i];
            for (int k=i-1;k>=0; k--) {
                A[k][nrow] -= A[k][i] * x[i];
            }
        }
        
        solved_result_print(x);
        return x;
    }//solve a linear equation Ax = b,
    
    
    void solved_result_print(vector<T> x){
        cout << "Result:\t";
        for (int i=0; i<nrow; i++) {
            cout << "x[" << i+1 << "] = " << x[i] << "\t";
        }
        cout << endl;
    }
    
    int rank(){
        int zero_line_count = 0;
        for (int i=0; i<m; i++) {
            for (int j=0; j<n; j++) {
                if (elements[i][j] != 0) {
                    break;
                }
                if (j == n-1) {
                    zero_line_count++;
                }
            }
        }
        return nrow - zero_line_count;
    }//return the rank of the matrix
    
    
    ~matrix(){
    }
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
matrix<T, m, n>::matrix(matrix<T, m, n> & b) {
    vector<T>temp(n, 0);
    elements.assign(m, temp);
    //Pay attention to the usage of member functions of vector class.
    nrow = m;
    ncol = n;
    for (int i = 0; i < m; ++i)
        for (int j = 0; j < n; ++j)
            this->elements[i][j] = b.elements[i][j];
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

////////////////////////////////////////////////////////////////////////// Square matrix class
template<class T, int n>
class SquareMatrix :public matrix<T, n, n> {
    
protected:
    int nrow;
    int ncol;
    vector<vector<T>> elements;
    
public :
    SquareMatrix ( ) {
        vector<T>temp(n, 0);
        elements.assign(n, temp);
        //Pay attention to the usage of member functions of vector class.
        nrow = n;
        ncol = n;
    }
    SquareMatrix ( SquareMatrix<T, n>&);


};
#endif


















