//***********************************************************************
// ECE 362 - Experiment 8 - Fall 2014
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
//
//***********************************************************************
//
// The objective of this experiment is to implement a reaction time assessment
// tool that measures, with millisecond accuracy, response to a visual
// stimulus -- here, both a YELLOW LED and the message "Go Team!" displayed on 
// the LCD screen.  The TIM module will be used to generate periodic 
// interrupts every 1.000 ms, to serve as the time base for the reaction measurement.  
// The RTI module will provide a periodic interrupt at a 2.048 ms rate to serve as 
// a time base for sampling the pushbuttons and incrementing the variable "random" 
// (used to provide a random delay for starting a reaction time test). The SPI
// will be used to shift out data to an 8-bit SIPO shift register.  The shift
// register will perform the serial to parallel data conversion for the LCD.
//
// The following design kit resources will be used:
//
// - left LED (PT1): indicates test stopped (ready to start reaction time test)
// - right LED (PT0): indicates a reaction time test is in progress
// - left pushbutton (PAD7): starts reaction time test
// - right pushbutton (PAD6): stops reaction time test (turns off right LED
//                    and turns left LED back on, and displays test results)
// - LCD: displays status and result messages
// - Shift Register: performs SPI -> parallel conversion for LCD interface
//
// When the right pushbutton is pressed, the reaction time is displayed
// (refreshed in place) on the first line of the LCD as "RT = NNN ms"
// followed by an appropriate message on the second line 
// e.g., 'Ready to start!' upon reset, 'Way to go HAH!!' if a really 
// fast reaction time is recorded, etc.). The GREEN LED should be turned on
// for a reaction time less than 250 milliseconds and the RED LED should be
// turned on for a reaction time greater than 1 second.
//
//***********************************************************************
#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

#define RLed      PTT_PTT0
#define LLed      PTT_PTT1
#define YELLOW    PTT_PTT7
#define RED       PTT_PTT3
#define GREEN     PTT_PTT2

// All funtions after main should be initialiezed here
char inchar(void);
void outchar(char ch);
void tdisp(void);
void shiftout(char x);
void lcdwait(void);
void send_byte(int x);
void send_i(int x);
void chgline(char x);
void print_c(char x);
void pmsglcd(char str[]);

//  Variable declarations  	   			 		  			 		       
int goteam  = 0;  // "go team" flag (used to start reaction timer)
int leftpb  = 0;  // left pushbutton flag
int rghtpb  = 0;  // right pushbutton flag
int prevpb  = 0;  // previous pushbutton state
int prevpbl = 0;  // previous left pushbutton state
int prevpbr = 0;  // previous right pushbutton state
int runstp  = 0;  // run/stop flag
int random  = 0;  // random variable (2 bytes)
int react   = 0;  // reaction time (3 packed BCD digits)
int tin     = 0;  // SCI transmit display buffer IN pointer
int tout    = 0;  // SCI transmit display buffer OUT pointer
int tsize   = 0;  // size of transmit buffer
int tbuf    = 0;  // SCI transmit display buffer
int RTICNT = 0;

//ASCII character definitions
int CR      = 0x0D;   //Return???

//LCD COMMUNICATION BIT MASKS
int RS      = 0x04;     //;RS pin mask (PTT[2])
int RW      = 0x08;     //;R/W pin mask (PTT[3])
int LCDCLK  = 0x10;     //;LCD EN/CLK pin mask (PTT[4])

//LCD INSTRUCTION CHARACTERS
int LCDON   = 0x0F;     //;LCD initialization command
int LCDCLR  = 0x01;     //;LCD clear display command
int TWOLINE = 0x38;     //;LCD 2-line enable command

int CURMOV  = 0xFE;     //;LCD cursor move instruction

int LINE1   = 0x80;     //;LCD line 1 cursor position
int LINE2   = 0xC0;     //;LCD line 2 cursor position

//LED BIT MASKS
//int GREEN  = 0x20;
//int RED    = 0x40;
//int YELLOW  = 0x80;
	 	   		
/***********************************************************************
Initializations
***********************************************************************/
void  initializations(void) {

//; Set the PLL speed (bus clock = 24 MHz)
  CLKSEL = CLKSEL & 0x80; //; disengage PLL from system
  PLLCTL = PLLCTL | 0x40; //; turn on PLL
  SYNR   = 0x02;            //; set PLL multiplier
  REFDV  = 0;              //; set PLL divider
  while (!(CRGFLG & 0x08)){  }
  CLKSEL = CLKSEL | 0x80; //; engage PLL


// Disable watchdog timer (COPCTL register)
  COPCTL = 0x40   ; //COP off; RTI and COP stopped in BDM-mode
  
// Initialize asynchronous serial port (SCI) for 9600 baud, no interrupts
  SCIBDH =  0x00; //set baud rate to 9600
  SCIBDL =  0x9C; //24,000,000 / 16 / 156 = 9600 (approx)  
  SCICR1 =  0x00; //$9C = 156
  SCICR2 =  0x0C; //initialize SCI for program-driven operation
  DDRB   =  0x10; //set PB4 for output mode
  PORTB  =  0x10; //assert DTR pin on COM port
         
         
//  Add additional port pin initializations here
  ATDDIEN = 0xC0; //program PAD7 and PAD6 pins as digital inputs
  prevpb  = 0;
  prevpbl = 1;  //initialize previous pushbutton state
  prevpbr = 1;  //initialize previous pushbutton state

//Initialize the SPI to baud rate of 6 Mbs
  DDRM   = 0xFF;
  SPICR1 = 0x50;
  SPICR2 = 0x00;
  SPIBR  = 0x01;

	 	   			 		  			 		  		
// Initialize digital I/O port pins
  DDRT = 0xFF;
   


 // Initialize the LCD
 // - pull LCDCLK high (idle)
 // - pull R/W' low (write state)
 // - turn on LCD (LCDON instruction)
 // - enable two-line mode (TWOLINE instruction)
 // - clear LCD (LCDCLR instruction)
 // - wait for 2ms so that the LCD can wake up

  PTT_PTT6 = 1;
  PTT_PTT5 = 0;
  send_i(LCDON);
  send_i(TWOLINE);
  send_i(LCDCLR);
  lcdwait();
  lcdwait();

	 	   			 		  			 		  		
// Initialize RTI for 2.048 ms interrupt rate	
  RTICTL = 0x41;
  CRGINT = CRGINT | 0x80;


// Initialize TIM Ch 7 (TC7) for periodic interrupts every 1.000 ms
//    Enable timer subsystem
//    Set channel 7 for output compare
//    Set appropriate pre-scale factor and enable counter reset after OC7
//    Set up channel 7 to generate 1 ms interrupt rate
//    Initially disable TIM Ch 7 interrupts

  
  TSCR1 = 0x80;
  TSCR2 = 0x0C;
  TIOS  = 0x80;
  TIE   = 0x00;
  TC7   = 1500;

}
	 		  			 		  		
/***********************************************************************
Main
***********************************************************************/
void main(void) {
  DisableInterrupts;
	initializations(); 		  			 		  		
	EnableInterrupts;



  for(;;) {

  /* write your code here */
 
//  If the left pushbutton ("start reaction test") flag is set, then:
//    - clear left pushbutton flag
//    - set the "run/stop" flag
//    - display message "Ready, Set..." on the first line of the LCD
//    - turn off the left LED (PT1)
//    - turn on the right LED (PT0)
//  Endif
 

  if(leftpb == 1 && !runstp){
     goteam = 0;
     react  = 0;
     runstp = 1;
     leftpb = 0;
     RLed   = 1;
     LLed   = 0;       
     YELLOW = 0;
     GREEN  = 0;
     RED    = 0;
     send_i(LCDCLR);
     lcdwait();
     pmsglcd("Ready, Set...");
   }


//  If the "run/stop" flag is set, then:
//    - If the "goteam" flag is NOT set, then:
//       + If "random" = $0000, then:
//         - set the "goteam" flag
//         - clear TCNT register (of TIM)
//         - clear "react" variable (2 bytes)
//         - enable TIM Ch7 interrupts
//         - turn on YELLOW LED 
//         - display message "Go Team!" on the second line of the LCD
//      + Endif
//    - Endif
//  Endif


  if(runstp && !goteam && random == 0){
     goteam = 1;
     react  = 0;
     YELLOW = 1;
     send_i(LCDCLR);
     lcdwait();
     pmsglcd("Go team!");
     TIE    = 0x80;
   }
	 	   			 		  			 		  		

//  If the right pushbutton ("stop reaction test") flag is set, then:
//    - clear right pushbutton flag
//    - clear the "run/stop" flag
//    - clear the "goteam" flag
//    - turn off yellow LED 
//    - disable TIM Ch 7 interrupts
//    - call "tdisp" to display reaction time message
//    - turn off right LED (PT0)
//    - turn on left LED (PT1)
//  Endif
	

  if(rghtpb == 1){
    rghtpb = 0;
    if(runstp && goteam){
      runstp = 0;
      //react = 240;
      TIE = 0x00;
      goteam = 0;
      YELLOW = 0; 
      send_i(LCDCLR);
      lcdwait();
      tdisp();
      
      if(react<=250){
        GREEN = 1;
        chgline(LINE2);
        pmsglcd("FUCK YEAH!");
      }else{
        GREEN = 0;
        chgline(LINE2);
        pmsglcd("Really?");
      }
      RLed   = 0;
      LLed   = 1;    
    }
  }

	 	   			 		  			 		  		
//  If "react" = 999 (the maximum 3-digit BCD value), then:
//    - clear the "run/stop" flag
//    - turn off yellow LED, turn on red LED
//    - disable TIM Ch 7 interrupts
//    - display message "Time = 999 ms" on the first line of the LCD
//    - display message "Too slow!" on the second line of the LCD 
//    - turn off right LED (PT0)
//    - turn on left LED (PT1)
//  Endif

  
  if(react >= 999 && runstp){
    runstp = 0;
    react  = 0;
    YELLOW = 0;
    RED    = 1;
    TIE    = 0x0;
    send_i(LCDCLR);
    lcdwait();
    pmsglcd("RT = 999ms");
    chgline(LINE2);
    pmsglcd("Too slow!");
    RLed   = 0;
    LLed   = 1;
  }



    
    //_FEED_COP();
  } /* loop forever */
  /* please make sure that you never leave main */
}




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
//
//  Also, increments 2-byte variable "random" each time interrupt occurs
//  NOTE: Will need to truncate "random" to 12-bits to get a reasonable delay   			 		  					  		
//***********************************************************************/
interrupt 7 void RTI_ISR(void)
{
  // clear RTI inturrupt flag 
  CRGFLG = CRGFLG | 0x80; 

  
  if(RTICNT >71){
    RTICNT = 0;
  }
  RTICNT++;

  if (PTAD_PTAD7 == 0 && prevpbl == 1){
    leftpb = 1;
  }
  prevpbl = PTAD_PTAD7;
  
  if(PTAD_PTAD6 == 0 && prevpbr == 1){
    rghtpb =1;
  }
  prevpbr = PTAD_PTAD6; 
  /*
  if(!runstp){
    random++;
  }
  */
    random++;
  if(random >= 4000 || random <= 0){
    random = 0;
  }

  /*
   if(runstp && !goteam){
    random--;
  }
  */

}

//***********************************************************************
//  TIM interrupt service routine
//
//  Initialized for 1.00 ms interrupt rate
//
//  Increment (3-digit) variable "react" by one 			 		  			 		  		
//***********************************************************************/
interrupt 15 void TIM_ISR(void)
{
  // clear TIM CH 7 interrupt flag
 	TFLG1 = TFLG1 | 0x80; 
 
  if(runstp && goteam){
    react++;
  }  
}

//***********************************************************************
//  tdisp: Display "RT = NNN ms" on the first line of the LCD and display 
//         an appropriate message on the second line depending on the 
//         speed of the reaction.  This routine should use the
//         "react" variable to determine which number and which message
//         to display.  pmsglcd will be useful for doing this.
//	  Convert react to ASCII before printing.	
//         
//         Also, this routine should set the green LED if the reaction 
//         time was less than 250 ms.
//
//         NOTE: The messages should be less than 16 characters since
//               the LCD is a 2x16 character LCD.
//***********************************************************************/
void tdisp()
{
  chgline (LINE1);
  pmsglcd("RT = ");
  print_c((react/100)%10 + 0x30);
  print_c((react/10)%10 + 0x30);
  print_c((react%10) + 0x30);
  pmsglcd(" ms");
  if(react <= 250){
    GREEN = 1;
  }
}

//***********************************************************************
//  shiftout: Transmits the contents of register A to external shift 
//            register using the SPI.  It should shift MSB first.  
//             
//            MISO = PM[4]
//            SCK  = PM[5]
//***********************************************************************/
void shiftout(char x)
{
  while(SPISR_SPTEF == 0){
  }
  SPIDR = x;
  lcdwait();
}

//***********************************************************************
//  lcdwait: Delay for 2 ms
//***********************************************************************/
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

//***********************************************************************
//  send_byte: writes contents of register A to the LCD
//***********************************************************************/
void send_byte(int x)
{
  shiftout(x);
  PTT_PTT6 = 0;
  PTT_PTT6 = 1;
  PTT_PTT6 = 0;
  lcdwait();
}
//***********************************************************************
//  send_i: Sends instruction passed in register A to LCD  
//***********************************************************************/
void send_i(int x)
{

  PTT_PTT6 = 0; 
  send_byte(x);

}

//***********************************************************************
//  chgline: Move LCD cursor to the cursor position passed in A
//  NOTE: Cursor positions are encoded in the LINE1/LINE2 variables
//***********************************************************************/
void chgline(char x)
{
  send_i(CURMOV);
  send_i(x);
}

//***********************************************************************
//  print_c: Print character passed in register A on LCD ,            
//***********************************************************************/
void print_c(char x)
{
  PTT_PTT6 = 1;
  send_byte(x);
}

//***********************************************************************
//  pmsglcd: pmsg, now for the LCD! Expect characters to be passed
//           by call.  Registers should return unmodified.  Should use
//           print_c to print characters.  
//***********************************************************************/
void pmsglcd(char str[])
{
  int i = 0;
  while(str[i] != '\0'){
    print_c(str[i]);
    i++;
  }
  /*
  int i =0;
  for(i=0; i< length; i++){
    print_c(arr[i],startpos+i);
  }
  */
}

//***********************************************************************
// Character I/O Library Routines for 9S12C32
//***********************************************************************
// Name:         inchar
// Description:  inputs ASCII character from SCI serial port and returns it
// Example:      char ch1 = inchar();
//***********************************************************************/
char  inchar(void) {
  /* receives character from the terminal channel */
        while (!(SCISR1 & 0x20)); /* wait for input */
    return SCIDRL;
 
}

//***********************************************************************
// Name:         outchar
// Description:  outputs ASCII character passed in outchar()
//                  to the SCI serial port
// Example:      outchar('x');
//***********************************************************************/
void outchar(char ch) {
  /* sends a character to the terminal channel */
    while (!(SCISR1 & 0x80));  /* wait for output buffer empty */
    SCIDRL = ch;
}