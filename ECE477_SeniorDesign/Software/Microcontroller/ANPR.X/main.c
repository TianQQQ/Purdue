/*
 * File:   main.c
 * Author: Lzh
 *
 * Created on October 16, 2016, 3:13 PM
 */







#include "xc.h"
#include "p24FJ128GA010.h"

#define INST_SIZE 15

#define SCK2 LATGbits.LATG8
#define SDO2 LATGbits.LATG7
//#define SDI2 PORTDbits.PORTD6
#define LED1_CLOCK LATGbits.LATG9
#define LED2_CLOCK LATGbits.LATG6
#define CS2 LATDbits.LATD7

int CAPITAL_LED[26] = {0b1110010111000001,//A
                       0b1110110000101101,//B
                       0b0010010101100100,//C
                       0b0110110000101101,//D
                       0b1010010111100100,//E
                       0b1010010111000000,//F
                       0b1010010101100101,//G
                       0b1100000111000001,//H
                       0b0010110000101100,//I
                       0b0100000001100101,//J
                       0b0001000111000010,//K
                       0b0000000101100100,//L
                       0b0101001101000001,//M
                       0b0100001101000011,//N
                       0b0110010101100101,//O
                       0b1110010111000000,//P
                       0b0110010101100111,//Q
                       0b1110010111000010,//R
                       0b1010010110100101,//S
                       0b0010110000001000,//T
                       0b0100000101100101,//U
                       0b0001000101010000,//V
                       0b0100000101010011,//W
                       0b0001001000010010,//X
                       0b0001001000001000,//Y
                       0b0011010000110100};//Z

int PLATE_DIGIT_LED[10] = {0b0111010101110101,//0
                     0b0101000000000001,//1
                     0b1110010011100100,//2
                     0b1110010000100101,//3
                     0b1100000110000001,//4
                     0b0010010110100110,//5
                     0b1010010111100101,//6
                     0b0110010100000001,//7
                     0b1110010111100101,//8
                     0b1110010110100101};//9

int DIGIT_LED[10] = {0b0110010101100101,//0
                     0b0101000000000001,//1
                     0b1110010011100100,//2
                     0b1110010000100101,//3
                     0b1100000110000001,//4
                     0b1010010110100101,//5
                     0b1010010111100101,//6
                     0b0110010100000001,//7
                     0b1110010111100101,//8
                     0b1110010110100101};//9
                     
                  
                     

//_CONFIG2(0xF9FC);
//_CONFIG1(0x377F);
int j = 0;
int k = 0;
int adc_index = 0;
int space_left = 0;
int lock = 0;
int lock2 = 0;

int DETECT_LEN = 5;
int DETECT_THRESH = 2;
int adc_3_detect = 0;
int adc_3_undetect = 0;
int adc_3_timer = 0;
int adc_3_car_send = 0;
int adc_4_detect = 0;
int adc_4_undetect = 0;
int adc_4_timer = 0;
int adc_4_car_send = 0;


int previous_RD13 = 0;
int direction1 = 0;
int start_timer;
int pwm_count;

int direction2 = 0;
int start_timer2;
int pwm_count2;

unsigned char SPI_string[INST_SIZE];
int SPI_in_index = 0;




void IntInit(void);
void InitializeTimer2For_PWM();
void Init_PWM1();
void Init_PWM2();
void Init_PWM3();
void Init_PWM4();
void SetDutyCycle1_PWM(unsigned int);
void SetDutyCycle2_PWM(unsigned int);
void SetDutyCycle3_PWM(unsigned int);
void SetDutyCycle4_PWM(unsigned int);
void SPIsetup1ForSlaveMode();
void SPI2Init();
int readADC(int);
void writeSPI2(unsigned int arr[], int type);
void ADCInit();
//void writeSPI2(unsigned int);
void word_to_array(unsigned int * arr, char char1, char char2, char char3, char char4, char char5, char char6);
unsigned int convert_char(char charactor);

unsigned int DutyCycle = 0x2FFF;
unsigned int arr[6];
unsigned int arr2[6];
unsigned int arr_print[16];

int main(void) {
    //AD1PCFG	 =	0b1111110000111111;	 // AN6,7,8,9 Analog input
    //AD1CSSL = 0;        // no scanning required 
    //AD1CON3 = 0x1F02;   // max sample time = 31Tad, Tad = 2 x Tcy = 125ns >75ns
    //AD1CON2 = 0;        // use MUXA, AVss and AVdd are used as Vref+/-
    //AD1CON1bits.ADON = 1; // turn on the ADC;
    //INTCON2.INT2EP = 1; 
    //IFS0.U1RX = 2;
    //int j = 0;
   
    TRISA    =  0x0000;
    //TRISB	 =	0b0000001111000000;	 //6,7,8,9 as input
    TRISB    =  0xFFFF;
    TRISC	 =	0x0000;	 //configure all PortC as OUTput,
    TRISD    =  0B0010000001000000;
    TRISF    =  0xFFFF;
    TRISG    =  0x0000;

    lock = 0;
    lock2 = 0;
    
    previous_RD13 = 0;
    start_timer = 0;
    pwm_count = 0;
    direction1 = 0;
    start_timer2 = 0;
    pwm_count2 = 0;
    direction2 = 0;
    
    adc_index = 0;
    
    adc_3_detect = 0;
    adc_3_undetect = 0;
    adc_3_timer = 0;
    adc_3_car_send = 0;
    
    adc_4_detect = 0;
    adc_4_undetect = 0;
    adc_4_timer = 0;
    adc_4_car_send = 0;
    
    space_left = 4;
            
    //enable hbridge
    LATDbits.LATD8 = 1;
    LATDbits.LATD9 = 1;
    
    InitializeTimer2For_PWM();
    Init_PWM1();
    Init_PWM2();
    Init_PWM3();
    Init_PWM4();
    SetDutyCycle1_PWM(0);
    SetDutyCycle2_PWM(0);
    SetDutyCycle3_PWM(0);
    SetDutyCycle4_PWM(0);
    //ADCInit();
    AD1PCFGbits.PCFG3 = 1;  //enable digital input on ANx
    AD1PCFGbits.PCFG4 = 1;  //enable digital input on ANx
    AD1PCFGbits.PCFG8 = 1;  //enable digital input on ANx
    AD1PCFGbits.PCFG9 = 1;  //enable digital input on ANx
    
    IntInit();
    
    LED1_CLOCK = 0;
    LED2_CLOCK = 0;
    //SPI2CON1bits.DISSDO		= 1;
    
     //AD1CHSbits.CH0SA = 6;               // select analog input channel AN0
     //AD1CON1bits.SAMP = 1;       // start sampling, automatic conversion will follow
     //while (AD1CON1bits.DONE);   // wait to complete sample
     //while (!AD1CON1bits.DONE);   // wait to complete the conversion
     //int ain = ADC1BUF0;            // read the conversion result 
    //RPINR18bits.U1RXR	 =	2;	 //UART1 receive set to RB2/RP2
    //RPOR1bits.RP3R	 =	3;	 //UART1 transmit set to RB3/RP3
    
    
    //SPI Slave
    // <editor-fold defaultstate="collapsed" desc="comment">
    SPIsetup1ForSlaveMode();
    //SPIsetup2ForMasterMode();
    //SPI2Init();
    
    //LATDbits.LATD7 = 1; 
    //0b1110010111000001
    //writeSPI2(0b1110010111000001);
    //writeSPI2(0b1110010111000001);
    
    //unsigned int arr[6] = {CAPITAL_LED['H' - 'A'],CAPITAL_LED['H' - 'A'], CAPITAL_LED['E' - 'A'], CAPITAL_LED['L' - 'A'], CAPITAL_LED['L' - 'A'],CAPITAL_LED['O' - 'A']};
    //unsigned int arr[6] = [0xFF,OxFF,OxFF,OxFF,OxFF,OxFF]
    
    //writeSPI2(arr);
    int temp = 1;
    //LED1_CLOCK = 1;
    
    word_to_array(arr2,'Q','Q','Q','Q','Q','Q');
    writeSPI2(arr2, 2);
    
    //display_spaceleft(2);
    //display_spaceleft(1);
    //word_to_array(arr, 0,0, 0, 'B', 'Y', 'E');
    //writeSPI2(arr,1);
              
    //start_timer = 1;
    //direction1 = 1;
    
    while(1)
    {
            
    
    
        long x;
        for (j=0; j<=35; j+=1)	// a simple delay
        {
            //append_to_array(arr2, j);
            //writeSPI2(arr2,2);
            //writeSPI2(CAPITAL_LED[j]);
            
            //writeSPI2(CAPITAL_LED[j-1]);
            //writeSPI2(CAPITAL_LED[j-1]);
            //start_timer = 1;
            //writeSPI2(temp << j);
            //start_timer = 1;
            //display_spaceleft(1);
            //display_spaceleft(2);
            //word_to_array(arr2,0,0,0,0,0,'Q');
            //writeSPI2(arr2, 2);
            //for(x = 0; x < 0x1ffff; x++);
        }
        //arr[5] = arr[5] << 1;
        //word_to_array(arr, 0,0, 'T', 'H', 'U', 'G');
        //writeSPI2(arr);
        //for(x = 0; x < 0x2ffff; x++);
        /*word_to_array(arr, 0,0, 'L', 'I', 'F', 'E');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0,0, 0, 0, 'I', 'S');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0,0, 0, 0, 'S', 'O');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0,0, 'H', 'A', 'R', 'D');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);*/
        /*word_to_array(arr, 0, 0, 'N', 'I', 'C', 'E');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0, 0, 0, 0, 'T', 'O');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0, 0, 'M', 'E', 'E', 'T');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        word_to_array(arr, 0, 0, 0, 'Y', 'O', 'U');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        
        word_to_array(arr, '0', '1', '2', '3', '4', '5');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        
        word_to_array(arr, '6', '7', '8', '9', '9', '9');
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);
        */
        //writeSPI2(0x0701);
        
        
        /*append_to_array(arr, 0);
        writeSPI2(arr);
        for(x = 0; x < 0x2ffff; x++);*/
        //writeSPI2(0x264D);
        //I2Cwrite(0xffff, 0xffff, 0xffff);
        
        //LATA = PORTA & (0x0040 ^ 0xffff);
        //writeSPI2(0b0100000000001010);
        //writeSPI2(0x0701);
    }
}

void word_to_array(unsigned int * arr, char char1, char char2, char char3, char char4, char char5, char char6)
{
    //while(lock == 1);
    //lock = 1;
    
    arr[0] = convert_char(char1);
    arr[1] = convert_char(char2);
    arr[2] = convert_char(char3);
    arr[3] = convert_char(char4);
    arr[4] = convert_char(char5);
    arr[5] = convert_char(char6);
    //lock = 0;
}

void append_to_array(unsigned int * arr, unsigned char char1)
{
    //while(lock == 1);
    //lock = 1;
    
    int i;
    for(i = 0;i <= 4; i++)
    {
        arr[i] = arr[i+1];
    }
    
   if (char1 >=0 && char1 <= 25)
   {
       arr[5] = CAPITAL_LED[char1];
   }
   else if (char1 >=26 && char1 <= 36)
   {
       arr[5] = PLATE_DIGIT_LED[char1 - 26];
   }
    
    //lock = 0;
}

unsigned int convert_char(char charactor)
{
    if(charactor >= 65 && charactor <= 90)
    {
        return(CAPITAL_LED[charactor - 'A']);
    }
    
    if(charactor >= 48 && charactor <= 57)
    {
        return(DIGIT_LED[charactor - '0']);
    }
    
    return 0;
}


void SPIsetup1ForSlaveMode()
{
    IFS0bits.SPI1IF = 0; // Clear the Interrupt flag
    IEC0bits.SPI1IE = 0; // Disable the interrupt
    
    // SPI1CON1 Register Settings
    SPI1STATbits.SPIEN  = 0; // Disable SPI module
    SPI1CON1bits.DISSCK = 0; // Internal serial clock is enabled
    SPI1CON1bits.DISSDO = 0; // SDOx pin is controlled by the module
    SPI1CON1bits.MODE16 = 0;// Communication is byte-wide (8 bits)
    SPI1CON1bits.SMP = 0; // Input data is sampled at the middle of data output time
    SPI1CON1bits.CKE = 0; // Serial output data changes on transition from Idle clock state to active clock state
    SPI1CON1bits.SSEN = 0; 
    SPI1CON1bits.CKP = 0; // Idle state for clock is a low level;
    SPI1CON1bits.MSTEN = 0; // Slave mode enabled
    
    // Idle clock state to active clock state
    
    // active state is a high level
    SPI1STATbits.SPIEN = 1; // Enable SPI module
    SPI1STATbits.SPIROV = 0 ; //Clear the SPIROV bit




    // Interrupt Controller Settings
    IFS0bits.SPI1IF = 0; // Clear the Interrupt flag
    IEC0bits.SPI1IE = 1; // Enable the interrupt
}


void display_spaceleft(int type)
{
    if(type == 1)
    {
        word_to_array(arr, space_left + '0', 0, 'L', 'E', 'F', 'T');
        writeSPI2(arr,1);
    }
    if(type == 2)
    {
        word_to_array(arr2, space_left + '0', 0, 'L', 'E', 'F', 'T');
        writeSPI2(arr2,2);
    }
}









void __attribute__((interrupt,no_auto_psv)) _SPI1Interrupt(void)
{
   int i;
   IFS0bits.SPI1IF = 0;     //Clear Interrupt status of SPI1
   
   unsigned char recvData = SPI1BUF;
   
   LATAbits.LATA7 = LATAbits.LATA7 ^ 1; 
   
   if (recvData >= 0 && recvData <= 36)
   {
       append_to_array(arr, recvData);
       writeSPI2(arr,1);
   }
   /*if (recvData == 0xff)
   {
        word_to_array(arr, 'W', 'H', 'A', 'T', 0, 0);
       writeSPI2(arr,1);
   }*/
   /*if(recvData == 0xf)
   {
       word_to_array(arr, 'P', 'E', '9', '2', '8', '3');
       writeSPI2(arr);
   }*/
   
   /*
   if(recvData == 0xFE)
   {
       
       //SPI_in_index = 0;
       LATAbits.LATA7 = LATAbits.LATA7 ^ 1; 
       start_timer = 1;
   }
   else if (recvData == 0xFF)
   {
                  
       SPI_string[SPI_in_index] = 0xFF;
       //process

       
       switch (SPI_string[0]){
       case 0xc9:
           //LATAbits.LATA7 = 1; 
           if(SPI_string[1] == '1')
           {
               start_timer = 1;
           }
           
           if(SPI_string[1] == '0')
           {
               start_timer2 = 1;
           }
           break;
        }
   }
   else if (SPI_in_index > INST_SIZE - 2)
   {
       //overflow
   }
   else
   {
       SPI_string[SPI_in_index++] = recvData;
   }
   
   */
   
}




void SPIsetup2ForMasterMode()
{
    IFS2bits.SPI2IF = 0; // Clear the Interrupt flag
    IEC2bits.SPI2IE = 0; // Disable the interrupt




    // SPI1CON1 Register Settings
    SPI2STATbits.SPIEN  = 0; // Disable SPI module
    SPI2CON1bits.DISSCK = 0; // Internal serial clock is enabled
    SPI2CON1bits.DISSDO = 0; // SDOx pin is controlled by the module
    SPI2CON1bits.MODE16 = 0; // Communication is word-wide (16 bits)




    SPI2CON1bits.MSTEN = 1; // Master mode enabled
    SPI2CON1bits.SMP = 0; // Input data is sampled at the middle of data output time
    SPI2CON1bits.CKE = 0; // Serial output data changes on transition from Idle clock state to active clock state




    // Idle clock state to active clock state
    SPI2CON1bits.CKP = 0; // Idle state for clock is a low level;




    // active state is a high level
    SPI2STATbits.SPIEN = 1; // Enable SPI module
    SPI2STATbits.SPIROV = 0 ; // Clear the SPIROV bit !




    // Interrupt Controller Settings
    IFS2bits.SPI2IF = 0; // Clear the Interrupt flag
    IEC2bits.SPI2IE = 1; // Enable the interrupt
}




void writeSPI2(unsigned int arr[] , int type)
{
    //while(lock == 1);
    
   // lock = 1;
    
    int i, j;
    char temp;
    
    if(type == 1)
    {
        arr_print[10] = arr[0];
        arr_print[11] = arr[1];
        arr_print[12] = arr[2];
        arr_print[13] = arr[3];
        arr_print[14] = arr[4];
        arr_print[15] = arr[5];
    }
    if(type == 2)
    {
        arr_print[0] = arr[5];
        arr_print[1] = arr[4];
        arr_print[2] = arr[3];
        arr_print[3] = arr[2];
        arr_print[4] = arr[1];
        arr_print[5] = arr[0];
    }
    for(i = 0; i <= 15; i++)
    {
        if(type == 1)
            LED1_CLOCK = 0;
        if(type == 2)
            LED2_CLOCK = 0;
        
        for(j = 0; j <= 15; j++)
        {
            SCK2 = 0;
            SDO2 = ((arr_print[j] & ( 1 << i )) >> i)? 1 : 0;
            SDO2 ^= 1;
            SCK2 = 1;
        }
        /*
        SCK2 = 0;
        SDO2 = ((arr[0] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        
        SCK2 = 0;
        SDO2 = ((arr[1] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        
        SCK2 = 0;
        SDO2 = ((arr[2] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        
        SCK2 = 0;
        SDO2 = ((arr[3] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        
        SCK2 = 0;
        SDO2 = ((arr[4] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        
        SCK2 = 0;
        SDO2 = ((arr[5] & ( 1 << i )) >> i)? 1 : 0;
        SDO2 ^= 1;
        SCK2 = 1;
        */
        if(type == 1)
            LED1_CLOCK = 1;
        if(type == 2)
            LED2_CLOCK = 1;
    }


    
            
   // lock = 0;
    //LATA = PORTA ^ 0x0040;
}//writeSPI2




void InitializeTimer2For_PWM(void)
{
 
 T2CONbits.TON = 0; // Timer off 
 T2CONbits.TCS = 0;
 T2CONbits.TGATE = 0;
 T2CONbits.TCKPS = 0b00;
 TMR2 = 0x00; // Prescale Value 
 PR2 = 0x7FFF; // Set PWM Period
 T2CONbits.TON = 1; // Timer 2 on
}




void Init_PWM1(void)
{
 OC1CONbits.OCM = 0b000; // Clear whatever values are in 
 OC1R = 0x0F;
 OC1RS = 0x0F;
 OC1CONbits.OCTSEL = 0;
 OC1R = 0x0F;
 OC1CONbits.OCM = 0b110;
}




void Init_PWM2(void)
{
 OC2CONbits.OCM = 0b000; // Clear whatever values are in 
 OC2R = 0x0F;
 OC2RS = 0x0F;
 OC2CONbits.OCTSEL = 0;
 OC2R = 0x0F;
 OC2CONbits.OCM = 0b110;
}




void Init_PWM3(void)
{
 OC3CONbits.OCM = 0b000; // Clear whatever values are in 
 OC3R = 0x0F;
 OC3RS = 0x0F;
 OC3CONbits.OCTSEL = 0;
 OC3R = 0x0F;
 OC3CONbits.OCM = 0b110;
}




void Init_PWM4(void)
{
 OC4CONbits.OCM = 0b000; // Clear whatever values are in 
 OC4R = 0x0F;
 OC4RS = 0x0F;
 OC4CONbits.OCTSEL = 0;
 OC4R = 0x0F;
 OC4CONbits.OCM = 0b110;
}




void SetDutyCycle1_PWM(unsigned int DutyCycle)
{
 OC1RS = DutyCycle;
}


void SetDutyCycle2_PWM(unsigned int DutyCycle)
{
 OC2RS = DutyCycle;
}


void SetDutyCycle3_PWM(unsigned int DutyCycle)
{
 OC3RS = DutyCycle;
}


void SetDutyCycle4_PWM(unsigned int DutyCycle)
{
 OC4RS = DutyCycle;
}




void IntInit(void)
{ 
//   INTCON2 = 0x0000;   /*Setup INT0, INT1, INT2, interupt on falling edge*/
//   IFS1bits.INT1IF = 0;    /*Reset INT1 interrupt flag */
//   IEC1bits.INT1IE = 1;    /*Enable INT1 Interrupt Service Routine */
//   IPC5bits.INT1IP = 1;	/*set low priority*/ 
   
   IEC0bits.T1IE = 1;
   IPC0bits.T1IP = 1;
   T1CONbits.TON = 1;
   T1CONbits.TCKPS = 1;
   
}


void __attribute__((__interrupt__, __auto_psv__)) _T1Interrupt(void)
{
    // Clear Timer 1 interrupt flag
    _T1IF = 0;
    long k = 0;
    
    //micro status led test
    //LATAbits.LATA7 = PORTAbits.RA7 ^ 1; 

    /*if(!PORTDbits.RD13 && previous_RD13)
    {
        if(!start_timer)
        {
            start_timer = 1;
        }
    }*/
    
    if(start_timer)
    {
        pwm_count += 1;
        
        if(direction1)
        {
            SetDutyCycle1_PWM(DutyCycle);
        }
        else
        {
            SetDutyCycle2_PWM(DutyCycle);
        }
        //LATA = LATA | 0x0080;
    }
    else
    {
        SetDutyCycle1_PWM(0);
        SetDutyCycle2_PWM(0);
        
        //LATA = LATA & 0xFF7F;
    }
    
    if(pwm_count == 14 && direction1 == 1)
    {
        pwm_count = 0;
        start_timer = 0;
        
        direction1 ^= 1;
    }
    
    if(pwm_count == 8 && direction1 == 0)
    {
        pwm_count = 0;
        start_timer = 0;
        
        direction1 ^= 1;
    }
    
    //previous_RD13 = PORTDbits.RD13;
    
    /*---------------------------------------------*/  
    
    /*if(!PORTDbits.RD13 && previous_RD13)
    {
        if(!start_timer)
        {
            start_timer = 1;
        }
    }*/
    
    if(start_timer2)
    {
        pwm_count2 += 1;
        
        if(direction2)
        {
            SetDutyCycle3_PWM(DutyCycle);
        }
        else
        {
            SetDutyCycle4_PWM(DutyCycle);
        }
    }
    else
    {
        SetDutyCycle3_PWM(0);
        SetDutyCycle4_PWM(0);
        //LATA = LATA & 0xFF7F;
    }
    
    if(pwm_count2 == 6 && direction2 == 0)
    {
        pwm_count2 = 0;
        start_timer2 = 0;
        
        //SetDutyCycle3_PWM(DutyCycle);
        //for(k = 0; k<0x1ffff;k++);
        //SetDutyCycle3_PWM(0);
        direction2 ^= 1;
    }
    
    if(pwm_count2 == 13 && direction2 == 1)
    {
        pwm_count2 = 0;
        start_timer2 = 0;
        
        direction2 ^= 1;
    }
        
        LATA = PORTA ^ 0x0040;
    
        /*if(PORTBbits.RB3 == 1)
        {
            //word_to_array(arr, 0,0, 'T', 'E', 'S', 'T');
            //writeSPI2(arr,1);
            
        }
        else
        {
            //word_to_array(arr, 0,0, 'T', 'E', 'S', 'T');
            //writeSPI2(arr,1);
        }*/
        
        adc_3_timer++;
        
        if(PORTBbits.RB3 == 1)
        {
            adc_3_undetect++;
        }
        else
        {
            adc_3_detect++;    
        }
        
        if(adc_3_timer >= DETECT_LEN)
        {
            if(adc_3_detect >= DETECT_THRESH)
            {
                if(adc_3_car_send == 0)
                {
                    
                        word_to_array(arr, 0, 0, 0, 'B', 'Y', 'E');
                        writeSPI2(arr,1);
                    
                        adc_3_car_send = 1;

                        space_left++;
                        display_spaceleft(2);
                        
                        adc_3_car_send = 1;
                        LATAbits.LATA3 = 0;
                        LATAbits.LATA3 = 1;
                        for(k = 0;k < 0xff; k++);
                        LATAbits.LATA3 = 0;
                        
                        direction2 = 1;
                        start_timer2 = 1;
                        
                }
            }
            else if (adc_3_undetect >= DETECT_LEN)
            {
                if(adc_3_car_send == 1)
                {
                    adc_3_car_send = 0;
                    word_to_array(arr, 0, 0, 0, 0, 0, 0);
                    writeSPI2(arr,1);
                    
                    start_timer2 = 1;
                }
                
                
            }
            adc_3_detect = 0;
            adc_3_undetect = 0;
            adc_3_timer = 0;

        }
        
        
        adc_4_timer++;
        
        if(PORTBbits.RB4 == 1)
        {
            adc_4_undetect++;
        }
        else
        {
            adc_4_detect++;    
        }
        
        if(adc_4_timer >= DETECT_LEN)
        {
            if(adc_4_detect >= DETECT_THRESH)
            {
                if(adc_4_car_send == 0)
                {
                    if(space_left == 0)
                    {
                        word_to_array(arr2, 0, 0, 'F', 'U', 'L', 'L');
                        writeSPI2(arr2,2);
                    }
                    else
                    {
                        word_to_array(arr2, 0,'H', 'E', 'L', 'L', 'O');
                        writeSPI2(arr2,2);
                        
                        direction1 = 1;
                        start_timer = 1;
                    
                        adc_4_car_send = 1;
                        LATAbits.LATA2 = 0;
                        LATAbits.LATA2 = 1;
                        for(k = 0;k < 0xff; k++);
                        LATAbits.LATA2 = 0;
                    
                        space_left--;
                    }
                }
            }
            else if (adc_4_undetect >= DETECT_LEN)
            {
                if(adc_4_car_send == 1)
                {
                    adc_4_car_send = 0;
                    
                    if(space_left == 0)
                    {
                        word_to_array(arr2, 0, 0, 'F', 'U', 'L', 'L');
                        writeSPI2(arr2,2);
                    }
                    else
                    {
                        word_to_array(arr2, space_left + '0', 0, 'L', 'E', 'F', 'T');
                        writeSPI2(arr2,2);
                        display_spaceleft(2);
                        start_timer = 1;
                    }
                }
                
                
            }
            adc_4_detect = 0;
            adc_4_undetect = 0;
            adc_4_timer = 0;

        }
        
        
        
    //LATA = LATA & 0xFFF0;
    //LATA = LATA ^ 0x000F;
    //LATB = LATB ^ 0x00FF;
    //LATC = LATC ^ 0x00FF;
    
    // Toggle LED
    //AD1CON1bits.SAMP = 1;       // start sampling, automatic conversion will follow
    //AD1CON1bits.ADON = 1;
    //while (!AD1CON1bits.DONE);   // wait to complete the conversion
    //unsigned int ain = (ADC1BUF0 / 1024.0) * 3300;          // read the conversion result 
    //if(adc_index == 0)
    //{
        /*adc_3_timer++;
        if(readADC(3) < 3100)
        {
            adc_3_detect++;
            //word_to_array(arr, 0, 'C', 'A', 'R', '3', 'X');
            //writeSPI2(arr);
        }
        else
        {
            adc_3_undetect++;
            //word_to_array(arr, 0,0, 0, 0, 0, 0);
            //writeSPI2(arr);
        }
        
        if(adc_3_timer >= 5)
        {
            //word_to_array(arr, 0,0, 'T', 'O', 'U', 'T');
            //writeSPI2(arr);
            if(adc_3_detect >= 2)
            {
                //word_to_array(arr, 0,0, 'C', 'A', 'R', '3');
                //writeSPI2(arr);
                LATAbits.LATA2 = 1;
            }
            else if (adc_3_undetect >= 5)
            {
                //LATAbits.LATA2 = 0;
                //word_to_array(arr, 0,0, 0, 'N', 'O', '3');
                //writeSPI2(arr);
            }
            
            adc_3_timer = 0;
            adc_3_detect = 0;
            adc_3_undetect = 0;
        }
        
        //adc_index++;
    //}
    //else if(adc_index == 1)
    //{
        //if(readADC(4) < 3100)
        {
        //word_to_array(arr, 0,0, 'C', 'A', 'R', '4');
        //writeSPI2(arr);
        }
        else
        {
        //word_to_array(arr, 0,0, 0, 0, 'N', 'O');
        //writeSPI2(arr);
        }
        adc_index++;
    //}
        
        //adc_index = adc_index == 2? 0:adc_index;
    //else if(adc_index == 2)
    //{
        if(readADC(8) < 3100)
        {
        //word_to_array(arr, 0,0, 0, 'C', 'A', 'R');
        //writeSPI2(arr);
        }
        else
        {
        //word_to_array(arr, 0,0, 0, 0, 'N', 'O');
        //writeSPI2(arr);
        }
        
       // adc_index++;
    //}
    
    //else if(adc_index == 3)
    //{
        if(readADC(9) < 3100)
        {
        //word_to_array(arr, 0,0, 0, 'C', 'A', 'R');
        //writeSPI2(arr);
        }
        else
        {
            //word_to_array(arr, 0,0, 0, 0, 0, 0);
            //writeSPI2(arr);
        }
        */
        //adc_index = 0;
    //}*/
}




void ADCInit()
{
   //Turn on, auto sample start, auto-convert
   AD1CON1 = 0x80E4;




   //Vref+, Vref-, int every conversion, MUXA only
   AD1CON2 = 0x0000;




   //31 Tad auto-sample, Tad = 5*Tcy
   AD1CON3 = 0x1F05;




   //AD1CHS = 7;
   AD1PCFGbits.PCFG3 = 0;  //Disable digital input on ANx
   AD1PCFGbits.PCFG4 = 0;  //Disable digital input on ANx
   AD1PCFGbits.PCFG8 = 0;  //Disable digital input on ANx
   AD1PCFGbits.PCFG9 = 0;  //Disable digital input on ANx
   
   AD1CSSL = 0;	 //No scanned inputs
}




int readADC( int ch)
{
    AD1CON1bits.ADON = 0;
    AD1CON1bits.SAMP = 0;       // stop sampling
    AD1CHSbits.CH0SA = ch;      // select input channel
    AD1CON1bits.SAMP = 1;       // start sampling
    AD1CON1bits.ADON = 1;
    while (!AD1CON1bits.DONE);   // wait to complete the conversion
    int ain = (ADC1BUF0 / 1024.0) * 3300;          // read the conversion result 
    
    return ain;             // 6. read the conversion result
} // readADC




//void __attribute__((__interrupt__, auto_psv)) _INT1Interrupt(void)
//{ 
//   //LATBbits.LATB9 = ~LATBbits.LATB9;	//toggle through
//   IFS1bits.INT1IF = 0;    //Clear the INT1 interrupt flag or else
//   //the CPU will keep vectoring back to the ISR 
//   
//   PORTA = PORTA ^ 0x000F;
//        
//   /*if(k)
//    {
//        PORTA     = 0x000F;
//        //PORTB     = 0xFFFF;
//        //PORTC     = 0xFFFF;
//    }
//    else
//    {
//        PORTA     = 0;
//        //PORTB     = 0;
//        //PORTC     = 0;
//    }*/
//}



/*
void SPI2Init(void)
{
    //config SPI1
    SPI2STATbits.SPIEN 		= 0;	// disable SPI port
    SPI2STATbits.SPISIDL 	= 0; 	// Continue module operation in Idle mode
    
    SPI2BUF 				= 0;   	// clear SPI buffer
    
    IFS2bits.SPI2IF 		= 0;	// clear interrupt flag
    IEC2bits.SPI2IE 		= 0;	// disable interrupt
    
    SPI2CON1bits.DISSCK		= 0;	// Internal SPIx clock is enabled
    SPI2CON1bits.DISSDO		= 0;	// SDOx pin is controlled by the module
    SPI2CON1bits.MODE16 	= 1;	// set in 16-bit mode, clear in 8-bit mode
    SPI2CON1bits.SMP		= 0;	// Input data sampled at middle of data output time
    SPI2CON1bits.CKP 		= 1;	// CKP and CKE is subject to change ...
    SPI2CON1bits.CKE 		= 0;	// ... based on your communication mode.
	SPI2CON1bits.MSTEN 		= 1; 	// 1 =  Master mode; 0 =  Slave mode
	SPI2CON1bits.SPRE 		= 2; 	// Secondary Prescaler = 4:1
	SPI2CON1bits.PPRE 		= 4; 	// Primary Prescaler = 4:1
	
    SPI2CON2 				= 0;	// non-framed mode
	
    SPI2STATbits.SPIEN 		= 1; 	// enable SPI port, clear status
    SPI2STATbits.SPIROV = 0 ;
}*/