#include<stdio.h>
#include<stdlib.h>
#include<math.h>

void print_arrayAll(int *, int );
void partition_helperAll(int *, int pos, int );
void partitionAll(int );

void print_arrayIncreasing(int *, int );
void partition_helperIncreasing(int *, int pos, int );
void partitionIncreasing(int );

void print_arrayDecreasing(int *, int );
void partition_helperDecreasing(int *, int pos, int );
void partitionDecreasing(int );

void print_arrayOdd(int *, int );
void partition_helperOdd(int *, int pos, int );
void partitionOdd(int );

void print_arrayEven(int *, int );
void partition_helperEven(int *, int pos, int );
void partitionEven(int );

void print_arrayOddAndEven(int *, int );
void partition_helperOddAndEven(int *, int pos, int );
void partitionOddAndEven(int );

void print_arrayPrime(int *, int );
void partition_helperPrime(int *, int pos, int );
void partitionPrime(int );


#define TEST
#ifdef TEST
int main (int argc, char ** argv)
{
	partitionAll(9);                                             //
	return EXIT_SUCCESS;
}
#endif






void print_arrayAll(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}

void partition_helperAll(int *arr, int pos, int n)
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayAll(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
	for(val = 1; val <= n; ++val)
	{
		// if cal is a good num( cases
		arr[pos] = val; // write the value into the result
		partition_helperAll(arr, pos + 1, n - val);                //
	}
}	

void partitionAll(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperAll(arr, pos , value);                         //
 	free(arr);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Prints all partitions that have strictly increasing values.
 *
 * Example:
 * partitionIncreasing(5); // prints the following: (line order not important)
 * = 1 + 4
 * = 2 + 3
 * = 5
 * 
 * These partitions are excluded because they are not _strictly_ increasing
 * 1 + 1 + 3
 * 2 + 1 + 2
 * 3 + 2
 * 
 * Note:
 * The program should generate only valid partitions.  Do not
 * generates all partitions and then filter for validity. If you 
 * do this, you will almost certainly have trouble understanding the exam.
 *
 * Hint: look at file: expected/partitionIncreasing.output
 */


void print_arrayIncreasing(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}


void partition_helperIncreasing(int *arr, int pos, int n)                 //
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayIncreasing(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
 	int min = 1;
 	if (pos != 0)
 	{
 		min = arr[pos - 1] + 1;
 	}
	for(val = min; val <= n; ++val)
	{
		// if cal is a good num( cases
		arr[pos] = val; // write the value into the result
		partition_helperIncreasing(arr, pos + 1, n - val);                //
	}
}	

void partitionIncreasing(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperIncreasing(arr, pos , value);                         //
 	free(arr);
}

/**
 * Prints all partitions that have strictly decreasing values.
 *
 * Example:
 * partitionDecreasing(5); // prints the following: (line order not important)
 * = 3 + 2
 * = 4 + 1
 * = 5
 * 
 * These partitions are excluded because they are not _strictly_ decreasing
 * 1 + 1 + 3
 * 2 + 1 + 2
 * 
 * See: note on partitionIncreasing(...)
 * Hint: look at file: expected/partitionDecreasing.output
 */

void print_arrayDecreasing(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = len - 1; ind >= 0; --ind)
	{
		if (ind != len - 1)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}


void partition_helperDecreasing(int *arr, int pos, int n)                 //
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayDecreasing(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
 	int min = 1;
 	if (pos != 0)
 	{
 		min = arr[pos - 1] + 1;
 	}
	for(val = min; val <= n; ++val)
	{
		// if cal is a good num( cases
		arr[pos] = val; // write the value into the result
		partition_helperDecreasing(arr, pos + 1, n - val);                //
	}
}	

void partitionDecreasing(int value)                                       //
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperDecreasing(arr, pos , value);                         //
 	free(arr);
}


/**
 * Prints all partitions comprised solely of odd numbers.
 *
 * Example:
 * partitionOdd(5); // prints the following (line order not important)
 * = 1 + 1 + 1 + 1 + 1
 * = 1 + 1 + 3
 * = 1 + 3 + 1
 * = 3 + 1 + 1
 * = 5
 * 
 * See: note on partitionIncreasing(...)
 * Hint: for odd numbers, (value % 2 != 0)
 * Hint: look at file: expected/partitionOdd.output
 */


void print_arrayOdd(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}

void partition_helperOdd(int *arr, int pos, int n)
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayOdd(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
	for(val = 1; val <= n; val += 2)
	{
		// if cal is a good num( cases
		arr[pos] = val; // write the value into the result
		partition_helperOdd(arr, pos + 1, n - val);                //
	}
}	

void partitionOdd(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperOdd(arr, pos , value);                         //
 	free(arr);
}

/**
 * Prints all partitions comprised solely of even numbers.
 *
 * Example:
 * partitionEven(6); // prints the following (line order not important)
 * = 2 + 2 + 2
 * = 2 + 4
 * = 4 + 2
 * = 6
 * 
 * See: note on partitionIncreasing(...)
 * Hint: for even numbers, (value % 2 == 0)
 * Hint: you can never partition an odd number with even numbers alone.
 * Hint: look at file: expected/partitionEven.output
 */

void print_arrayEven(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}

void partition_helperEven(int *arr, int pos, int n)
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayEven(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
	for(val = 2; val <= n; val += 2)
	{
		// if cal is a good num( cases
		arr[pos] = val; // write the value into the result
		partition_helperEven(arr, pos + 1, n - val);                //
	}
}	

void partitionEven(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperEven(arr, pos , value);                         //
 	free(arr);
}


/**
 * Prints all partitions that do not have consecutive odd or even numbers.
 * In other words, it only prints partitions that have alternating odd and 
 * even numbers.
 *
 * Example:
 * partitionOddAndEven(5); // prints the following (line order not important)
 * = 1 + 4
 * = 2 + 1 + 2
 * = 2 + 3
 * = 3 + 2
 * = 4 + 1
 * = 5
 *
 * See: note on partitionIncreasing(...)
 * Hint: look at file: expected/partitionOddAndEven.output
 */
void partitionOddAndEven(int value);
void print_arrayOddAndEven(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}

void partition_helperOddAndEven(int *arr, int pos, int n)
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayOddAndEven(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
 	int judge = 0;
	for(val = 1; val <= n; ++ val)
	{
		if (pos == 0)
			judge = 1;
		else 
			judge = ((arr[pos - 1] % 2) != (val % 2)); //arr[pos - 1] and van cannot be both odd or even
		// if cal is a good num( cases

		
		if (judge == 1)
		{
			arr[pos] = val; // write the value into the result
			partition_helperOddAndEven(arr, pos + 1, n - val);                //
		}
	}
}	

void partitionOddAndEven(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperOddAndEven(arr, pos , value);                         //
 	free(arr);
}


/**
 * Prints all partitions that comprise solely of prime numbers.
 *
 * Example:
 * partitionPrime(5); // prints the following (line order not important)
 * = 2 + 3
 * = 3 + 2
 * = 5
 * 
 * See: note on partitionIncreasing(...)
 * Hint: you will need to write a function that checks if a number is prime.
 * Hint: 1 is not a prime number.
 * Hint: look at file: expected/partitionPrime.output
 */
 
 
void print_arrayPrime(int *arr, int len)
{
	int ind;
	printf("= ");
	for (ind = 0; ind < len; ++ind)
	{
		if (ind != 0)
 			printf(" + ");
		printf("%d", arr[ind]);
	}
	printf("\n");
}

void partition_helperPrime(int *arr, int pos, int n)
{
	//Base cases
	if( n == 0)
	{ 
		print_arrayPrime(arr, pos);                                  //
 		return;
	}
	
	//REcursive cases
 	int val;
 	int ind;   // index
	for(val = 2; val <= n; ++ val)
	{
		// judge whether value is prime number or not
		
		for (ind = 2; ind <= val; ind ++)
		{
			if(val % ind == 0)
			{
				break;
			}
				
		}
		
		
		// if cal is a good num( cases
		if(ind == val)
		{
			arr[pos] = val; // write the value into the result
			partition_helperPrime(arr, pos + 1, n - val);                //
			
		}

	}
}	

void partitionPrime(int value)
{
	int pos = 0;
	int *arr;
	arr = malloc (value * sizeof(int));
	partition_helperPrime(arr, pos , value);                         //
 	free(arr);
}


