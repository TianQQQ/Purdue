/*
 * March 10, 2006
 *
 * John Palmarin sent me this source code to supplement my tutorial,
 * "Writing to Flash Memory on the NanoCore12C32", which is available at:
 *      http://www.dlitz.net/stuff/9s12/flash/
 *
 * NOTE: The copyright notice and license for the above tutorial do NOT apply
 * to this file.
 *
 * Here is what John had to say about this file:
 *
 *   "Hey, I've stripped out the flash writing functions and function-copying
 *   function from my own project and wrote a quick "main" that demos how they
 *   work.  Won't actually work unless the user is using EmbeddedGNU by Eric
 *   Engler OR defines some of the registers exactly the same, as well as
 *   strips out all the printf statements.  In any case, its more than enough
 *   to get anyone who is decently advanced in C on their way."
 *
 * Cheers,
 *  - Dwayne Litzenberger
 * 
 */

/*This file demonstrates how to write to the flash on the 9s12c32
Note however, you MUST set your project options such that your code resides at
0xC000, instead of the default 0x8000.  This code was NOT tested using printf
(I used a custom SCI stdout) nor was it tested in its current form for that
matter.  This code IS messy because its a work in progress.

Credit goes to Dwayne C. Litzenberger for providing the algorithm (and assembly code) on
how to actually write to flash.  I adapted his assembly code to 
work in C.  
Credit goes to Prof. Karim Naqvi for demonstrating how to copy
functions from one location of memory to another and invoke it through
a pointer to that function.

Lastly, I take no responsibility if this code doesn't work or if it
ruins your Flash.  READ THE DOCUMENTATION for you device!
Please direct questions to john_palmarin@yahoo.ca

March 2006, John Palmarin.  University of Regina.  Engineering
*/

#include <stdio.h>
#include "9s12c32.h"		//All the Register definitions! 
							//Available with EmbeddedGNU by Eric Engler

#define SECTOR1 0x4000		//beginning of Flash
#define SECTOR2 0x4200		
#define SECTOR3 0x4400
#define SECTOR4 0x4600

//Prototypes
void flash_setup(void);
void program_flash(unsigned int* sector, char* Bytes);
void copybuf(unsigned char from[], unsigned char to[], int count);
int cmpbuf(unsigned char b1[], unsigned char b2[], int count);

int main()
{   
    unsigned int* memspot = (unsigned int*)SECTOR1;		//We need a means of addressing our Flash
    char stringVal[3] = "HI";   //Lets store "HI"
    
    flash_setup();     //set flash divider (This is for a 24MHz Bus clock, and a 8MHz Oscillator)
    
    int result = 0;				//Lets get the size of the function to copy		
    char* p2 = (char*)copybuf;			//pointer to the memory base of cmpbuf
    char* p1 = (char*)program_flash;		//pointer to the memory base of setflag
    int size = p2 - p1;			//subtract the two addresses

    unsigned char code_array[size];		//reserve spot on the stack to copy the function to

    copybuf((unsigned char*)program_flash, code_array, size);	//cast function (cause its void)
    result = cmpbuf((unsigned char*)program_flash, code_array, size);  //again cast
    if(result == 0)
    {
      printf("Copy Success");
    }
    else
    {
      printf("Copy Failed!");
    }
    
    printf("Pre Function Call: %x", *memspot);

   typedef void (*PF)(unsigned int*, char*);	  	//this type defines PF as a pointer to a function that whose type is void and takes no parameters
   ((PF)code_array)(memspot, stringVal);		//call the function from RAM now
   
   printf("Post Function Call: %x", *memspot);

   return 0;
}

void flash_setup(void)
{
  FCLKDIV = 0x28;   //0x51 works too.
}

void program_flash(unsigned int* sector, char* Bytes)
{
    int temp2;
    int temp3;
    long int temp4;	//long not necessary, as int is long enough
    temp2 = ((int)Bytes[0] << 8)&0xFF00;		//I'm doing this to fit two chars into an int
    temp3 = ((int)Bytes[1])&0x00FF;				//There are different ways to do this

    temp4 = temp2 | temp3;
    *sector = temp4;	//this assignment, defines what sector you are going to erase		

    FCMD = 0x40;		//erase
    FSTAT = 0x80;

  //wait until done
    while((FSTAT & 0x40) == 0x00)
      {;}

    *sector = temp4;	//actually writing the value now
    FCMD = 0x20;		//write
    FSTAT = 0x80;

    while((FSTAT & 0x40) == 0x00)
      {;}

}


void copybuf(unsigned char from[], unsigned char to[], int count) //By Prof Naqvi
{
    int i = 0;
    for ( ; i < count; i++)
    {
        to[i] = from[i];
    }
}


int cmpbuf(unsigned char b1[], unsigned char b2[], int count)	//By Prof Naqvi
{
    int result = 0;
    int i = 0;
    for ( ; i < count; i++)
    {

        result = b1[i] - b2[i];
        if (result != 0)
            return result;
    }
    return result;
}
