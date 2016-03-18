/***********************************************************************
; ECE 362 - Experiment 7 - Fall 2012                         
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
;***********************************************************************
;
; The objective of this lab is to implement a simple digital volt meter (DVM).  
; Using the RTI as a sampling time base, this turn-key application program will
; sample analog input channels 0 and 1 periodically (every 0.5 second), 
; convert the values read into 3-digit decimal numbers (N.NN), and update 
; the values displayed on the terminal screen, as follows:
;
;       Ch 0 = N.NN v   Ch 1 = N.NN v
;
; The right pushbutton will be used to start the DVM, and the left pushbutton
; will be used to stop the DVM.  The left LED will be illuminated when the
; DVM is stopped, and the right LED will be illuminated when the DVM is running.
;
; In addition to the text display of the values on the terminal screen, a set
; of three LEDs (YELLOW, GREEN, and RED) will be used to indicate the approximate
; range of the voltage input on each channel (0 and 1).  The YELLOW LED for a given
; channel should be illuminated if the input voltage on that channel is greater
; than THRESH1 but less than THRESH2.  The GREEN LED should be illuminated if the
; input voltage is greater than or equal to THRESH2 but less than THRESH3. The RED
; LED should be illuminated if the input voltage is greater than or equal to 
; THRESH3. The external LEDs will be interfaced to pins on Port T.
;
; IMPORTANT: Recall that the GREEN and YELLOW LEDs in your DK-1 parts kit are
; NON-RESISTOR LEDs, while the RED LEDs are RESISTOR LEDs. Carefully follow
; the schematic provided in the lab document.
;
;***********************************************************************/
#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

char inchar(void);
void outchar(char x);
void getATD();
void vdisp();
void ledbar0();
void ledbar1();

// ASCII character definitions
int CR = 0x0D;//Return                   
// THRESHOLD specifications (8-bit, unsigned) 	   			 		  			 		  		
int THRESH1  =   0x04;
int THRESH2  =   0x40;
int THRESH3  =   0xC0;
	 	   			 		  			 		  		

//  Variable declarations  	   			 		  			 		       
int halfsec = 0;  // half second flag
int leftpb = 0;   // left pushbutton flag
int rghtpb = 0;   // right pushbutton flag
int runstp = 0;    // run/stop flag                         
int rticnt = 0;    // RTICNT (variable)
int prevpbl = 0;    // previous state of pushbuttons (variable)
int prevpbr = 0;    // previous state of pushbuttons (variable)
	 	   		
/***********************************************************************
Initializations
***********************************************************************/
void initializations(void)
{

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
        ATDDIEN = 0xC0   ; //program PAD7 and PAD6 pins as digital inputs
        prevpbl = 1;      //initialize previous pushbutton state
        prevpbr = 1;  
//  Add additional port pin initializations here



/* Initialize the ATD to sample a D.C. input voltage (range: 0 to 5V)
; on Channels 0 and 1 (unsigned, 8-bit).  The ATD should be operated in 
; a program-driven (i.e., non-interrupt driven) fashion, sampling across 
; multiple channels with normal flag clear mode using nominal sample time 
; and clock prescaler values.
;                         
; Note: Vrh (the ATD reference high voltage) is connected to 5 VDC and
;       Vrl (the reference low voltage) is connected to GND on your kit.
*/
	 	   			 		  			 		  		
    DDRT = 0xFF; //enable all the pins!

//  Add RTI/interrupt initializations here

    RTICTL = 0x1A;
    CRGINT = CRGINT | 0x80;


    int sample0 =0;
    int sample1 =0;

    int ch0 =0;
    int ch1 = 0;


}
	 		  			 		  		
/***********************************************************************
Main
***********************************************************************/
void main(void) {
	initializations(); 		  			 		  		
	EnableInterrupts;


  for(;;) {


/*; Main program loop (state machine)
;
; Left pushbutton: stop DVM
; Right pushbutton: start DVM
; Left LED: on if DVM stopped
; Right LED: on if DVM running
;
; On-screen (and LED bar graph) displays should be updated every 0.5 second 
;   when "halfsec" flag set (and DVM is running)
*/
    
  if(halfsec ==1){
    halfsec =0;
    if(runstp ==1){
      getATD();
      vdisp();
      ledbar0();
      ledbar1();
    }
  }

  if(leftpb ==1 ){
    runstp =0;
    leftpb = 0;
    PTT_PTT0 =0;
    PTT_PTT1 =1;          
  }
   
  if(rghtpb == 1){
    runstp =1;
    rghtpb = 0;
    PTT_PTT0 =1;
    PTT_PTT1 =0;
  }
    
    _FEED_COP(); /* feeds the dog */
  } /* loop forever */
  /* please make sure that you never leave main */
}



/***********************************************************************
; ATD device driver routine: getatd
;
; This routine will initiate an ATD conversion on input Channels 0 and 1
; (by writing to register ATDCTL5), wait for the conversion of both to
; complete (by monitoring the SCF in register ATDSTAT), read the corresponding
; ATD result registers once the conversion completes, and return the
; converted analog sample for Channel 0 and Channel 1.
;***********************************************************************/
void getATD()
{
  int i = 0;

  ATDCTL5 = 0x20;

  while (ATDSTAT0_SCF ==0) i++;

  sample0 = ATDDR1H;


  i=0;

  ATDCTL5 = 0x21;

  while (ATDSTAT0_SCF ==0) i++;

  sample1 = ATDDR2H;

}

/***********************************************************************                       
; RTI interrupt service routine: rti_isr
;
; This routine keeps track of when 0.5 seconds worth of
; RTI interrupts has passed and sets the "halfsec" flag
;
; Also, samples state of pushbuttons and sets "leftpb" and
; "rghtpb" flags accordingly, as well as updates "prevpb"	   			 		  			 		  		
;***********************************************************************/
interrupt 7 void RTI_ISR( void)
{
  	// set CRGFLG bit 
  	CRGFLG = CRGFLG | 0x80; 
    rticnt++;
    if(rticnt >355) {
        rticnt =0;
        halfsec =1;
    }

    if (PTAD_PTAD7 == 0 & prevpbl == 1){ //left, reset clock
      leftpb =1;
    }
    prevpbl = PTAD_PTAD7;
    
    if(PTAD_PTAD6 == 0 & prevpbr == 1){
      rghtpb =1;
    }
    prevpbr = PTAD_PTAD6; 

}

/***********************************************************************                        
; Voltage conversion/display routine: vdisp
;
; This routine converts the 8-bit, unsigned sample passed to it 
; (range: $00-$FF) into a 3-digit decimal number (N.NN), ranging from 0.00 to 
; (approx.) 5.00 volts, which is then output to the terminal screen as a 
; four-character ASCII string (e.g., "3.92")  
;***********************************************************************/
void vdisp(void)
{

  ch0 = 100*sample0/51;
  ch1 = 100*sample1/51;

  outchar(CR);
  outchar("Ch 0 ");
  outchar((ch0/100)+30);
  outchar(".");
  outchar( ( (ch0 / 10) % 10) + 30);
  outchar(  (ch0 % 10) +30);
  outchar("v     ");

  outchar(CR);
  outchar("Ch 1 ");
  outchar((ch1/100)+30);
  outchar(".");
  outchar( ( (ch1 / 10) % 10) + 30);
  outchar(  (ch1 % 10) +30);
  outchar("v     ");

  //100/51 scalar
  //look at registers, take datas from atd registers. then multiply by scalar then convert to bcd


}

/***********************************************************************                       
; LED bar graph display routine for Channel 0: ledbar0
;
; This routine uses the 8-bit, unsigned sample passed to it 
; to update the Channel 0 bar-graph display as follows:
;
;  if THRESH1 <  (A) <  THRESH2,  then turn on YELLOW LED (PTT.2)
;  if THRESH2 <= (A) <  THRESH3,  then turn on GREEN LED  (PTT.3)
;  if THRESH3 <= (A),             then turn on RED LED    (PTT.4)
;***********************************************************************/
void ledbar0()
{
  if(THRESH1 < sample0 && sample0 < THRESH2){
    PTT_PTT2 = 0;
    PTT_PTT3 = 1;
    PTT_PTT4 = 1;
  }else if(THRESH2 <= sample0 && sample0 < THRESH3){
    PTT_PTT2 = 1;
    PTT_PTT3 = 0;
    PTT_PTT4 = 1;
  }else if(THRESH3 <= sample0){
    PTT_PTT2 = 1;
    PTT_PTT3 = 1;
    PTT_PTT4 = 0;
  }else{
    PTT_PTT2 = 1;
    PTT_PTT3 = 1;
    PTT_PTT4 = 1;
  }
}

/***********************************************************************                              
; LED bar graph display routine for Channel 1: ledbar1
;
; This routine uses the 8-bit, unsigned sample passed to it
; to update the Channel 1 bar-graph display as follows:
;
;  if THRESH1 <  (B) <  THRESH2,  then turn on YELLOW LED (PTT.5)
;  if THRESH2 <= (B) <  THRESH3,  then turn on GREEN LED  (PTT.6)
;  if THRESH3 <= (B),             then turn on RED LED    (PTT.7)
;***********************************************************************/
void ledbar1()
{
  if(THRESH1 < sample0 && sample0 < THRESH2){
    PTT_PTT5 = 0;
    PTT_PTT6 = 1;
    PTT_PTT7 = 1;
  }else if(THRESH2 <= sample0 && sample0 < THRESH3){
    PTT_PTT5 = 1;
    PTT_PTT6 = 0;
    PTT_PTT7 = 1;
  }else if(THRESH3 <= sample0){
    PTT_PTT5 = 1;
    PTT_PTT6 = 1;
    PTT_PTT7 = 0;
  }else{
    PTT_PTT5 = 1;
    PTT_PTT6 = 1;
    PTT_PTT7 = 1;
  }
}



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

