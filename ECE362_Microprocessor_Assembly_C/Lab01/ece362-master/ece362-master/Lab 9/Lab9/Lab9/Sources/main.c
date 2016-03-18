//***********************************************************************
// ECE 362 - Experiment 9 - Fall 2014
//***********************************************************************
//	 	   			 		  			 		  		
// Completed by: < Kyunghoon Jung >
//               < 5413-J >
//               < Section 4, W 8:30 - 11:20 >
//
//
// Academic Honesty Statement:  In entering my name above, I hereby certify
// that I am the individual who created this HC(S)12 source file and that I 
// have not copied the work of any other student (past or present) while 
// completing it. I understand that if I fail to honor this agreement, I will 
// receive a grade of ZERO and be subject to possible disciplinary action.
//***********************************************************************
//
// The objective of this experiment is to implement an analog signal sampling
// and reconstruction application that allows the user to efficiently cycle
// through different input and output sampling frequencies.
//
// The following design kit resources will be used:
//
// - left pushbutton (PAD7): cycles through input sampling frequency choices
//                           (5000 Hz, 10,000 Hz, and 20,000 Hz)
//
// - right pushbutton (PAD6): cycles through output sampling frequency choices
//                           (23,529 Hz, 47,059 Hz, and 94,118 Hz)
//
// - LCD: displays current values of input and output sampling frequencies
// - Shift Register: performs SPI -> parallel conversion for LCD interface
//
//***********************************************************************
 
#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

// All funtions after main should be initialized here
char inchar(void);
void outchar(char x);
void fdisp(int freqI, int freqO2);
void shiftout(char x);
void lcdwait(void);
void send_byte(int x);
void send_i(int x);
void chgline(char x);
void print_c(char x);
void pmsglcd(char str[]);

//  Variable declarations  	   			 		  			 		       
int leftpb	= 0;  // left pushbutton flag
int rghtpb	= 0;  // right pushbutton flag
int prevpb	= 0;  // previous pushbutton state
int freq = 5000;
int freqO = 23529;
int RTICNT = 0;
int prevpbl = 0;  // previous left pushbutton state
int prevpbr = 0;  // previous right pushbutton state
int runstp  = 0;  // run/stop flag
int goteam  = 0;  // "go team" flag (used to start reaction timer)
int temp = 0;
int i = 0;
int input = 0;
int output = 0;

// LCD COMMUNICATION BIT MASKS
int RS = 0x04;     //;RS pin mask (PTT[2])
int RW = 0x08;     //;R/W pin mask (PTT[3])
int LCDCLK  = 0x10;     //;LCD EN/CLK pin mask (PTT[4])

// LCD INSTRUCTION CHARACTERS
int LCDON = 0x0F;     //;LCD initialization command
int LCDCLR = 0x01;     //;LCD clear display command
int TWOLINE = 0x38;     //;LCD 2-line enable command

int CURMOV = 0xFE;     //;LCD cursor move instruction

int LINE1 = 0x80;     //;LCD line 1 cursor position
int LINE2 = 0xC0;     //;LCD line 2 cursor position

	 	   		
//***********************************************************************
//Initializations
//***********************************************************************/

void  initializations(void) {

//Set the PLL speed (bus clock = 24 MHz)
  CLKSEL = CLKSEL & 0x80; //; disengage PLL from system
  PLLCTL = PLLCTL | 0x40; //; turn on PLL
  SYNR = 0x02;            //; set PLL multiplier
  REFDV = 0;              //; set PLL divider
  while (!(CRGFLG & 0x08)){  }
  CLKSEL = CLKSEL | 0x80; //; engage PLL


//Disable watchdog timer (COPCTL register)
  COPCTL = 0x40   ; //COP off; RTI and COP stopped in BDM-mode

         
// Add additional port pin initializations here
  ATDDIEN = 0xC0; //program PAD7 and PAD6 pins as digital inputs
  prevpb  = 0;

// Initialize the SPI to 6 MHz
  DDRM   = 0xFF;
  SPICR1 = 0x50;
  SPICR2 = 0x00;
  SPIBR  = 0x01;
	 	   			 		  			 		  		
// Initialize digital I/O port pins
  DDRT = 0xFF;

// Initialize the LCD
//    - pull LCDCLK high (idle)
//    - pull R/W' low (write state)
//    - turn on LCD (LCDON instruction)
//    - enable two-line mode (TWOLINE instruction)
//    - clear LCD (LCDCLR instruction)
//    - wait for 2ms so that the LCD can wake up
  PTT_PTT4 = 1;
  PTT_PTT3 = 0;
  send_i(LCDON);
  send_i(TWOLINE);
  send_i(LCDCLR);
  lcdwait();
  lcdwait();

	 	   			 		  			 		  		
// Initialize RTI for 2.048 ms interrupt rate
  RTICTL = 0x41;
  CRGINT = CRGINT | 0x80;	


// Initialize TIM Ch 7 (TC7) for appropriate interrupt rate
//    Enable timer subsystem
//    Set channel 7 for output compare
//    Set appropriate pre-scale factor and enable counter reset after OC7
//    Set up channel 7 to generate 1 ms interrupt rate
//    Initially disable TIM Ch 7 interrupts
  TSCR1 = 0x80;
  TSCR2 = 0x0C;
  TIOS  = 0x80;
  TIE   = 0x80;
  TC7   = 1500;

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
	 		  			 		  		
//***********************************************************************
//Main
//***********************************************************************

void main(void) {
  	DisableInterrupts;
	initializations(); 		  			 		  		
	EnableInterrupts;



  for(;;) {
  

  /* write your code here */
  
  if(leftpb == 1) {
    leftpb = 0;
  input++;
  if(input == 0){
    TC7 = 300;
    freq = 5000;
  } else if(input == 1){
    TC7 = 150;
    freq = 10000;
  } else if(input == 2){
    TC7 = 75;
    freq = 20000;
  } else if(input == 3){
    input = 0;
  }
    fdisp(input,output);
  }
  
  if(rghtpb == 1){
  rghtpb = 0;
  output++;
  if(output == 0){
    PWMPRCLK = 2;
    freqO = 23529;
  } else if(output == 1){
    PWMPRCLK = 1;
    freqO = 47059;
  } else if(output == 2) {
    PWMPRCLK = 0;
    freqO = 94118;
  } else if(output = 3) {
    output = 0;
  }     
      fdisp(input, output);
  }


 
  } /* loop forever */
   
}  /* do not leave main */




//***********************************************************************
// RTI interrupt service routine: RTI_ISR
//
//  Initialized for 2.048 ms interrupt rate
//
//  Samples state of pushbuttons (PAD7 = left, PAD6 = right)
//
//  If change in state from "high" to "low" detected, set pushbutton flag
//     leftpb (for PAD7 H -> L), rghtpb (for PAD6 H -> L)
//     Recall that pushbuttons are momentary contact closures to ground		  				  		
//***********************************************************************

interrupt 7 void RTI_ISR(void)
{
  	// clear RTI interrupt flag
  	CRGFLG = CRGFLG | 0x80;
  	 
  if(RTICNT > 71){
    RTICNT = 0;
  }
  RTICNT++;

  if (PTAD_PTAD7 == 0 && prevpbl == 1){
    leftpb = 1;
  }
  prevpbl = PTAD_PTAD7;
  
  if(PTAD_PTAD6 == 0 && prevpbr == 1){
    rghtpb = 1;
  }
  prevpbr = PTAD_PTAD6; 

}

//***********************************************************************
//  TIM interrupt service routine
//
//  used to initiate ATD samples (on Ch 0 and Ch 1)
//	 		  			 		  		
//***********************************************************************

interrupt 15 void TIM_ISR(void)
{

        // clear TIM CH 7 interrupt flag 
 	TFLG1 = TFLG1 | 0x80;
 	ATDCTL5 = 0x10;
 while((ATDSTAT0 & 0x80) != 0x80) {
         }
 	PWMDTY0 = (ATDDR0H * ATDDR1H) / 256; 


}

//***********************************************************************
//  fdisp: Display "ISF = NNNNN Hz" on the first line of the LCD and display 
//         and "OSF = MMMMM Hz" on the second line of the LCD (where NNNNN and
//         MMMMM are the input and output sampling frequencies, respectively         
//***********************************************************************
void fdisp(int input, int output)
{
  chgline(LINE1);
  pmsglcd("ISF = ");
  temp = input;
  if(input == 0) {
    pmsglcd(" 5000");
  } else if(input == 1){
    pmsglcd("10000");
  }else if(input == 2){
    pmsglcd("20000");
  }else{
  print_c((temp/10000) + 0x30);
  print_c((temp/1000) % 10 + 0x30);
  print_c((temp/100) % 10 + 0x30);
  print_c((temp/10) % 10 + 0x30);
  print_c(temp % 10 + 0x30);
  }
  pmsglcd(" Hz");
  
  chgline (LINE2);
  pmsglcd ("OSF = ");
  temp = output;
  if(output == 0) {
    pmsglcd("23529");
  } else if(output == 1){
    pmsglcd("47059");
  }else if(output == 2){
    pmsglcd("94118");
  }else{
  print_c((temp/10000) + 0x30);
  print_c((temp/1000) % 10 + 0x30);
  print_c((temp/100) % 10 + 0x30);
  print_c((temp/10) % 10 + 0x30);
  print_c(temp % 10 + 0x30);
  }
  pmsglcd(" Hz");  
 
}


//***********************************************************************
//  shiftout: Transmits the contents of register A to external shift 
//            register using the SPI.  It should shift MSB first.  
//             
//            MISO = PM[4]
//            SCK  = PM[5]
//***********************************************************************
 
void shiftout(char x)

{
 
  //read the SPTEF bit, continue if bit is 1
  //write data to SPI data register
  //wait for 30 cycles for SPI data to shift out
  while(SPISR_SPTEF == 0){
  }
  SPIDR = x;
  lcdwait(); 

}

//***********************************************************************
//  lcdwait: Delay for 2 ms
//***********************************************************************

void lcdwait() {
 int n = 8;
  int m = 6000;
  while(n!=0){
    while(m){
      m--;
    }
    n--;
  }
 
}

//*********************************************************************** 
//  send_byte: writes contents of register A to the LCD
//***********************************************************************

void send_byte(int x)
{
     //Shift out character
     //Pulse LCD clock line low->high
     //Wait 2 ms for LCD to process data
  shiftout(x);
  PTT_PTT4 = 0;
  PTT_PTT4 = 1;
  PTT_PTT4 = 0;
  lcdwait();
}

//***********************************************************************
//  send_i: Sends instruction passed in register A to LCD  
//***********************************************************************

void send_i(int x)
{
        //Set the register select line low (instruction data)
  PTT_PTT2 = 0;
        //Send byte
  send_byte(x);
}

//***********************************************************************
//  chgline: Move LCD cursor to the cursor position passed in A
//  NOTE: Cursor positions are encoded in the LINE1/LINE2 variables
//***********************************************************************

void chgline(char x)
{
  send_i(CURMOV);
  send_i(x);
}

//***********************************************************************
//  print_c: Print character passed in register A on LCD ,            
//***********************************************************************
 
void print_c(char x)
{
  PTT_PTT2 = 1;
  send_byte(x);
}

//***********************************************************************
//  pmsglcd: pmsg, now for the LCD! Expect characters to be passed
//           by call.  Registers should return unmodified.  Should use
//           print_c to print characters.  
//***********************************************************************

void pmsglcd(char str[])
{
  int i = 0;
  while(str[i] != '\0'){
    print_c(str[i]);
    i++;
  }
}

