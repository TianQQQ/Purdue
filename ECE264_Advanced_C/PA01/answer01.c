#include <stdlib.h>
#include "answer01.h"

int arraySum(int * array, int len)
{   
    int sum;    //The Summation of the array elements
    int index;  //The order of the array

	sum = 0;
    for(index = 0; index < len; index++)
    {
        sum = sum + array[index];
    }

    return sum;    
}

int arrayCountNegative(int * array, int len)
{
	int count;  // The count for negative number of array
    int index;  // The order of the array

	count = 0;
	for(index = 0; index < len; index++)
	{
		if (array[index] < 0)
		{
			count++;
		}
	}
	return count;
}

int arrayIsIncreasing(int * array, int len)
{
	int index;	//The order of the array
 	int isInc = 0;  //The index to judge whether the array is increasing or not
	int index_tol = 0;  //The total number that satisfy the requiremtn

	if (len == 0 || len == 1)
	{
		isInc = 1;
	}
	else
	{
		for (index = 0; index < len - 1; index++)
		{
			if (array[index] <= array[index + 1])
			{
				index_tol++;
			}
		}
		if (index_tol == len - 1)
		{
			isInc = 1;
		}
		else
		{
			isInc = 0;
		}
	}
    return isInc;
}

int arrayIndexRFind(int needle, const int * haystack, int len)
{
	int index;  // the order of the array
	int x;      // the index of the needle
	
	x = -1;
	for (index = 0; index < len; index++)
	{
		if (haystack[index] == needle)
		{
			x = index;
		}
	}
    return x;
}

int arrayFindSmallest(int * array, int len)
{
	int index = 0; // the index of the elements
	int ind = 0;   // the index of the smallest element
	for (index = 0; index < len - 1; index++)
	{
		if (array[ind] > array[index + 1])
		{
			ind = index + 1;
		}
	}
    return ind;
}                      
