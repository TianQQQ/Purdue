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




def record_time():
    # to calculate how many items in the recording file
    current_time = time.time()

    return current_time
        

def take_image():
    
    # this camera needs to relex 10 seconds before next usage
    os.system('fswebcam ~/Desktop/Images/a.jpg')
    os.system('~/Desktop/take_image.sh')  # usb camera
    os.system('mv ~/Desktop/Images/a.jpg ~/Desktop/Images/time.jpg')
    
    #os.system('sudo raspistill -o ~/Desktop/Images/c.jpg')
   

def take_plate_number():


    take_image()
    os.system('~/Desktop/alpr ~/Desktop/Images/time.jpg\
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
     
    #plate = 'PE9283'
    plate = re.findall(r'[A-Z0-9]+', plate)
    print(plate)
    return plate[0]

def record_inforamtion(plate, time):
    # write current plate number into recording file
    f = open ('/home/pi/Desktop/Information/record', 'a') # a is append
    string = plate + ',' + str(time) + '\n'
    print(string)
    f.write("%s" % string)
    f.close()

'''
if __name__ == "__main__":
    time = record_time()
    plate = take_plate_number()
    record_inforamtion(plate,time)

    print('finished')
'''
