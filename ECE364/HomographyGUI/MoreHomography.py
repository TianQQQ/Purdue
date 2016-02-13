__author__ = 'ee364d08'
import numpy,scipy


class AdvancedTransformation:

    def __init__(self, sourceImage, v, h1, h2):
        if isinstance(sourceImage, numpy.ndarray) is not True:
            raise TypeError
        self.sbound = sourceImage.shape
        if len(sourceImage.shape) != 3:
            raise ValueError
        else:
            if self.sbound[1] % 2 == 1:
                raise ValueError
        self.sourceImage = sourceImage




    '''
    Initialize the instance of the AdvancedTransformation class. The parameter sourceImage is an instance
    of ndarray, while v, h1, h2 are all integers greater than or equal to 0.
    Raise a TypeError with an appropriate message if the parameter sourceImage is not an instance of
    ndarray, and raise a ValueError if it does not represent a color image. Additionally, raise a ValueError
    if the number of columns in the image passed is not even.
    '''



    def applyEffectV(self):




        pass
    def applyEffectA(self):
        pass
