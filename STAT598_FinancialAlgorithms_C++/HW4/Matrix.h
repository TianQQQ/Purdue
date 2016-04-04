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

#define MAXNUM 50

template<class T, int m, int n>
class matrix {
	int nrow;
	int ncol;
	vector<vector<T>> elements;
public:
	matrix();
    /*matrix ( matrix<T, m, n> & b){
        for (int i = 0; i < m; ++i)
            for (int j = 0; j < n; ++j)
                this->elements[i][j] = b.elements[i][j];
    }*/

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
    
 /*
    ::matrix<T, m, n> GaussElimination (){
        //高斯消元法（列选主元）
        void Gauss (double a[][MAXNUM],int n)
        {
            int i,j;
            SelectColE(a,n);   //列选主元并消元成上三角
            //回代求解
            printf("上三角的结果\n");
            printM(a,3);
            for(i=n;i>=1;i--)
            {
                for(j=i+1;j<=n;j++)
                    a[i][n+1]-=a[i][j]*a[j][n+1];
                a[i][n+1]/=a[i][i];
            }
            return ;
        }
        

    }//return the Gauss elimination
*/
    
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

/*
//选择列主元并进行消元
void SelectColE(double a[][MAXNUM],int n)
{
    int i,j,k,maxRowE;
    double temp; //用于记录消元时的因数
    for(j=1;j<=n;j++)
    {
        maxRowE=j;
        for(i=j;i<=n;i++)
            if(fabs(a[i][j])>fabs(a[maxRowE][j]))
                maxRowE = i;
        if(maxRowE!=j)
            swapRow(a,j,maxRowE,n);   //与最大主元所在行交换
        //消元
        for(i=j+1;i<=n;i++)
        {
            temp =a[i][j]/a[j][j];
            for(k=j;k<=n+1;k++)
                a[i][k]-=a[j][k]*temp;
        }
        printf("第%d列消元后：\n",j);
        printM(a,3);
    }
}

void swapRow(double a[][MAXNUM],int m,int maxRowE,int n)
{
    int k;
    double temp;
    for(k=m;k<=n+1;k++)
    {
        temp = a[m][k];
        a[m][k] = a[maxRowE][k];
        a[maxRowE][k] = temp;
    }
}*/
#endif


















