// ***********************************************************************
//  ECE 362 - Experiment 6 - Fall 2014     
//
// Dual-channel LED bar graph display                    
// ***********************************************************************
//	 	   			 		  			 		  		
// Completed by: < Tian Qiu >
//               < 5063-Q >
//               < 7 >
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
int runstp = 0;    // run/stop flag                         
int rticnt = 0;    // RTICNT (variable)
int prevpb = 0;    // previous state of pushbuttons (variable)

int o0 = 0;    // output 0
int o1 = 0;    // output 1
int i = 0;

int THRESH1;
int THRESH2;
int THRESH3;
int THRESH4;
int THRESH5;





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


  
      PTT_PTT0 = 0;    // program port T data register
      PTT_PTT1 = 0;
      DDRT = 0xFF;    // program port T for output mode
//  Define bar graph segment thresholds (THRESH1..THRESH5)
//  NOTE: These are binary fractions

      THRESH1 = 0x04;
      THRESH2 = 0x05;
      THRESH3 = 0x08;
      THRESH4 = 0x11;
      THRESH5 = 0x15;
      
      
//  Add RTI/interrupt initializations here

      ATDCTL2 = 0x80;
      ATDCTL3 = 0x10;
      ATDCTL4 = 0x85;
      ATDCTL5 = 0x10;
      ATDCTL2_AFFC = 1; 
      rticnt = 0;
      CRGINT = 0x80;
      RTICTL = 0x70;

}
	 		  			 		  		
 
// Main (non-terminating loop)
 
void main(void) {
	initializations(); 		  			 		  		
	EnableInterrupts;


  for(;;) {


// Main program loop (state machine)
// Start of main program-driven polling loop

	 	   			 		  			 		  		
//  If the "tenth second" flag is set, then
//    - clear the "tenth second" flag
//    - if "run/stop" flag is set, then
//       - initiate ATD coversion sequence
//       - apply thresholds to converted values
//       - determine 5-bit bar graph bit settings for each input channel
//       - transmit 10-bit data to external shift register
//    - endif
//  Endif

     
      if (tenthsec == TRUE){
          tenthsec = 0;
          if (runstp == TRUE) {
             ATDCTL5 = 0x10;  
             if (ATDDR0H > 0 && ATDDR0H < THRESH1) {
                o0 = 1;
             } else if (ATDDR0H > THRESH1 && ATDDR0H < THRESH2) {
                o0 = 2;
             } else if (ATDDR0H > THRESH2 && ATDDR0H < THRESH3) {
                o0 = 3;
             } else if (ATDDR0H > THRESH3 && ATDDR0H < THRESH4) {          
                o0 = 4;
             } else if (ATDDR0H > THRESH4)
                o0 = 5;
             } else{
                o0 = 0;
             }
             
            
             
             
             if (ATDDR1H > 0 && ATDDR1H < THRESH1) {
                o1 = 1;
             } else if (ATDDR1H > THRESH1 && ATDDR1H < THRESH2) {
                o1 = 2;
             } else if (ATDDR1H > THRESH2 && ATDDR1H < THRESH3) {
                o1 = 3;
             } else if (ATDDR1H > THRESH3 && ATDDR1H < THRESH4) {
                o1 = 4;
             } else if (ATDDR1H > THRESH4){
                o1 = 5;
             } else{
                o1 = 0;
             }
          
             
             for (i = 0; i <= 9; i++) {
                PTT_PTT4 = 0;
                  if (i < 5) {
                      if (o0 > 0){
                          o0--;
                          PTT_PTT3 = 1;
                      }else{
                        PTT_PTT3 = 0;
                      }
                  }else{
                      if (o1 > 0){
                          PTT_PTT3 = 1;
                          o1--;
                      }else{
                        PTT_PTT3 = 0;
                      }
                  }
                 PTT_PTT4 = 1;
             }
      
  }
                  
                      
                  
// Main program loop (state machine)
// Start of main program-driven polling loop

	 	   			 		  			 		  		

   
	 	   			 		  			 		  		
//  If the left pushbutton ("stop BGD") flag is set, then:
//    - clear the left pushbutton flag
//    - clear the "run/stop" flag (and "freeze" BGD)
//    - turn on left LED/turn off right LED (on docking module)
//  Endif

      if (leftpb == TRUE){
          leftpb = 0;
          runstp = 0;
          PTT_PTT0 = 0;   // left
          PTT_PTT1 = 1;
      }
          
        
        
   			 		  			 		  		

//  If the right pushbutton ("start BGD") flag is set, then
//    - clear the right pushbutton flag
//    - set the "run/stop" flag (enable BGD updates)
//    - turn off left LED/turn on right LED (on docking module)
//  Endif

      if (rghtpb == TRUE){
          rghtpb = 0;
          runstp = 1;
          PTT_PTT0 = 1;
          PTT_PTT1 = 0;
      }     
      

  } /* loop forever */
  
}  /* make sure that you never leave main */



// ***********************************************************************                       
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
 
interrupt 7 void rti_isr(void) {
CRGFLG = CRGFLG | 0x80; // clear RTI interrupt flag
 if(runstp) { // only bump rticnt if stopwatch is running
rticnt = (rticnt+1) % 10;
if(rticnt == 0) {tenthsec = 1;}
}

if(PORTAD0_PTAD7 == 0) { // check left pushbutton
if(prevpb == 1) {
leftpb = 1;
}
}
prevpb = PORTAD0_PTAD7;
if(PORTAD0_PTAD6 == 0) { // check right pushbutton
if(prevpb == 1) {
rghtpb = 1;
}
}
prevpb = PORTAD0_PTAD6;
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

