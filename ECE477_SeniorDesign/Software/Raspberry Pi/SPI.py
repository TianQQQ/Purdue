import spidev
import time
import RPi.GPIO as GPIO


'''
Enter: Send space left back to micro   1
Exit: Send money due back to micro     0

format:   FE, C8, *, *, C9, 0/1, CA, *,*,*,*,*,*(plate), FF
C8: SPACE LEFT
C9: ENTER/EXIT   1/0
CA: PLATE NUMBER

'''


dictionary = dict([
                    ('A', 0),
                    ('B', 1),
                    ('C', 2),
                    ('D', 3),
                    ('E', 4),
                    ('F', 5),
                    ('G', 6),
                    ('H', 7),
                    ('I', 8),
                    ('J', 9),
                    ('K', 10),
                    ('L', 11),
                    ('M', 12),
                    ('N', 13),
                    ('O', 14),
                    ('P', 15),
                    ('Q', 16),
                    ('R', 17),
                    ('S', 18),
                    ('T', 19),
                    ('U', 20),
                    ('V', 21),
                    ('W', 22),
                    ('X', 23),
                    ('Y', 24),
                    ('Z', 25),
                    ('0', 26),
                    ('1', 27),
                    ('2', 28),
                    ('3', 29),
                    ('4', 30),
                    ('5', 31),
                    ('6', 32),
                    ('7', 33),
                    ('8', 34),
                    ('9', 35),
                    

                    

                        ])


spi = spidev.SpiDev()   # create spi object
spi.open(0,0) # open spi port 0, device CS 1

#spi.writebytes(0x10)
'''
a = 'J'
print(dictionary[a])
print(hex(dictionary[a]))
spi.writebytes(hex(dictionary[a]))
'''
def send_space(space):
    try:
        #spi.writebytes([0xFE])

        # space left
        # spi.writebytes([0xC8])
        #a = int('20')
        #print(hex(dictionary[int(a)]))
        #spi.writebytes(hex(a))
        '''
        spi.writebytes([0xFE])
        # enterflag
        spi.writebytes([0xC9])
        spi.writebytes([ord(enterflag)])
        spi.writebytes([0xFF])

        spi.writebytes([0xFE])
        # plate
        spi.writebytes([0xCA])
        for a in plate:
            spi.writebytes([ord(a)])

        spi.writebytes([0xFF])
        '''
    except KeyboardInterrupt:
        spi.close()

def send_enterflag(enterflag):
    try:
        #GPIO.setmode(GPIO.BCM)
        #spi.writebytes([0xFE])
        # enterflag
        #spi.writebytes([0xC9])
        '''    
        spi.writebytes([hex(0)])
        time.sleep(1)
        spi.writebytes([hex(1)])
        time.sleep(1)
        spi.writebytes([hex(2)])
        time.sleep(1)
        spi.writebytes([hex(2)])
        time.sleep(1)
        spi.writebytes([hex(2)])
        time.sleep(1)
        spi.writebytes([hex(2)])
        time.sleep(1)
        '''

        P = 'P'
        E = 'E'
        a = '9'
        b = '2'
        c = '8' 
        d = '3'
        print(hex(dictionary[P]))
        spi.writebytes([0xf])
        time.sleep(1)
        spi.writebytes([0x4])
        time.sleep(1)
        spi.writebytes([0x23])
        #time.sleep(1)
        
        spi.writebytes([0x1C])
        time.sleep(1)
        spi.writebytes([34])
        #time.sleep(1)
        spi.writebytes([29])
        time.sleep(1)
        
        '''
        spi.writebytes(hex(dictionary['C']))
        spi.writebytes(hex(dictionary['K']))
        time.sleep(1)
        time`.sleep(1)
        spi.writebytes(hex(dictionary['W']))
        spi.writebytes(hex(dictionary['E']))
        time.sleep(1)
        spi.writebytes(hex(dictionary['W']))
        spi.writebytes(hex(dictionary['E']))
        time.sleep(1)
        spi.writebytes(hex(dictionary['W']))
        spi.writebytes(hex(dictionary['E']))
        '''
        #spi.writebytes([0xFF])
        #GPIO.setup(22, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)


    except KeyboardInterrupt:
        spi.close()

def send_plate(plate):
    try:
        

        spi.writebytes([0xFE])
        # plate
        spi.writebytes([0xCA])
        for a in plate:
            spi.writebytes([ord(a)])

        spi.writebytes([0xFF])
    except KeyboardInterrupt:
        spi.close()

