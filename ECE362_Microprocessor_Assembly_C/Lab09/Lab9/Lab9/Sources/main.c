/*
***********************************************************************
 ECE 362 - Experiment 9 - Spring 2015
***********************************************************************
	 	   			 		  			 		  		
 Completed by: < Tian Qiu >
               < 5063-Q >
               < 07 >


 Academic Honesty Statement:  In entering my name above, I hereby certify
 that I am the individual who created this HC(S)12 source file and that I 
 have not copied the work of any other student (past or present) while 
 completing it. I understand that if I fail to honor this agreement, I will 
 receive a grade of ZERO and be subject to possible disciplinary action.
***********************************************************************

 The objective of this experiment is to implement an analog signal sampling
 and reconstruction application that allows the user to efficiently cycle
 through different input and output sampling frequencies.

 The following design kit resources will be used:

 - left pushbutton (PAD7): cycles through input sampling frequency choices
                           (5000 Hz, 10,000 Hz, and 20,000 Hz)

 - right pushbutton (PAD6): cycles through output sampling frequency choices
                           (23,529 Hz, 47,059 Hz, and 94,118 Hz)

 - LCD: displays current values of input and output sampling frequencies
 - Shift Register: performs SPI -> parallel conversion for LCD interface

***********************************************************************
*/
 
#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

/* All funtions after main should be initialized here */
char inchar(void);
void outchar(char x);
void fdisp(void);
void shiftout(char x);
void lcdwait(void);
void send_byte(char x);
void send_i(char x);
void chgline(char x);
void print_c(char x);
void pmsglcd(char[]);

/*  Variable declarations */ 	   			 		  			 		       
char leftpb	= 0;  // left pushbutton flag
char rghtpb	= 0;  // right pushbutton flag
char prevpb	= 0;  // previous pushbutton state
int input = 0;
int output = 0;
int prevpbl = 0;
int prevpbr = 0;
int first = 0;
int saw = 0;
int vol = 0;

/* LCD COMMUNICATION BIT MASKS */
#define RS 0x04		// RS pin mask (PTT[2])
#define RW 0x08		// R/W pin mask (PTT[3])
#define LCDCLK 0x10	// LCD EN/CLK pin mask (PTT[4])

/* LCD INSTRUCTION CHARACTERS */
#define LCDON 0x0F	// LCD initialization command
#define LCDCLR 0x01	// LCD clear display command
#define TWOLINE 0x38	// LCD 2-line enable command
#define CURMOV 0xFE	// LCD cursor move instruction
#define LINE1  0x80	// LCD line 1 cursor position
#define LINE2  0xC0	// LCD line 2 cursor position
/*	 	   		
***********************************************************************
 Initializations
***********************************************************************
*/

void  initializations(void) {

/* Set the PLL speed (bus clock = 24 MHz) */
  CLKSEL = CLKSEL & 0x80; //; disengage PLL from system
  PLLCTL = PLLCTL | 0x40; //; turn on PLL
  SYNR = 0x02;            //; set PLL multiplier
  REFDV = 0;              //; set PLL divider
  while (!(CRGFLG & 0x08)){  }
  CLKSEL = CLKSEL | 0x80; //; engage PLL


/* Disable watchdog timer (COPCTL register) */
  COPCTL = 0x40   ; //COP off; RTI and COP stopped in BDM-mode

/* Initialize asynchronous serial port (SCI) for 9600 baud, no interrupts */
  SCIBDH =  0x00; //set baud rate to 9600
  SCIBDL =  0x9C; //24,000,000 / 16 / 156 = 9600 (approx)  
  SCICR1 =  0x00; //$9C = 156
  SCICR2 =  0x0C; //initialize SCI for program-driven operation
  DDRB   =  0x10; //set PB4 for output mode
  PORTB  =  0x10; //assert DTR pin on COM port

         
/* Add additional port pin initializations here */
  DDRAD = 0;               // ???  input ?
  ATDDIEN = 0xC0;         
  /*
  ATDDIEN (digital input enable)
– IEN (bits 7-0) – digital input enable on
channel on Port AD pin
• “0” – Port AD bit used as analog input
• “1” – Port AD bit used as digital input

 mask off PTAD7 and PTAD6    1100 0000
 
 PTAD ; read current state of pushbuttons
  */  



/* Initialize the SPI to 6 Mbs */

  DDRM = 0x30;             // ??? SPI input?    1SCK 1MOSI 0000    
  SPIBR = 0x10;            
  /* SPI BaudRate = BusClock / [ (SPPR + 1) * 2 (SPR +1) ]
Example: if SPR=000 and SPPR=000 (default), BaudRate = BusClock / 2  

 24M = busClock   
 [ (SPPR + 1) * 2 (SPR +1) ]  = 24Mbs / 6Mbs      = 4
 
 SPPR = 1 SPR =0  or SPPR  = 0 SPR  = 1
  0x10   0001 0000                  0x01               0000 0001
SPIBR (baud rate register)
o SPRx (bits 2-0) – baud rate pre-selection bits
o SPPRx (bits 6-4) – baud rate selection bits


 bits per second transmitted over serial link */
  SPICR1_SPE = 1;
  /* SPICR1 (control register #1)
o SPIE (bit 7)
? 0 ? SPI interrupts disabled
? 1 ? SPI interrupts enabled
o SPE (bit 6)
? 0 ? SPI disabled (“power off”)
? 1 ? SPI enabled (“power on”) 
*/
  SPICR1_MSTR = 1;
  SPICR1_CPHA = 0; //odd edge is 0->1, 0->1->0,(cpol = 0, idles low,means most time low) 
	 		  		
/* Initialize digital I/O port pins */

/*DDRT (data direction register)
• “0” – port pin configured for input
• “1” – port pin configured for output
indicates default mode after RESET

*/                               // 1111 1111
  DDRT = 0xFF;
  ATDCTL2 = 0xC0;
  ATDCTL3 = 0x10;
  ATDCTL4 = 0x85;
 	   			 		  		

/* Initialize the LCD
     - pull LCDCLK high (idle)
     - pull R/W' low (write state)
     - turn on LCD (LCDON instruction)
     - enable two-line mode (TWOLINE instruction)
     - clear LCD (LCDCLR instruction)
     - wait for 2ms so that the LCD can wake up     
*/ 
  PTT_PTT4 = 1;
  PTT_PTT3 = 0;
  send_i(LCDON);
  send_i(TWOLINE);
  send_i(LCDCLR);
  lcdwait();
/* Initialize RTI for 2.048 ms interrupt rate */	
  RTICTL = 0x45;
  CRGINT = CRGINT | 0x80;
/* Initialize TIM Ch 7 (TC7) for periodic interrupts every 1.000 ms
     - enable timer subsystem
     - set channel 7 for output compare
     - set appropriate pre-scale factor and enable counter reset after OC7
     - set up channel 7 to generate 1 ms interrupt rate
     - initially disable TIM Ch 7 interrupts      
*/
  TSCR1 = 0x80;
  TC7   = 1500; 
  TSCR2 = 0x0C;
  TIOS  = 0x80;
  TIE   = 0x80;


// PT0 used as PWM Ch0 output
  MODRR = 1;
  
// enable PWM ch0
  PWME = 1;
  
// set active high polarity
  PWMPOL = 1;
  
// 8bit mode
  PWMCTL = 0;
  
// left aligned output mode
  PWMCAE = 0;
  
// set max = 8bit period
  PWMPER0 = 0xFF;
  
// initially clear duty register
  PWMDTY0 = 0;
  
// set clock A for channel 0
  PWMCLK = 0;
  
// set clock A = 12MHz (Prescalar 2)
  PWMSCLA = 1;
	     
	      
}

/*	 		  			 		  		
***********************************************************************
 Main
***********************************************************************
*/

void main(void) {
  DisableInterrupts;
	initializations(); 		  			 		  		
	EnableInterrupts;



  for(;;) {
  

  /* write your code here */
 /* if(leftpb == 1){
    if(first == 0){
      input--;
      first = 1;
    }
    input++;
    if(input%3 == 0){
      TC7 = 300;
    }
    if(input%3 == 1){
      TC7 = 150;  
    }
    if(input%3 == 2){
      TC7 = 75;
    }
    leftpb = 0;
    fdisp();      

    } else if(rghtpb == 1){
      if(first == 0){
        output--;
        first = 1;
      }
      output++;
      if(output%3 == 0){
        PWMPRCLK = 2; 
      }
      if(output%3 == 1){
        PWMPRCLK = 1; 
      }
      if(output%3 == 2){
        PWMPRCLK = 0;
      }
      rghtpb = 0;
      fdisp();
    }  */         

  TC7 = 150 + 4 * ATDDR0H;
  vol = ATDDR1H;   
                                                                                     

 
  } /* loop forever */

}  /* do not leave main */




/*
***********************************************************************
 RTI interrupt service routine: RTI_ISR

  Initialized for 2.048 ms interrupt rate

  Samples state of pushbuttons (PAD7 = left, PAD6 = right)

  If change in state from "high" to "low" detected, set pushbutton flag
     leftpb (for PAD7 H -> L), rghtpb (for PAD6 H -> L)
     Recall that pushbuttons are momentary contact closures to ground
***********************************************************************
*/

interrupt 7 void RTI_ISR(void)
{
  	// clear RTI interrupt flag
  	CRGFLG = CRGFLG | 0x80; 
 
 
  if (PTAD_PTAD7 == 0 && prevpbl == 1){
    leftpb = 1;
  }
  prevpbl = PTAD_PTAD7;
  
  if(PTAD_PTAD6 == 0 && prevpbr == 1){
    rghtpb = 1;
  }
  prevpbr = PTAD_PTAD6; 

}

/*
***********************************************************************
  TIM interrupt service routine
  used to initiate ATD samples (on Ch 0 and Ch 1)	 		  			 		  		
***********************************************************************
*/

interrupt 15 void TIM_ISR(void)
{

        // clear TIM CH 7 interrupt flag 
 	TFLG1 = TFLG1 | 0x80; 
 	
 	ATDCTL5 = 0x10;
 	while((ATDSTAT0 & 0x80) != 0x80) {
 	}
  
  saw = (saw + 1) % 255;
  PWMDTY0 = saw * vol / 255;		
 	
 	asm{
     	  bset	TFLG1,$80	//; clear TC7 interrupt flag

      /*	ldaa	ATDDR0		//; analog input sample
      	ldab	ATDDR1		//; potentiometer sample
      	mul			//; multiply input sample x potentiometer setting
      	adca	#0		//; round upper 8 bits of result
      	staa	PWMDTY0		//; copy result to PWM Ch 0
      	*/
 	}
  

 	


}

/*
***********************************************************************
  fdisp: Display "ISF = NNNNN Hz" on the first line of the LCD and display 
         and "OSF = MMMMM Hz" on the second line of the LCD (where NNNNN and
         MMMMM are the input and output sampling frequencies, respectively         
***********************************************************************
*/

void fdisp()
{
  send_i(LCDCLR);
  chgline(LINE1);
  pmsglcd("ISF = ");
  if(input%3 == 0){
    pmsglcd("05000 Hz");
  } else if(input%3 == 1){
    pmsglcd("10000 Hz");
  } else if(input%3 == 2){
    pmsglcd("20000 Hz");
  } else{
    pmsglcd("Error");
  }
  
  chgline(LINE2);
  pmsglcd("OSF = ");
  if(output%3 == 0){
    pmsglcd("23529 Hz");
  } else if(output%3 == 1){
    pmsglcd("47059 Hz");
  } else if(output%3 == 2){
    pmsglcd("94118 Hz");
  } else{
    pmsglcd("Error");
  } 
 
}

/*
***********************************************************************
  shiftout: Transmits the character x to external shift 
            register using the SPI.  It should shift MSB first.  
             
            MISO = PM[4]
            SCK  = PM[5]
***********************************************************************
*/
 
void shiftout(char x)

{
 
  // read the SPTEF bit, continue if bit is 1
  // write data to SPI data register
  // wait for 30 cycles for SPI data to shift out 
  int a = 0;
  while(!SPISR_SPTEF);
  SPIDR = x;
  while(a<30){
    a++;
  }
}

/*
***********************************************************************
  lcdwait: Delay for approx 2 ms
***********************************************************************
*/

void lcdwait()
{
  int n = 8;
  int m = 6000;
  while(n!=0){
    while(m){
      m--;
    }
    n--;
  }
}

/*
*********************************************************************** 
  send_byte: writes character x to the LCD
***********************************************************************
*/

void send_byte(char x)
{
     // shift out character
     // pulse LCD clock line low->high->low
     // wait 2 ms for LCD to process data
  shiftout(x);
  PTT_PTT4 = 0;
  PTT_PTT4 = 1;
  PTT_PTT4 = 0; 
  lcdwait();
}

/*
***********************************************************************
  send_i: Sends instruction byte x to LCD  
***********************************************************************
*/

void send_i(char x)
{
        // set the register select line low (instruction data)
        // send byte
        PTT_PTT2 = 0; 
  send_byte(x);      
}

/*
***********************************************************************
  chgline: Move LCD cursor to position x
  NOTE: Cursor positions are encoded in the LINE1/LINE2 variables
***********************************************************************
*/

void chgline(char x)
{
  send_i(CURMOV);
  send_i(x);
}

/*
***********************************************************************
  print_c: Print (single) character x on LCD            
***********************************************************************
*/
 
void print_c(char x)
{
    PTT_PTT2 = 1;
  send_byte(x);
}

/*
***********************************************************************
  pmsglcd: print character string str[] on LCD
***********************************************************************
*/

void pmsglcd(char str[])
{
    int i = 0;
   while(str[i] != '\0'){
    print_c(str[i]);
    i++;
   }
}


/*
***********************************************************************
 Character I/O Library Routines for 9S12C32 (for debugging only)
***********************************************************************
 Name:         inchar
 Description:  inputs ASCII character from SCI serial port and returns it
 Example:      char ch1 = inchar();
***********************************************************************
*/

char inchar(void) {
  /* receives character from the terminal channel */
        while (!(SCISR1 & 0x20)); /* wait for input */
    return SCIDRL;
}

/*
***********************************************************************
 Name:         outchar
 Description:  outputs ASCII character x to SCI serial port
 Example:      outchar('x');
***********************************************************************
*/

void outchar(char x) {
  /* sends a character to the terminal channel */
    while (!(SCISR1 & 0x80));  /* wait for output buffer empty */
    SCIDRL = x;
}