#include "answer02.h"

size_t my_strlen(const char * str) 
{
	int pos = -1; 
	while(str[++pos] != '\0'); //until str[pos] = '\0'
	return pos;
}

int my_countchar(const char * str, char ch) 
{
	int count = 0;
	int pos = -1;
	while(str[++pos] != '\0')  //until str[pos] = '\0'
	{
		if(str[pos] == ch)     // equal character
		{
			count++;
		}
	}
	return count;
}

char * my_strchr(const char * str, int ch) 
{
		
	while(*str && *str != (char)ch) // on str and str != ch, find ch then stop
		str++;
	if (*str == (char)ch)           // on str and str = ch
	{
		return (char*) str;
	}
	return NULL;                    // off str
}

char * my_strrchr(const char * str, int ch) 
{
	const char* ptr;
	for(ptr = NULL;*str == '\0' ; ++str)        // find the last ch
	{
		if(*str == ch)
			ptr = str;
	
		if(*str == '\0')
			return (char*)ptr;
	}
}


char * my_strstr(const char * haystack, const char * needle) 
{
		const char *t = haystack;
		const char *s = needle;
		const char *p = t;

		while((*s) != '\0' && (*t) != '\0')
		{
			if(*s == *t)
			{
				t++;
				s++;
				continue;
			}
			else
			{
				s = needle;
				p++;
				t = p;
			}
		}
		if ((*s) == '\0')
		{	
			return (char*) p;
		}
		else return NULL;
}



char * my_strcpy(char * dest, const char * src)
{
	char* add = dest;
	while((*dest++ = *src++) != '\0');
	return add;
}


char * my_strcat(char * dest, const char * src)
{
	char *pt = dest;
	while(*dest != '\0') dest++;
	while(*src != '\0') *dest++ = *src++;
	*dest = '\0';
	return pt;
}


int my_isspace(int ch)
{
	return ((int)ch == 32 || ch =='\n'||ch == '\t'|| ch == '\v' || ch == '\f' || ch== '\r');
}

int isdigit(int x){
	if(x <= '9'&&x >= '0')
		return 1;
	else
		return 0;
}

int my_atoi(const char * str)
{
	int i = 0;
	int sum =0;
	int sign;

	while (' ' == str[i] || '\t' == str[i])
	{
		i++;
	}

	sign = ('-'==str[i] ? -1:1);

	if('-' ==str[i] || '+' == str[i])
	{
		i++;
	}

	while(str[i] != '\0')
	{
		if(str[i] >='0' && str[i] <='9')
		{
			sum = str[i] - '0' + sum*10;
		}
		else
		{break;
		}
		i++;
	}
	return sign * sum;

}
