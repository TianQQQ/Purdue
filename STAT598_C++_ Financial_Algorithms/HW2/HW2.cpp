//For HW2, Complete the following functions.
//You can write additional functions, but please do not modify the given functions.
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <vector>

using namespace std;

int sum = 0;

void arrayprintHelper(int p[], int n){
    for (int i=0; i<n; i++) {
        cout << p[i] << ' ';
    }
}
//========================================================================================================print helper
void insertion_sort(int p[], int n){
    for (int i=1; i<n; i++)
        for (int j = i-1; j>=0; j--) {
            if (p[j]<p[j+1])swap(p[j],p[j+1]);
            else break;
        }
    arrayprintHelper(p, n);
    cout<<endl<<"-------------------------------------insertion sort done"<<endl;
}

void selection_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order
	for (int i = 0; i < (n - 1); i++) {
		for (int j = (i + 1); j < n; j++) {
			if (p[i] < p[j]) {
                swap(p[i],p[j]);
			}
		}
	}
    arrayprintHelper(p, n);
    cout<<endl<<"-------------------------------------selection sort done"<<endl;
}

void bubble_sort(int p[], int n) {
    for (int i = n-2; i>=0; i--) {
        for (int j = 0; j<=i; j++) {
            if (p[j]<p[j+1]) {
                swap(p[j],p[j+1]);
            
            }
        }
    }
    arrayprintHelper(p, n);
    cout<<endl<<"-------------------------------------bubble sort done"<<endl;
}
void quick_sorth(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
    if(n<=1)return;
    int left = 0;
    int right = n-1;
    while (left < right){
        while (p[left]>p[right])right--;
        while (p[left]>=p[right] && left < right) right--;
        if(left == right) break;
        else swap(p[left],p[right]);
        
        while (p[left]>p[right])left++;
        while (p[left]>=p[right] && left < right) left++;
        if(left == right) break;
        else swap(p[left],p[right]);
    }
    
    quick_sorth(p,left);
    quick_sorth(p + left + 1, n-left-1);

}
void quick_sort(int p[], int n){
    quick_sorth(p, n);
    for (int i=0; i<n; i++) {
        cout << p[i] << ' ';
    }
    cout<<endl<<"-------------------------------------quick sort done"<<endl;
}
void merge_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void heap_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void radix_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}


void counting_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
    int max = p[0];
    int i,j,k;
    for(i=1;i<n;i++) {if(max<p[i]) max = p[i];}
    vector<int> index(max+1,0);
    for(i=0;i<n;i++)
        ++index[p[i]];
    i = 0;
    for (j=max; j >= 0;--j)
        for(k=index[j]-1;k >=0;--k)
            p[i++] = j;
    arrayprintHelper(p, n);
    cout<<endl<<"-------------------------------------counting sort done"<<endl;
}

//==================================================================================================

int Place(int x[], int n, int r){  // jugde whether it can be place or not
    for(int i=0; i < r; i++){
        if( x[i] == x[r]){   // abs(x[i]-x[k-1])==abs(i-k+1)
            return false;
        }
    }
    return true;
}

void Print_nRooks_helper(int x[], int n, int r){
    if(r>n - 1){
        arrayprintHelper(x, n);    // recursion base case
        cout << endl;
    }else{
        for(int i = 0; i < n; i++){
            x[r]=i;
            if(Place(x, n, r)) Print_nRooks_helper(x, n, r+1);  // r is index means column, x[r] means row
        }
    }
}

void Print_nRooks(int n) {
	//Print all solutions of nRooks problem to the screen.
    //int * * matrix = (int * * )malloc(n * sizeof(int *));
    //for (int i=0; i<n; i++) matrix[i] = (int *)malloc(n * sizeof(int));
    int * arr = (int*) malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = -1;  // -1 means has not been assigned
    }
    Print_nRooks_helper(arr, n, 0);
    cout<<"-------------------------------------nRooks"<<endl;
}

//========================================================================================== nRooks  3.1



int Place_queens(int x[], int n, int r){  // jugde whether it can be place or not
    for(int i=0; i < r; i++){
        if( x[i] == x[r] || abs(r-i) == abs(x[r]-x[i])){   //
            return false;
        }
    }
    return true;
}

void Print_queens_helper(int x[], int n, int r){
    if(r>n - 1){
        arrayprintHelper(x, n);    // recursion base case
        cout << endl;
    }else{
        for(int i = 0; i < n; i++){
            x[r]=i;
            if(Place_queens(x, n, r)) Print_queens_helper(x, n, r+1);  // r is index means column, x[r] means row
        }
    }
}



void Queens_Rooks(int n) {
    //Print all solutions of Queens and Rooks problem to the screen.
    int * arr = (int*) malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = -1;  // -1 means has not been assigned
    }
    Print_queens_helper(arr, n, 0);
    cout<<"-------------------------------------nQueens"<<endl;
}



//========================================================================================== nqueens  3.2












void Max_Consecutive_Numbers(int a[], int n) {   // O(n^3)
/*    int maxSum = 0;
    
    //i head
    for (int i = 0; i < n; i++)
    {
        //j tail
        for (int j = i; j < n; j++)
        {
            int thisSum = 0;
            
            //consecutive addition
            for (int k = i; k <= j; k++){
                thisSum += a[k];
            }
            if(thisSum > maxSum)
                maxSum = thisSum;
        }
    }
    
    cout << "max consecutive numbers is " << maxSum<< endl;
*/
    
    // O(n) online algorithm
    int maxSum = 0;
    int nowSum = 0;
    int max =a[0];    // for all negative number
    
    for (int j = 0; j < n; j++)
    {
        nowSum += a[j];
        
        if(nowSum > maxSum)
            maxSum = nowSum;
        else if(nowSum < 0)
            nowSum = 0;
        
        if (max < a[j]){
            max = a[j];
        }
    }
    if (max < 0) {
        cout << "max consecutive numbers is " << max<< endl;
    }else{
        cout << "max consecutive numbers is " << maxSum<< endl;
    }
}



void Max_Draw_Down(int a[], int n) {
    int maxSum = 0;
    
    //i head
    for (int i = 0; i < n; i++)
    {
        //j tail
        for (int j = i; j < n; j++)
        {
            int thisSum = 0;
            
            //consecutive addition
            for (int k = i; k <= j; k++){
                thisSum = a[i] - a[k];
            }
            if(thisSum > maxSum)
                maxSum = thisSum;
        }
    }
    
    cout << "max consecutive numbers is " << maxSum<< endl;

}
//===============================================================================compare char
int compare(const char *a, const char *b){
    int i =0;
    int numa = 0;
    int numb = 0;
    while (a[i] != '\0') {
        numa = numa * 10 + (int(a[i]) - 48);    // ASCII '0' is 48
        i++;
    }
    i = 0;
    while (b[i] != '\0') {
        numb = numb * 10 + (int(b[i]) - 48);    // ASCII '0' is 48
        i++;
    }
    int ret = 0;
    if (numa > numb) {
        ret = 1;
    }else if (numa == numb) {
        ret = 0;
    }else{
        ret = -1;
    }
    return ret;
}

void print_factorial(int n) {
	//In this problem, print n! to the screen.
	//You should expect n to be as large as 100.
}
void print_exponential(int N) {
	//In this problem, print the first N digits of e to the screen.
}
void print_pi(int N) {
	//In this problem, print the first N digits of pi to the screen.
}

int main() {
	int p[] = { 4,1,3,6,1,10,-10,8 };
	int n = 8;
    counting_sort(p, n);
    insertion_sort(p, n);
	selection_sort(p, n);
	bubble_sort(p, n);
    quick_sort(p, n);
    
    const char *a;
    a = "1234";
    const char *b = "12223";
    cout << compare(a, b) << endl;
    cout<<"-------------------------------------compare const char"<<endl;
    
    Print_nRooks(4);
    Queens_Rooks(5);
    
    int arr[] = { -4,-1,-3,-6,-11,-10,-10, -8 };
    int narr = 8;
    Max_Consecutive_Numbers(arr, narr);
    Max_Draw_Down(arr, narr);
 
	return 0;
}
