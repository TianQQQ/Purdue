/***********************************************************************
; ECE 362 - Experiment 8 - Fall 2012                         
;***********************************************************************
;	 	   			 		  			 		  		asdfasdfasdfasdfasd
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
*/

#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include <mc9s12c32.h>

#define RLed _PTT.Bits.PTT0
#define LLed _PTT.Bits.PTT1

// All funtions after main should be initialized here
char inchar(void);
void outchar(char ch);
void tdisp(void);
void shiftout(char n);
void lcdwait(void);
void send_byte(char n);
void send_i(char n);
void chgline(int pos);
void print_c(int c, int pos);
void pmsglcd(char * arr, int length, int startpos );
void NewPass();
void GetPass();
void outstr(char st[40]);
void NewTime();
void GetHour();
void GetMin();
void OutTime();                        //////////////////////////////

void CheckPass();                       ///////////////////////
void Log(short Entry);                  /////////////////////////

unsigned int TimeInSec();              //////////////////////////////
void SecInTime(unsigned int sec);                     //////////////////////////////
void DispLog();                       ////////////////////
void ClearLog();

void outstr(char st[40]);  

void CompDisplay();
void ServoWait();
void turn_lock(int direction);



//  Variable declarations  	   			 		  			 		       
int leftpb  = 0;  // left pushbutton flag
int rghtpb  = 0;  // right pushbutton flag
int prevpbl = 0;  // previous left pushbutton state
int prevpbr = 0;  // previous right pushbutton state
int tin     = 0;  // SCI transmit display buffer IN pointer
int tout    = 0;  // SCI transmit display buffer OUT pointer
int tsize   = 0;  // size of transmit buffer
int tbuf    = 0;  // SCI transmit display buffer
int RTICNT  = 0;  

int Password[6];  // Password Array

int setPass = 0;  // set new Password flag
int setTime = 0;  // set new time flag
int mscount = 0; //10 ms
int onesec   = 0; //one second 
int Time[6];      // Time Array 6 values corresponding to HH:MM:SS
unsigned int sec; // current time in seconds
int response =0;

unsigned int SysTime = 0;        //Current system time in seconds from 12:00 AM  
int TimeLog[10];      // Log of previous 10 access attempts and paired success or failure 
short EntryLog[10];                                
int HallInput = 0;  // Hall Effect Sensor Flag  
int Success = 0;    // Successful Entry Flag   

int locked = 0;   //Lock status
int menu = 0;     //If menu = 1 then connect to PC

//ASCII character definitions
int CR      = 0x0D;   //Return  
int LF      = 0x0A;   //Line feed 

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
         
// Initialize the SPI to 6.25 MHz

  DDRM   = 0xFF;
  SPICR1 = 0x50;
  SPICR2 = 0x00;
  SPIBR  = 0x01;

	 	   			 		  			 		  		
// Initialize digital I/O port pins
  DDRT = 0xDD; //Change back to E0!
  ATDDIEN = 0xFF;
  prevpbl = 1;  
  prevpbr = 1;  

  DDRAD = 0x00;
  DDRE = 0x00;

  INTCR_IRQEN = 0x00;

/* Initialize the LCD
 ; - pull LCDCLK high (idle) //ptt4
 ; - pull R/W' low (write state) //ptt3
 ; - turn on LCD (LCDON instruction)
 ; - enable two-line mode (TWOLINE instruction)
 ; - clear LCD (LCDCLR instruction)
 ; - wait for 2ms so that the LCD can wake up
*/

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

/*
 Initialize TIM Ch 7 (TC7) for periodic interrupts every 1.000 ms
;    Enable timer subsystem
;    Set channel 7 for output compare
;    Set appropriate pre-scale factor and enable counter reset after OC7
;    Set up channel 7 to generate 1 ms interrupt rate
;    Initially disable TIM Ch 7 interrupts
*/
  
  TSCR1 = 0x80;
  TSCR2 = 0x0C;
  TIOS  = 0x80;
  TIE   = 0x80;
  TC7   = 15000;

  MODRR = 0x01;    //PT0 used as PWM Ch 0 output
  PWME = 0x01;     //enable PWM Ch 0
  PWMPOL = 0x01;  //Set active high polarity
  PWMCTL = 0x00;  //no concatenate (8-bit)
  PWMCAE = 0x00;  //left-aligned output mode
  PWMPER0 = 0xEA;  //set 8 bit period to 234. Use 234 as max duty cycle.
  PWMDTY0 = 0x18;  //initialize duty cycle at 50%
  PWMPRCLK = 0x07; //prescale divide 24MHz by 128
  PWMSCLA = 0x08; //prescale clock SA divide by 8*2
  PWMCLK = 0x01;  //use clock SA for Ch 0


  //lock initilizitalations
  PTT_PTT6 = 0; //flash led
  PTT_PTT7 = 1; //power for latching sensors


 

}
	 		  			 		  		
/***********************************************************************
Main
***********************************************************************/
void main(void) {
  DisableInterrupts;
	initializations(); 		  			 		  		
	EnableInterrupts;

  

  while(1) {


  if(menu == 1){
    menu = 0;
    CompDisplay();
  }

   if(PORTAD0_PTAD3 == 1 || PORTAD0_PTAD4 == 1 || PORTAD0_PTAD5 == 1 || PORTAD0_PTAD0 == 1|| PORTAD0_PTAD1== 1 || PORTAD0_PTAD2 == 1 || PTT_PTT5 == 1 || PORTE_BIT1 == 1 || PORTE_BIT0 == 1)
   {
     HallInput = 1;
   }else{
      HallInput = 0;
   }

  if(HallInput == 1)  
  {                   
    CheckPass();  // will throw the "success" flag
    Log(Success);
  }
 
  if(SysTime == 0);
  {
   // ClearLog();
  }

  if(rghtpb == 1)
  {
       rghtpb = 0;
      if(locked == 1)
      {
        rghtpb = 0;
        turn_lock(0);
      }
      else if(locked == 0)
      {
        rghtpb = 0;
        turn_lock(1);
      }

  }

  tdisp();
   


    _FEED_COP(); /* feeds the dog */
  } /* loop forever */
  /* please make sure that you never leave main */
}

/***********************************************************************                       
  RTI interrupt service routine: RTI_ISR

  Initialized for 2.048 ms interrupt rate
  Samples state of pushbuttons (PAD7 = left, PAD6 = right)

  If change in state from "high" to "low" detected, set pushbutton flag
  leftpb (for PAD7 H -> L), rghtpb (for PAD6 H -> L)

***********************************************************************/

interrupt 7 void RTI_ISR(void)
{
  //set CRGFLG bit 
  CRGFLG = CRGFLG | 0x80; 

  
  if(RTICNT >71){
    RTICNT = 0;
  }
  RTICNT++;

  // if(prevpbl == 1 && PTAD_PTAD6 == 0) 
  //  {
     
  //     menu = 1;
  //  }
   
  //  if(prevpbr == 1 && PTAD_PTAD7 == 0) 
  //  {   
  //     rghtpb = 1;
  //  }
   
  //  prevpbl = PTAD_PTAD7;
  //  prevpbr = PTAD_PTAD6;


   if (PTAD_PTAD7 == 0 & prevpbl == 1){ //left, reset clock
      menu =1;
    }
    prevpbl = PTAD_PTAD7;
    
    if(PTAD_PTAD6 == 0 & prevpbr == 1){
      rghtpb =1;
    }
    prevpbr = PTAD_PTAD6; 


}

/***********************************************************************                       
  TIM interrupt service routine

  Initialized for 10.00 ms interrupt rate 			 		  			 		  		
***********************************************************************/

interrupt 15 void TIM_ISR(void)
{
  // set TFLG1 bit 
 	TFLG1 = TFLG1 | 0x80;

	mscount++;
	
	if(mscount == 100)
	{
	  mscount   = 0; 
    SysTime++;
    
	}

}

/***********************************************************************                              
;  tdisp: Display "RT = NNN ms" on the first line of the LCD and display 
;         an appropriate message on the second line depending on the 
;         speed of the reaction.  This routine should use the
;         "react" variable to determine which number and which message
;         to display.  pmsglcd will be useful for doing this.
;	  Convert react to ASCII before printing.	
;         
;         Also, this routine should set the green LED if the reaction 
;         time was less than 250 ms.
;
;         NOTE: The messages should be less than 16 characters since
;               the LCD is a 2x16 character LCD.
;***********************************************************************/
void tdisp()
{
  SecInTime(SysTime);
  pmsglcd("   ",3,LINE1);
  print_c(Time[0] + 0x30,0x83);
  print_c(Time[1] + 0x30,0x84);
  print_c(':',0x85);
  print_c(Time[2] + 0x30,0x86);
  print_c(Time[3] + 0x30,0x87);
  print_c(':',0x88);
  print_c(Time[4] + 0x30,0x89);
  print_c(Time[5] + 0x30,0x8A);
}


/***********************************************************************
Name:         turn_lock
Description:  Turns the servo 
              
************************************************************************/

void turn_lock(int direction)
{
  
  if(direction == 1) //lock
  {
    PWMDTY0 = 0x0C;
    ServoWait();
    locked = 1;
  }
  else if(direction == 0) //unlock
  {
    PWMDTY0 = 0x18;
    ServoWait();   
    locked = 0;
  }

  
}


/***********************************************************************
Name:         CompDisplay
Description:  Displays a set of options on the serial interface for
              the user
************************************************************************/
void CompDisplay()
{
  
  menu = 0;
  pmsglcd("   Menu Entry",13,LINE1);
  pmsglcd("  See computer!",14,LINE2);
  outchar(CR);
  outchar(LF);
  outchar(CR);
  outchar(LF);
  outstr("Welcome to Digijock Digilock computer terminal interface!");
  outchar(CR);
  outchar(LF);
  outstr("Current time is:");
  SecInTime(SysTime);
  OutTime();

  outchar(CR);
  outchar(LF);
  outstr("Please choose from the following options");
  outchar(CR);
  outchar(LF);
  outstr("1. Change Door password");
  outchar(CR);
  outchar(LF);
  outstr("2. Set Current Time");
  outchar(CR);
  outchar(LF);
  outstr("3. View door entries");
  outchar(CR);
  outchar(LF);

  response = inchar();
  outchar(response);
menu = 0;
  if(response == 0x31){
    NewPass();
  }else if(response == 0x32){
    NewTime();
  }else if (response == 0x33){
    DispLog();
  }else{
     outchar(CR);
      outchar(LF);
      outstr("Im sorry. That is not a valid entry. Please try again.");
      outchar(CR);
      outchar(LF);
  }
  send_i(LCDCLR);
}


/***********************************************************************
Name:         NewPass
Description:  Changes the Door "Password" to a new sequence defined by
              the user
************************************************************************/

void NewPass() 
{
  int i;   //generic counter
	int done = 0;   // done with password reset?
	char ans;       // user answer

	while(done == 0)   // while not done, continuously ask reset password
	{
	    outchar(CR);
	    outchar(LF);
	    outstr("Password Reset...");       //Prompt user for new password and 
	    outchar(CR);                       // get password from terminal input
	    outchar(LF);
	    outchar(CR);
	    outchar(LF);

	    outstr("Please Enter New Unlock Sequence:");
	    
	    GetPass();
	    
	    outchar(CR);
	    outchar(LF);
	    outstr("Is this correct (Y/N) ?:");     // Done?
	    
	    ans = inchar();
      outchar(ans);
	    
	    if(ans == 'y' || ans == 'Y')
	    {
	      done = 1;
        outchar(CR);
        outchar(LF);
        outstr("Password set!");
        outchar(CR);
        outchar(LF);

	    }
	        
	}
	for(i = 0; i < 6; i++)   //Conversion to decimal
    {
         Password[i] = Password[i] - 0x30;
    }
}

/***********************************************************************
Name:         GetPass
Description:  Reads the new password in from terminal input
************************************************************************/

void GetPass()
{

int i;   //generic counter
char in; //input character
int isNum = 0;  //input check... should be a digit 1-9


for(i = 0; i < 6; i++)  // password sequence will be of length 6
{
   isNum =0;
   while(isNum == 0)     // Loop until a valid input is recieved
   {
    
    outchar(CR);
    outchar(LF);
    outstr("Enter the next password value (1-9):");
    
    in = inchar();
    outchar(in);
    if(in >= 0x31 &&  in <= 0x39)     // this range corresponds to ASCII 1-9
    {
       isNum = 1;                     // set exit condition for valid input
    
    }
    
    else
    {
      outchar(CR);
      outchar(LF);
      outstr("Invalid value... Please try again.");      // try again
     
    }
    
   
   }
    Password[i] = in;      //Leave as ASCII for now to redisplay
  
}

outchar(CR);
outchar(LF);
outstr("New Password: ");
outchar(Password[0]);
outchar(Password[1]);
outchar(Password[2]);
outchar(Password[3]);
outchar(Password[4]);
outchar(Password[5]);

outchar(CR);
outchar(LF);

  
}

/***********************************************************************
Name:        CheckPass
Description: Accepts an entered sequence from external input and then 
             checks against the set password to allow or deny entry
************************************************************************/

/*
1  TL  AN3  PORTAD0_PTAD3 
2  TM  AN4  PORTAD0_PTAD4
3  TR  AN5  PORTAD0_PTAD5
4  ML  AN0  PORTAD0_PTAD0
5  MM  AN1  PORTAD0_PTAD1
6  MR  AN2  PORTAD0_PTAD2
7  BL  PT5  PORTE_BIT0
8  BM  PT6  PORTE_BIT1
9  BR  PT7  PTT_PTT5

*/

void CheckPass()
{ 
  int Attempt[6]={0,0,0,0,0,0}; //password attempt array
  int i = 0;    // generic counter
  int endtime = SysTime + 10;

  pmsglcd("Begin Entry!",12,LINE2);

 

  while(i < 6)// && SysTime < endtime)
  {

    if(PORTAD0_PTAD3 == 1 && Attempt[0] != 1 && Attempt[1] != 1 && Attempt[2] != 1 && Attempt[3] != 1 && Attempt[4] != 1 && Attempt[5] != 1)
    {
      Attempt[i] = 1;
      i++;
    }
    else if (PORTAD0_PTAD4 == 1 && Attempt[0] != 2 && Attempt[1] != 2 && Attempt[2] != 2 && Attempt[3] != 2 && Attempt[4] != 2 && Attempt[5] != 2)
    {
      Attempt[i] = 2;
      i++;
    }
    else if (PORTAD0_PTAD5 == 1 && Attempt[0] != 3 && Attempt[1] != 3 && Attempt[2] != 3 && Attempt[3] != 3 && Attempt[4] != 3 && Attempt[5] != 3)
    {
      Attempt[i] = 3;
      i++;
    }
    else if (PORTAD0_PTAD0 == 1 && Attempt[0] != 4 && Attempt[1] != 4 && Attempt[2] != 4 && Attempt[3] != 4 && Attempt[4] != 4 && Attempt[5] != 4)
    {
      Attempt[i] = 4;
      i++;
    }
    else if (PORTAD0_PTAD1 == 1 && Attempt[0] != 5 && Attempt[1] != 5 && Attempt[2] != 5 && Attempt[3] != 5 && Attempt[4] != 5 && Attempt[5] != 5)
    {
      Attempt[i] = 5;
      i++;
    }
    else if (PORTAD0_PTAD2 == 1 && Attempt[0] != 6 && Attempt[1] != 6 && Attempt[2] != 6 && Attempt[3] != 6 && Attempt[4] != 6 && Attempt[5] != 6)
    {
      Attempt[i] = 6;
      i++;
    }
    else if (PORTE_BIT0 == 1 && Attempt[0] != 7 && Attempt[1] != 7 && Attempt[2] != 7 && Attempt[3] != 7 && Attempt[4] != 7 && Attempt[5] != 7)
    {
      Attempt[i] = 7;
      i++;
    }
    else if (PORTE_BIT1 == 1 && Attempt[0] != 8 && Attempt[1] != 8 && Attempt[2] != 8 && Attempt[3] != 8 && Attempt[4] != 8 && Attempt[5] != 8)
    {
      Attempt[i] = 8;
      i++;
    }
    else if (PTT_PTT5 == 1 && Attempt[0] != 9 && Attempt[1] != 9 && Attempt[2] != 9 && Attempt[3] != 9 && Attempt[4] != 9 && Attempt[5] != 9)
    {
      Attempt[i] = 9;
      i++;
    }
  }


  if((Attempt[0] == Password[0]) && (Attempt[1] == Password[1]) && (Attempt[2] == Password[2]) && (Attempt[3] == Password[3]) && (Attempt[4] == Password[4]) && (Attempt[5] == Password[5])  )
  {
    pmsglcd("-Welcome  Back!-",16,LINE2);
    turn_lock(0);
    Success = 1;  //Correct Password
    PTT_PTT7 = 0;
    ServoWait();
    PTT_PTT7 = 1;
  }
  else
  {
    pmsglcd("-Access Denied!-",16,LINE2);
    turn_lock(1);
    PTT_PTT7 = 0;
    PTT_PTT6 = 0;
    ServoWait();
    PTT_PTT7 = 1;
    PTT_PTT6 = 1;
    ServoWait();
    PTT_PTT6 = 0;
    ServoWait();
    PTT_PTT6 = 1;
    ServoWait();
    PTT_PTT6 = 0;
  }
  
  send_i(LCDCLR);
  
}  


/***********************************************************************
Name:        NewTime
Description: Changes the current time to user specified value
************************************************************************/

void NewTime()
{
  
int done = 0;   // done with time reset?
char ans;       // user answer

while(done == 0)   // while not done, continuously ask to reset time
{
    outchar(CR);
    outchar(LF);
    outstr("Time Edit...");       //Prompt user for new password and 
    outchar(CR);                       // get password from terminal input
    outchar(LF);
    outchar(CR);
    outchar(LF);

    outstr("Please enter the current time: ");
    
    GetHour();
    GetMin();
    
    outchar(CR);
    outchar(LF);

    OutTime();

    outchar(CR);
    outchar(LF);
    outstr("Is this correct (Y/N) ?:");     // Done?
    
    ans = inchar();
    outchar(ans);
    TIE = 0x00;
    
    if(ans == 'y' || ans == 'Y')
    {
      done = 1;
      
      SysTime = TimeInSec();
      
      outchar(CR);
      outchar(LF);
      outstr("Time Set!");
      outchar(CR);
      outchar(LF);
    }
    TIE = 0x80;
  
  }
}

/***********************************************************************
Name:        GetHour
Description: Reads in an hour value from the terminal
************************************************************************/

void GetHour()
{
  

int check = 0;  //input check... check for appropriate times
   
   while(check == 0)     // Loop until a valid input is recieved
   {
    
    outchar(CR);
    outchar(LF);
    outstr("Hour: ");
    
    Time[0] = inchar() - 0x30;
    outchar(Time[0] + 0x30);
    Time[1] = inchar() - 0x30;  
    outchar(Time[1] + 0x30);
    
    if( ((Time[0]*10 + Time[1]) > 0) &&  ((Time[0]*10 + Time[1]) < 24))  //valid hour?
    {
      check = 1;
    }
    else
    {
      outchar(CR);
      outchar(LF);
      outstr("Invalid value... Please try again.");      // try again
    }
  
  }
}

/***********************************************************************
Name:        GetMin
Description: Reads in a minute value from the terminal
************************************************************************/

void GetMin()
{
 

int check = 0;  //input check... check for appropriate times
   
   while(check == 0)     // Loop until a valid input is recieved
   {
    
    outchar(CR);
    outchar(LF);
    outstr("Minute: ");
    
    Time[2] = inchar() - 0x30;
    outchar(Time[2] +  0x30);
    Time[3] = inchar() - 0x30;  
    outchar(Time[3] +  0x30);
    
    if( (Time[2]*10 + Time[3]) > 0 &&  (Time[2]*10 + Time[3]) < 60)  //valid min?
    {
      check = 1;
    }
    else
    {
      outchar(CR);
      outchar(LF);
      outstr("Invalid value... Please try again.");      // try again
    } 
  
  }
}

/***********************************************************************
Name:        OutTime
Description: Displays the time from the Time array to the terminal
************************************************************************/

void OutTime()
{
    outchar(Time[0] + 0x30);
    outchar(Time[1] + 0x30);
    outchar(':');
    outchar(Time[2] + 0x30);
    outchar(Time[3] + 0x30);
}

/***********************************************************************
Name:        TimeinSec
Description: Returns the current system time in seconds from 12:00 am
             based on the values in the Time array
************************************************************************/

unsigned int TimeInSec()   
{

unsigned int sec;

  
   sec = Time[0]*36000 + Time[1]*3600 + Time[2]*600 + Time[3]*60 + Time[4]*10 + Time[5];
   
   return sec;
  
  
}

/***********************************************************************             
Name:        SecInTime                                                              
Description: Returns the current system time in seconds from 12:00 am               
             based on the values in the Time array                                   
************************************************************************/                 

void SecInTime(unsigned int sec)
{

  Time[0] = sec / 36000;                      
  Time[1] = sec % 36000 / 3600;              
  Time[2] = sec % 36000 % 3600 / 600;          
  Time[3] = sec % 36000 % 3600 % 600 / 60;         
  Time[4] = sec % 36000 % 3600 % 600 % 60 / 10;       
  Time[5] = sec % 36000 % 3600 % 600 % 60 % 10;       

}


/***********************************************************************
Name:         LogTime()
Description:  Enters the current time into the time log
************************************************************************/
void Log(int entry)
{
  short i =9;  // generic counter


  for(i=9;i>=1;i--)
  {
    TimeLog[i] = TimeLog[i-1];
    EntryLog[i] = EntryLog[i-1];
  }

  TimeLog[0] = SysTime;
  EntryLog[0] = entry;

  Success = 0;

}

/***********************************************************************
Name:         ClearLog
Description:  Clears the log of previous access times
************************************************************************/

void ClearLog(){
  short i;  // generic counter

  for(i = 0; i < 10; i++)
  {
    TimeLog[i] = 0;
    EntryLog[i] = 0;
  }

}

/***********************************************************************
Name:         DispLog
Description:  Displays the last 
************************************************************************/

void DispLog()
{

short i=0;  // generic counter

  outchar(CR);
  outchar(LF);
  if(TimeLog[0] == 0)
  {
    outstr("There have been no attempted entries today.");
    outchar(CR);
    outchar(LF);
  }
  else
  {

    outchar(CR);
    outchar(LF);
    outstr("-- Today's Entry Log (Past 10 Attempts):-- ");

    while(TimeLog[i] != 0 && i < 10)
    {
        outchar(CR);
        outchar(LF);
        outchar(( i + 0x31));
        outstr(": ");

        SecInTime(TimeLog[i]);
        OutTime();

        outstr("  -  Successful?: ");

        if(EntryLog[i] == 1)
        {
          outchar('Y');
        }
        else
        {
          outchar('N');
        }
      i++;
    }

    
    outchar(CR);
    outchar(LF);

    outstr("Total Successful Entries: ");
    outchar(EntryLog[0] + EntryLog[1] + EntryLog[2] + EntryLog[3] + EntryLog[4] + EntryLog[5] + EntryLog[6] + EntryLog[7] + EntryLog[8] + EntryLog[9] + 0x30);


  }

}


/***********************************************************************                              
;  shiftout: Transmits the contents of register A to external shift 
;            register using the SPI.  It should shift MSB first.  
;             
;            MISO = PM[4]
;            SCK  = PM[5]
;***********************************************************************/
void shiftout(char n)
{
  PTT_PTT4 = 1;
  while(!SPISR_SPTEF);
  SPIDR = n;
  while(!SPISR_SPTEF);
  lcdwait();
  //lcdwait();
  PTT_PTT4 = 0;
  //lcdwait();
 // lcdwait();
  PTT_PTT4 = 1;
  //lcdwait();
}

/***********************************************************************                              
;  lcdwait: Delay for 3 ms
;***********************************************************************/
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

/***********************************************************************                              
;  ServoWait: Delay for 5 sec right now
;***********************************************************************/
void ServoWait()
{
  int n = 120;
  int m = 60000;
  while(n!=0){
    m = 60000;
    while(m!=0){
      m--;
    }
    n--;
  }
}


/***********************************************************************                              
;  send_byte: writes contents of register A to the LCD
;***********************************************************************/
void send_byte(char n)
{

  PTT_PTT2 = 1; 
  shiftout(n);

}
/***********************************************************************                              
;  send_i: Sends instruction passed in register A to LCD  
;***********************************************************************/
void send_i(char n)
{

  PTT_PTT2 = 0; 
  shiftout(n);

}

/***********************************************************************                        
;  chgline: Move LCD cursor to the cursor position passed in A
;  NOTE: Cursor positions are encoded in the LINE1/LINE2 variables
;***********************************************************************/
void chgline(int pos)
{
  send_i(CURMOV);
  send_i(pos);
}

/***********************************************************************                       
;  print_c: Print character passed in register A on LCD ,            
;***********************************************************************/
void print_c(int c, int pos)
{
  chgline(pos);
  send_byte(c);
}

/***********************************************************************                              
;  pmsglcd: pmsg, now for the LCD! Expect characters to be passed
;           by call.  Registers should return unmodified.  Should use
;           print_c to print characters.  
;***********************************************************************/
void pmsglcd(char * arr, int length, int startpos )
{
  int i =0;
  for(i=0; i< length; i++){
    print_c(arr[i],startpos+i);
  }
}

/***********************************************************************
Name:         outstr
Description:  Outputs the specified character string to the terminal
************************************************************************/

void outstr(char st[40]){

int i = 0;  // generic counter
  while(st[i] != 0x00){
    outchar(st[i]);
    i++;
  }
  
}

/***********************************************************************
; Character I/O Library Routines for 9S12C32
;***********************************************************************
; Name:         inchar
; Description:  inputs ASCII character from SCI serial port and returns it
; Example:      char ch1 = inchar();
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
; Example:      outchar('x');
;***********************************************************************/
void outchar(char ch) {
  /* sends a character to the terminal channel */
    while (!(SCISR1 & 0x80));  /* wait for output buffer empty */
    SCIDRL = ch;
}