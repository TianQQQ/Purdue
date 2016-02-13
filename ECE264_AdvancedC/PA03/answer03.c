#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "answer03.h"


int cmpa(const void *a, const void *b);
int cmpb(const void *a, const void *b);
//#define TEST
#ifdef TEST
int main(int argc, char * * argv)
{
	int n = 0; 
	char * * b = explode("asdasd sda asd asd"," ",&n);
	int ind;
	printf("%d\n",n);
	for(ind = 0;ind < n; ind ++)
	printf("strArr[%d] = %s\n",ind, b[ind]);
	char * a = implode(b,n," ");
	printf("%s\n",a);
	free(a);
	destroyStringArray(b, n);
	return EXIT_SUCCESS;
}
#endif
char *strcat_ex(char * * dest, int * n, const char * src)
{
	char *str;
	
	if((*dest == NULL) || (strlen(src) + strlen(*dest) + 1 > *n))
	{
		
		if(*dest == NULL)
		{
			* n = 1+ 2 * strlen(src);
			str = malloc(sizeof(char ) * (1 + 2 * strlen(src)));
			str[0] = '\0';
			str = strcpy(str, src);
			*dest = str;
		}
		else
		{
	 	* n = 1+ 2 * (strlen(*dest) + strlen(src));	
		str = malloc(sizeof(char ) * (1 + 2*(strlen(*dest) + strlen(src))));
		str[0] = '\0';
		str = strcpy(str, *dest);
		str = strcat(str, src);
		free(* dest);
		*dest = str;
		}
	}
	else
	{
		strcat(* dest, src);
	}
	return *dest;
}
char * * explode(const char * str, const char * delims, int * arrLen)
{
	int ind;
    int N=0;
	for(ind = 0; str[ind] != '\0'; ind++)
	{
		if (strchr(delims, str[ind]) != NULL)
		{	
			N++;
		}
	}
	char * * strarr = malloc((N + 1) * sizeof(char * ));
	int arrind = 0; //new postion for a string
	int last = 0;   //last index for delimiter
	for(ind = 0; str[ind] != '\0'; ind++)
	{
		if (strchr(delims, str[ind]) != NULL)
		{
			strarr[arrind] = malloc(sizeof(char) * (ind - last + 1));
			memcpy(strarr[arrind], str + last, ind - last);
			* (strarr[arrind] + ind - last) = '\0';
			arrind++;
			last = ind + 1;
		}
	}	
	strarr[arrind] = malloc(sizeof(char) * (ind - last + 1));
	memcpy(strarr[arrind], str + last, ind - last);
	* (strarr[arrind] + ind - last) = '\0';

	* arrLen = N + 1;
	return(strarr);
}	
	

char * implode(char * * strArr, int len, const char *glue)
{
	int pos;
	int n = 1;
	char * strnew = malloc(1 * sizeof(char ));
	strnew[0] = '\0';
	for(pos = 0; pos < len - 1; pos++)
	{
		strnew = strcat_ex( & strnew, & n, strArr[pos]);
		strnew = strcat_ex( & strnew, & n, glue); 
	}
	strnew = strcat_ex( & strnew, & n, strArr[pos]);
	return strnew;
}

int cmpa( const void *a , const void *b )
{ 
	char * * aA = (char * *) a;
	char * * aB = (char * *) b;
	return (strcmp(* aA, * aB));
}

int cmpb( const void *a, const void *b)
{
	char * aA = (char *) a;
	char * aB = (char *) b;
	return (*aA > *aB);
}

void sortStringArray(char * * arrString, int len)
{ 
	qsort (arrString, len, sizeof(char *), cmpa);	 
}



void sortStringCharacters(char * str)
{	
	qsort(str , strlen(str), sizeof(char), cmpb);	
}





void destroyStringArray(char * * strArr, int len)
{ 
	int pos;
	for( pos = 0; pos < len; pos++)
	{
		free( strArr[pos]);
	}
	free( strArr);
}






