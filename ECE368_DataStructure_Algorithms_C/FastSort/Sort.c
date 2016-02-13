/*
 Created by Tian Qiu on Mar 15 2015
 */


#include <stdlib.h>
#include <stdio.h>

int* findindex ( int *, int , int *);
void countsort ( int list[], int n, int index[]);
void radixsort ( int a[], int n, int index[]);
void sort ( int list[], int n);


void radixsort(int a[], int n, int index[]){
	int i, min, max, exp = 1,range;
	min = index[0];
	max = index[1];
	range = index[2];
	const int base = 10;
	int *b = (int*) malloc(n * sizeof(int));
	
	while (range / exp > 0) {
		int bucket[10] = {0};
		for (i = 0; i < n; i++) {
			bucket[(a[i] - min) / exp % base]++;
		}
		for (i = 1; i < base; i++) {
			bucket[i] += bucket[i - 1]; 
		}
		for (i = n - 1; i >= 0; i--) {
			b[--bucket[(a[i] - min) / exp % base]] = a[i] - min;
		}
		for (i = 0; i < n; i++) {
			a[i] = b[i] + min;
		}
		exp *= base;
	}
	free(b);
}


void countsort(int list[], int n, int index[]){
	
	int ind1, ind2, ind3, min, max, range;
	ind3 = 0;
	min = index[0];
	max = index[1];
	range = index[2];   // counting array range
	
	if(n == 1 || range == 0) return;
	
	int* count = (int *)malloc(sizeof(int) * (range)); //count length
	for(ind1 = 0; ind1 < n; ind1++){
		count[list[ind1] - min]++; // record array index = val number
	}
	for(ind1 = 0; ind1 < range; ind1++){  // value = temp array index
		for(ind2 = 0; ind2 < count[ind1]; ind2++){
			list[ind3++] = ind1 + min;
		}
	}	
	free(count);
}



int* findindex(int list[], int n, int index[]){

	int ind;
	int max = list[0];
	int min = list[0];
	int range = 0;

	for(ind = 0; ind < n; ind++){
		if(list[ind] > max) max = list[ind];
		if(list[ind] < min) min = list[ind];
	}
	range = max - min + 1;
	index[0] = min;
	index[1] = max;
	index[2] = range;
	
	return index;
}


void sort(int list[], int n){
	int* index = malloc(sizeof(int) * 3);
//	if(list != NULL){	
//printf("===============================================\n");
		index = findindex(list, n, index);
//printf("index = [%d, %d, %d] \n", index[0], index[1], index[2]);
		if(n != 0 && index[2] / n < 50){
		countsort(list, n, index);  // range is small
		} else{
		//printf("Using Radix sort");
		radixsort(list, n, index);  //range is too big
		}	
	free (index);
}

#define test

#ifdef test

#include <time.h>
int main(int argc, char * *argv){
	int ind;
	clock_t st, ed;
	double dur;
	int n = 0;
	if(argc == 2) {
		n = atoi(argv[1]);
	}else{ 
		printf("Input ERROR!");
	}



	int *a = malloc(sizeof(int) * n);
	for(ind = 0; ind < n; ++ind){
		a[ind] = n / 2 - ind;
		if (ind % 1000 ==0){
			a[ind] = -ind;
		}
	//	a[ind] = -(rand() % 1000000 - 500000);
	//	a[ind] = 50000 - ind * 1.2;
	}
	//a[1] = 1000000;
	//a[2] = 0;

	printf("\n");
	//for(ind = 0; ind < n; ++ind) printf("%d\n", a[ind]);
	
	st = clock();
	sort(a, n);
	ed = clock();
	
	dur = (double)(ed - st) / CLOCKS_PER_SEC;
	printf("Duration = %f s\n", dur);
	
	for(ind = 0; ind < n; ++ind) printf("%d\n", a[ind]);
	free(a);
	return 0;
}

#endif

