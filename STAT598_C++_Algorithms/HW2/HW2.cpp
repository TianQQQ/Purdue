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

int Place(int x[], int n, int r)
{
    int i;
    for(i=0; i<n-1; i++){
        if( i != r && x[i] == x[r]){   // abs(x[i]-x[k-1])==abs(i-k+1)
            return false;
        }
    }
    return true;
}

void Print_nRooks_helper(int x[], int n, int r){
    int i;
    if(r>=n){
        arrayprintHelper(x, n);    // recursion base case
        cout << endl;
    }else{
        for(i=0;i<n;i++){
            x[r]=i;
            if(Place(x, n, r)) Print_nRooks_helper(x, n, r+1);
        }
    }
}

void Print_nRooks(int n) {
	//Print all solutions of nRooks problem to the screen.
    //int * * matrix = (int * * )malloc(n * sizeof(int *));
    //for (int i=0; i<n; i++) matrix[i] = (int *)malloc(n * sizeof(int));
    int * arr = (int*) malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = -1;
    }
    Print_nRooks_helper(arr, n, 0);
    cout<<"-------------------------------------nRooks"<<endl;
}



void Queens_Rooks(int n) {
	//Print all solutions of Queens and Rooks problem to the screen.
}
void Max_Consecutive_Numbers(int p[], int n) {
    
}
void Max_Draw_Down(int p[], int n) {

}

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
	int p[] = { 4,1,3,6,2,10,7,8 };
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
    
    Print_nRooks(3);
    
    
 
	return 0;
}
