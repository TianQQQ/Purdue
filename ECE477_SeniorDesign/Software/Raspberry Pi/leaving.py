'''
This file is to take the image and do plate regnition

Entrence steps:
1. when get the signal, take the images 
2. alpr program on the taken images
3. alalyze the results and get the best confident 
4. store the results into database ( maybe just textfile )
    (1). time
    (2). plate number store and give back

Exit steps:
1. when get the signal, take the images
2. alpr program on the taken images
3. analyze the results and get the best confident results
4. test whether this plate in the database
    (1). time difference give back
    (2). plate number give back

'''

import os
import datetime
import re
import time




def calculate_time_difference(time_enter):
    current_time = time.time()
    #time_enter = str(time_enter)
    #time_enter = time_enter.split('.')
    #time_enter = datetime.datetime.strptime('2016-10-19 05:35:24', '%Y-%m-%d %H:%M:%S')
    

    time_diff = int(int(current_time) - int(time_enter))
    return time_diff
        

def take_image():

    #os.system('fswebcam -r 2560x1440 --no-banner ~/Desktop/Images/a.jpg')
    #os.system('~/Desktop/Images/take_image.sh')  # usb camera
    #os.system('mv ~/Desktop/Images/a.jpg ~/Desktop/Images/time.jpg')

    
    os.system('sudo raspistill -o ~/Desktop/Images/c.jpg')

def take_plate_number():
    take_image()
    os.system('~/Desktop/alpr ~/Desktop/Images/c.jpg\
              > ~/Desktop/Information/output')

    f = open ('/home/pi/Desktop/Information/output')
    lines = f.readlines()

    try:
        plate = lines[1]
    except:
        try:
            take_image()
            os.system('~/Desktop/alpr ~/Desktop/Images/c.jpg\
              > ~/Desktop/Information/output')
            f = open ('/home/pi/Desktop/Information/output')
            lines = f.readlines()
            plate = lines[1]

        except:
            plate = 'PE9283'
    
    plate = re.findall(r'[A-Z0-9]+', plate)
    return plate[0]

   
def get_information(plate):
    
    f = open ('/home/pi/Desktop/Information/record', 'r')
    lines = f.readlines()
    print(lines[-1])
    line = lines[-1].split(',')
    line = line[1].split('.')
    return line[0]
######################## need to be change because
#### need to find the plate number first and then find the last matching number

