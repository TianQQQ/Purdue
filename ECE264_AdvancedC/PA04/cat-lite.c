#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//#define EXIT_FAILURE 1
//#define EXIT_SUCCESS 0

void file_copy(FILE * file1,FILE * file2)
{
	int c;

	while((c = fgetc(file1)) != EOF)
	{
		fputc(c,file2);
	}
}

int main(int argc,char *argv[])
{
	FILE * fp;
	int i;
	char help_mes[] = 
 	"Usage: cat-lite [--help] [FILE]...\nWith no FILE, or when FILE is -, read standard input.\n\nExamples:\n  cat-lite README   Print the file README to standard output.\n  cat-lite f - g    Print f's contents, then standard input, \n                    then g's contents.\n  cat-lite          Copy standard input to standard output.\n";                                                      
	for (i = 1; i < argc; i++)
	{
		if(strcmp(argv[i], "--help") == 0 )
		{	
			printf("%s", help_mes);
			return EXIT_SUCCESS;
		}
	}
		if(argc == 1)
			file_copy(stdin,stdout);
		else
		while(--argc > 0)
		{
			if (strcmp(*++argv,"-") == 0)
				file_copy(stdin,stdout);
			else if((fp = fopen(*argv,"r")) == NULL) //open successfully then return 1 
			{
				fprintf(stderr, "no such file %s \n", *argv);
				return EXIT_FAILURE;
			}
			else
			{
				file_copy(fp,stdout);
				fclose(fp);
			}
		}
	return EXIT_SUCCESS;
}
