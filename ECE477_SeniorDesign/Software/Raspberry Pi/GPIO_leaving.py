import RPi.GPIO as GPIO
import time
from leaving import *
from SPI import *
'''print(GPIO.VERSION)
http://makezine.com/projects/tutorial-raspberry-pi-gpio-pins-and-python/

1. get the signal from micro
2. call take image function

Note:
1.  The switch on pin 23 is tied to 3.3V,
    while the switch on pin 24 is tied to ground.
'''

'''
This will enable a pull-down resistor on pin 23, and a pull-up resistor on pin 24. Now, let’s check to see if we can read them. The Pi is looking for a high voltage on Pin 23 and a low voltage on Pin 24. We’ll also need to put these inside of a loop, so that it is constantly checking the pin voltage. The code so far looks like this:
'''

'''
    if(GPIO.input(24) == 0):
        print(“Button 2 pressed”)+

GPIO.setup(24, GP1IO.IN, pull_up_down = GPIO.PUD_UP)
'''
def record_space_left():
    with open ('/home/pi/Desktop/Information/Space', 'r') as f:
        lines = f.readlines()
        print(lines[0])
        lines[0] = int(lines[0]) + 1   # car leaving , space ++
    f.close()

    with open ('/home/pi/Desktop/Information/Space', 'w') as f:
        f.write(str(lines[0]))
    f.close() # space minus one already
    return str(lines[0])
    
    
        
    

    
try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(23, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
    GPIO.setup(24, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
    while True:
        '''
        if(GPIO.input(23) ==1):
        One rising and one falling means one click
        '''
        time.sleep(1)
        GPIO.wait_for_edge(24, GPIO.RISING)  
        GPIO.wait_for_edge(24, GPIO.FALLING)
        print("Button 2 pressed, car leaving")
        
        space = record_space_left()
        
        # 1. precision logics
        # 2. how do I retake the image when taking images failed
        plate = take_plate_number()               # take by record information
        time_enter = get_information(plate)
        time_diff = calculate_time_difference(time_enter)
        print('time difference is that')
        print(time_diff)
        print('seconds')

        # every second cost one dollar
        # send_calculated_money(str(time_diff))
        # use SPI to time difference and plate number back
        ELflag = False # for entering
        #send_space(space)
        #send_enterflag(ELflag)
        #send_plate(plate)
        print('finished\n')
        # taking the image again and open the gate again


except KeyboardInterrupt:
    GPIO.cleanup()
