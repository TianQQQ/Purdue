// unsigned int 128 : uint128 

#include "answer12.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <pthread.h>
typedef struct{
	uint128 start;
	uint128 value;
	uint128 end;
	int* ind;
}ThreadBlock;

ThreadBlock* ThreadBlock_create(uint128 end, uint128 value, uint128 start, int* ind);
void* thread_help(void* Threadblock);
//#define test
#ifdef test
#define print(x) printf("%s = %u\n", #x, x)
int main(int argc, char * * argv)
{
    const char * str = "32434";
    uint128 w = alphaTou128(str);
    char * w_str = u128ToString(w);
    printf("Biiigggg number: %s\n", w_str);
    if(strcmp(str, w_str) != 0)
       printf("ERROR!, expected %s\n", str);
    free(w_str);
    return EXIT_SUCCESS;
}
#else
#define print(x) 
#endif



uint128 alphaTou128(const char * str){
	int i = 0;
	uint128 sum = 0;
	int sign;
	
	
	while(' ' == str[i] || '\t' == str[i]){
		i++;
	}
	sign = ('-' == str[i] ? -1 : 1);
	if('-' == str[i] || '+' == str[i]){
		i++;
	}
	
	while (str[i] != '\0'){
		if (str[i] >= '0' && str[i] <= '9'){
			sum = str[i] - '0' + sum * 10;
		} else{
			break;
		}
		i++;
	}
	print(sign);
	if(sign > 0) 	return sum;
	return 0;
}

char * u128ToString(uint128 value){
    uint128 unum = value;
    char inde[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"; // reference
    unsigned ind = 0;
    unsigned i = 0;
    int k = 0;
    int length = 0;

    // calculate length
    do{
    	unum /= 10;
    	i++;
	} while(unum);
	if(value < 0){
		length = i + 1;
	} else {
		length = i;
	}
	print(i);
	char* str = malloc(sizeof(char*) * length);
	// char* str;    // char is address
	// str = malloc(sizeof(char*) * length);
	unum = value;
	print(length);
	
	//get the sign
	i = 0;
	if(value < 0){
    //	str[i++] = '-';
    }
	
	// get the reversed order string
	do{
    	str[i++] = inde[unum % 10];
    	unum /= 10;
	} while(unum);
	str[i] = '\0';
	
	print(str);
	
	// convert the order
	if(str[0] == '-')k=1;
	char temp;
	for (ind = k; ind <= (length-k-1)/2; ind++){
		temp = str[ind];
		str[ind] = str[length - ind -1];
		str[length - ind - 1] = temp; 
	}
	
	print(str);
	return str;
}

int primalityTestParallel(uint128 value, int n_threads){   

	ThreadBlock** tb = malloc(sizeof(ThreadBlock*) * n_threads);
	pthread_t* a = malloc(sizeof(pthread_t) * n_threads);
	long* status = malloc(sizeof(long) * n_threads);
	int ret = 0;   //result
	uint128 max = floor(sqrt(value));
	uint128 bin = max / n_threads;
	uint128 ind;
	
	
	for(ind = 0; ind < n_threads - 1; ind ++){   //create the thread tree 
		tb[ind] = ThreadBlock_create((ind + 1) * bin, value, ind * bin, &ret);
	}
	
	tb[ind] = ThreadBlock_create(max, value, ind*bin, &ret);
	
	if (value <= 2) {
		ret = 0;
	} else if (value % 2 == 0)  {
		ret = 1;
	} else {
		for(ind = 0; ind < n_threads; ind++){   //thread create
			int thread = pthread_create(&a[ind], NULL, (void* (*)(void*))thread_help, (void*) tb[ind]);
			if(thread != 0){
				fprintf(stderr, "Failed to create thread. \n");
			}
		}
		for(ind = 0; ind < n_threads; ind ++){  //thread join
			pthread_join(a[ind], (void*) &status[ind]);
		}
	}
	free(a);
	free(status);
	for(ind = 0; ind < n_threads; ind++){   // free all the nodes
		free(tb[ind]);
	}
	free(tb);
	
    return !ret;
}

void* thread_help(void* Threadblock){
	ThreadBlock * h = (ThreadBlock*) Threadblock;
	uint128 b;
	if(h -> start < 3){
		h-> start = 3;
	}
	if(h -> start % 2 == 0){
		h -> start += 1;
	}
	if ((h -> start > h ->end) || (h->start > h->value)){
		pthread_exit(0);
	}
	for (b = h ->start; b <= h->end && *(h->ind) == 0; b = b+ 2){
		if ((h->value % b) == 0){
			*(h->ind) = 1;
		}
	}
	pthread_exit(0);
}

ThreadBlock* ThreadBlock_create(uint128 end, uint128 value, uint128 start, int * ind){
	ThreadBlock* result = malloc(sizeof(ThreadBlock));
	result -> start = start;
	result -> end = end;
	result -> ind = ind;
	result -> value = value;
	return result;
}











































