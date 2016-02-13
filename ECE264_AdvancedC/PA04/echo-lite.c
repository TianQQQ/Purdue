#include <stdio.h>
#define EXIT_SUCCESS 0

int main(int argc, char *argv[])
{
	int i;
	/* code */
	if(argc > 1)
		for (i = 1; i < argc; i++)
			printf("%s ", argv[i]);
	printf("\n");
	return EXIT_SUCCESS;
}
