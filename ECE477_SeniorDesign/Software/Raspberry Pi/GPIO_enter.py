import RPi.GPIO as GPIO
import time
from enter import *
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
9This will enable a pull-down resistor on pin 23, and a pull-up resistor on pin 24. Now, let’s check to see if we can read them. The Pi is looking for a high voltage on Pin 23 and a low voltage on Pin 24. We’ll also need to put these inside of a loop, so that it is constantly checking the pin voltage. The code so far looks like this:
'''

'''
    if(GPIO.input(24) == 0):
        print(“Button 2 pressed”)
import RPi.GPIO as GPIO
GPIO.setup(24, GPIO.IN, pull_up_down = GPIO.PUD_UP)
'''
def record_space_left():
    with open ('/home/pi/Desktop/Information/Space', 'r') as f:
        lines = f.readlines()
        print(lines[0])
        lines[0] = int(lines[0]) - 1
    f.close()

    with open ('/home/pi/Desktop/Information/Space', 'w') as f:
        f.write(str(lines[0]))
    f.close() # space minus one already
    return str(lines[0])
    
    
    

    
try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(23, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
    GPIO.setup(24, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
    #GPIO.setup(22, GPIO.IN, pull_up_down = GPIO.PUD_UP)
    while True:
        '''
        if(GPIO.input(23) ==1):
        One rising and one falling means one click
        '''

        GPIO.wait_for_edge(23, GPIO.RISING)  
        GPIO.wait_for_edge(23, GPIO.FALLING)
        #GPIO.setup(22, GPIO.IN, pull_up_down = GPIO.PUD_UP)
        print("Button 1 pressed, car siganl received")
        time.sleep(1)
        space = record_space_left()
        # precision logics

        
        current_time = record_time()

        plate = take_plate_number()
        record_inforamtion(plate, current_time)


        # use SPI send the current time and plate number back to micro
        ELflag = True # for entering

        #send_space(space)
        #send_enterflag(ELflag)
        #send_plate(plate)
        print('finished')


        

except KeyboardInterrupt:
    GPIO.cleanup()

