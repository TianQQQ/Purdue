// ***********************************************************************
//  ECE 362 - Experiment 6 - Fall 2014   
//
// Dual-channel LED bar graph display 
// ***********************************************************************
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
// ***********************************************************************

#include <hidef.h>           /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

// All funtions after main should be initialized here

// Note: inchar and outchar can be used for debugging purposes

char inchar(void);
void outchar(char x);
			 		  		
//  Variable declarations  	   			 		  			 		       
int tenthsec = 0;  // one-tenth second flag
int leftpb = 0;    // left pushbutton flag
int rghtpb = 0;    // right pushbutton flag
int runstp = 0;    // run/stop flag           ?            
int rticnt = 0;    // RTICNT (variable)
int prevpb = 1;    // previous state of pushbuttons (variable)
int out0 = 0;
int out1 = 0;
unsigned char THRESH1 = 0;
unsigned char THRESH2 = 0;
unsigned char THRESH3 = 0;
unsigned char THRESH4 = 0;
unsigned char THRESH5 = 0;
int count = 0;
int i;
	 	   		
// Initializations
 
void  initializations(void) {

// Set the PLL speed (bus clock = 24 MHz)

  		CLKSEL = CLKSEL & 0x80; // disengage PLL from system
  		PLLCTL = PLLCTL | 0x40; // turn on PLL
  		SYNR = 0x02;            // set PLL multiplier
  		REFDV = 0;              // set PLL divider
  		while (!(CRGFLG & 0x08)){  }
  		CLKSEL = CLKSEL | 0x80; // engage PLL
  
// Disable watchdog timer (COPCTL register)

      COPCTL = 0x40;    //COP off - RTI and COP stopped in BDM-mode

// Initialize asynchronous serial port (SCI) for 9600 baud, no interrupts

      SCIBDH =  0x00; //set baud rate to 9600
      SCIBDL =  0x9C; //24,000,000 / 16 / 156 = 9600 (approx)  
      SCICR1 =  0x00; //$9C = 156
      SCICR2 =  0x0C; //initialize SCI for program-driven operation
         
//  Initialize Port AD pins 7 and 6 for use as digital inputs

	    DDRAD = 0; 		//program port AD for input mode
      ATDDIEN = 0xC0; //program PAD7 and PAD6 pins as digital inputs
         
//  Add additional port pin initializations here  (e.g., Other DDRs, Ports) 
      
      DDRT = 0xFF;    // program port T for output mode
      PTT_PTT0 = 0;    // program port T data register
      PTT_PTT1 = 0;
//  Define bar graph segment thresholds (THRESH1..THRESH5)
//  NOTE: These are binary fractions

      THRESH1 = 0x2B;
      THRESH2 = 0x55;
      THRESH3 = 0x80;
      THRESH4 = 0xAB;
      THRESH5 = 0xD5;
      

//  Add RTI/interrupt initializations here

      rticnt = 0;
      CRGINT = 0x80;
      RTICTL = 0x70;
      ATDCTL2 = 0x80;
      ATDCTL3 = 0x10;
      ATDCTL4 = 0x85;
      ATDCTL5 = 0x10;
      ATDCTL2_AFFC = 1;     

}
	 		  			 		  		
 
// Main (non-terminating loop)
 
void main(void) {
	initializations(); 		  			 		  		
	EnableInterrupts;


  for(;;) {


// Main program loop (state machine)
// Start of main program-driven polling loop

	 	   			 		  			 		  		
//  If the "tenth second" flag is set, then
    if (tenthsec == 1) {
//    - clear the "tenth second" flag
      tenthsec = 0;
//    - if "run/stop" flag is set, then
      if (runstp == 1) {
//       - initiate ATD coversion sequence
         ATDCTL5 = 0x10;
         while((ATDSTAT0 & 0x80) != 0x80) {
         }
//       - apply thresholds to converted values
         out0 = 0;
         out1 = 0;
         if (ATDDR0H > 0x00 && ATDDR0H < THRESH1) {
          out0 = 1;
         }
         if (ATDDR0H > THRESH1 && ATDDR0H < THRESH2) {
          out0 = 2;
         }
         if (ATDDR0H > THRESH2 && ATDDR0H < THRESH3) {
          out0 = 3;
         }
         if (ATDDR0H > THRESH3 && ATDDR0H < THRESH4) {          
          out0 = 4;
         }
         if (ATDDR0H > THRESH4 && ATDDR0H < THRESH5) {
          out0 = 5;
         } else if (ATDDR0H > THRESH5) {
          out0 = 5;
         }
         
         if (ATDDR1H > 0x00 && ATDDR1H < THRESH1) {
          out1 = 1;
         }
         if (ATDDR1H > THRESH1 && ATDDR1H < THRESH2) {
          out1 = 2;
         }
         if (ATDDR1H > THRESH2 && ATDDR1H < THRESH3) {
          out1 = 3;
         }
         if (ATDDR1H > THRESH3 && ATDDR1H < THRESH4) {
          out1 = 4;
         }
         if (ATDDR1H > THRESH4 && ATDDR1H < THRESH5) {
          out1 = 5;
         } else if (ATDDR1H > THRESH5) {
          out1 = 5;
         }        
//       - determine 5-bit bar graph bit settings for each input channel
         for (i = 0; i <= 9; i++) {
          PTT_PTT4 = 0;
          if (i < 5) {
           if(out0 > 0) {
            
            PTT_PTT3 = 1;
            out0--;
           } else {
            PTT_PTT3 = 0;
           }
          }
//       - transmit 10-bit data to external shift register
          else {
           if (out1 > 0) {
            
            PTT_PTT3 = 1;
            out1--;
           } else {
            PTT_PTT3 = 0;
           }
          }
          PTT_PTT4 = 1;
         }
//    - endif
      }
//  Endif
    }
	 	   			 		  			 		  		
//  If the left pushbutton ("stop BGD") flag is set, then:
    if (leftpb == 1) {
//    - clear the left pushbutton flag
      leftpb = 0;
//    - clear the "run/stop" flag (and "freeze" BGD)
      runstp = 0;
//    - turn on left LED/turn off right LED (on docking module)
      PTT_PTT0 = 0;
      PTT_PTT1 = 1;
//  Endif
    }
   			 		  			 		  		

//  If the right pushbutton ("start BGD") flag is set, then
    if (rghtpb == 1) {
//    - clear the right pushbutton flag
      rghtpb = 0;
//    - set the "run/stop" flag (enable BGD updates)
      runstp = 1;
//    - turn off left LED/turn on right LED (on docking module)
      PTT_PTT0 = 1;
      PTT_PTT1 = 0;
//  Endif
    }
	 	
  } /* loop forever */
  
}  /* make sure that you never leave main */



// ***********************************************************************         ?            
// RTI interrupt service routine: rti_isr
//
//  Initialized for 5-10 ms (approx.) interrupt rate - note: you need to
//    add code above to do this
//
//  Samples state of pushbuttons (PAD7 = left, PAD6 = right)
//
//  If change in state from "high" to "low" detected, set pushbutton flag
//     leftpb (for PAD7 H -> L), rghtpb (for PAD6 H -> L)
//     Recall that pushbuttons are momentary contact closures to ground
//
//  Also, keeps track of when one-tenth of a second's worth of RTI interrupts
//     accumulate, and sets the "tenth second" flag         	   			 		  			 		  		
 
interrupt 7 void RTI_ISR( void)
{
 // set CRGFLG bit to clear RTI device flag
  	CRGFLG = CRGFLG | 0x80;
  	if (PORTAD0_PTAD7 < prevpb) {
  	  prevpb = 0;
  	  leftpb = 1;
  	} else if (PORTAD0_PTAD7 == 1) {
  	  prevpb = 1;
  	}
  	
  	if (PORTAD0_PTAD6 < prevpb) {
  	  prevpb = 0;
  	  rghtpb = 1;
  	} else if (PORTAD0_PTAD6 == 1) {
  	  prevpb = 1;
  	}
	  if (count == 10) {
	    tenthsec = 1;
	    count = 0;
	  } else {
	    count++;
	  }

}


// ***********************************************************************
// Character I/O Library Routines for 9S12C32 (for debugging only)
// ***********************************************************************
// Name:         inchar
// Description:  inputs ASCII character from SCI serial port and returns it
// ***********************************************************************
char  inchar(void) {
  /* receives character from the terminal channel */
        while (!(SCISR1 & 0x20)); /* wait for RDR input */
    return SCIDRL;
 
}

// ***********************************************************************
// Name:         outchar
// Description:  outputs ASCII character passed in outchar()
//                  to the SCI serial port
// ***********************************************************************/
void outchar(char ch) {
  /* transmits a character to the terminal channel */
    while (!(SCISR1 & 0x80));  /* wait for TDR empty */
    SCIDRL = ch;
}

