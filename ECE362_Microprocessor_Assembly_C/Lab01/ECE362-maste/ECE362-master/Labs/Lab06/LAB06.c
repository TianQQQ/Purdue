/***********************************************************************
; ECE 362 - Experiment 6 - Fall 2012                         
;***********************************************************************
;	 	   			 		  			 		  		
; Completed by: < your name >
;               < your class number >
;               < your lab division >
;
;
; Academic Honesty Statement:  In entering my name above, I hereby certify
; that I am the individual who created this HC(S)12 source file and that I 
; have not copied the work of any other student (past or present) while 
; completing it. I understand that if I fail to honor this agreement, I will 
; receive a grade of ZERO and be subject to possible disciplinary action.
;                             
;
;***********************************************************************/
#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

// All funtions after main should be initialiezed here
char inchar(void);
void outchar(char x);
void tdisp();


// ASCII character definitions
int CR = 0x0D;//Return                   
	 	   			 		  			 		  		

//  Variable declarations  	   			 		  			 		       
int tenthsec = 0;  // One-tenth second flag
int leftpb = 0;    // left pushbutton flag
int rghtpb = 0;    // right pushbutton flag
int runstp = 0;    // run/stop flag                         
int rticnt = 0;    // RTICNT (variable)
int prevpb = 0;    // previous state of pushbuttons (variable)
	 	   		
/***********************************************************************
Initializations
***********************************************************************/
void  initializations(void) {

//; Set the PLL speed (bus clock = 24 MHz)
  		CLKSEL = CLKSEL & 0x80; //; disengage PLL from system
  		PLLCTL = PLLCTL | 0x40; //; turn on PLL
  		SYNR = 0x02;            //; set PLL multiplier
  		REFDV = 0;              //; set PLL divider
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
         
//  Initialize Port AD pins 7 and 6 for use as digital inputs
		 DDRAD	= 0	; 		//program port AD for input mode
         ATDDIEN = 0xC0   ; //program PAD7 and PAD6 pins as digital inputs

         
//  Add additional port pin initializations here  (e.g., Other DDRs, Ports) 



//  Add RTI/interrupt initializations here


}
	 		  			 		  		
/***********************************************************************
Main
***********************************************************************/
void main(void) {
	initializations(); 		  			 		  		
	EnableInterrupts;


  for(;;) {


/*; Main program loop (state machine)
 Start of main program-driven polling loop
;
main
	 	   			 		  			 		  		
;  If the "tenth second" flag is set, then
;    - clear the "tenth second" flag
;    - If the "run/stop" flag is set, then
;      + decrement the shot clock value by one-tenth of a second
;      + update the 7-segment displays
;    - Endif
;  Endif

	 	   			 		  			 		  		
;  If the left pushbutton ("reset shot clock") flag is set, then:
;    - clear the "run/stop" flag
;    - reset the 7-segment display to "24"
;    - clear the left pushbutton flag
;  Endif
	 	   			 		  			 		  		

;  If the right pushbutton ("start/stop") flag is set, then
;    - clear the right pushbutton flag
;    - toggle the "run/stop" flag
;    - toggle the "run/stop" LED
;  Endif
	 	   			 		  			 		  		

;  If the shot clock has reached "00", then:
;    - clear the "run/stop" flag
;    - turn on the "time expired" LED
;    - turn off the "run/stop" LED
;  Endif
*/
    
    
    _FEED_COP(); /* feeds the dog */
  } /* loop forever */
  /* please make sure that you never leave main */
}



/***********************************************************************                       
; RTI interrupt service routine: rti_isr
;
;  Initialized for 1.408 ms interrupt rate
;
;  Samples state of pushbuttons (PAD7 = left, PAD6 = right)
;
;  If change in state from "high" to "low" detected, set pushbutton flag
;     leftpb (for PAD7 H -> L), rghtpb (for PAD6 H -> L)
;     Recall that pushbuttons are momentary contact closures to ground
;
;  Also, keeps track of when one-tenth of a second's worth of RTI interrupts go by,
;      and sets the "tenth second" flag         	   			 		  			 		  		
;***********************************************************************/
interrupt 7 void RTI_ISR( void)
{
  	// set CRGFLG bit 
  	CRGFLG = CRGFLG | 0x80; 
	

}

/***********************************************************************                        
;  Shot clock display routine "tdisp"
;
;  Displays the current count
;
;  NOTE: These values are in BCD and must be converted to 
;        "7-segment display code" -- table lookup should be
;        used to perform this conversion
;***********************************************************************/
void tdisp()
{

}

/***********************************************************************                       
; Add any additional subroutines needed here (e.g., count_down, BCD_to_7seg,
; shift_out_dat, etc.)
;***********************************************************************/



/***********************************************************************
; Character I/O Library Routines for 9S12C32
;***********************************************************************
; Name:         inchar
; Description:  inputs ASCII character from SCI serial port and returns it
;***********************************************************************/
char  inchar(void) {
  /* receives character from the terminal channel */
        while (!(SCISR1 & 0x20)); /* wait for input */
    return SCIDRL;
 
}

/***********************************************************************
; Name:         outchar
; Description:  outputs ASCII character passed in outchar()
;                  to the SCI serial port
;***********************************************************************/
void outchar(char ch) {
  /* sends a character to the terminal channel */
    while (!(SCISR1 & 0x80));  /* wait for output buffer empty */
    SCIDRL = ch;
}


