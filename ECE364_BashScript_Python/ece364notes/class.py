class Myclass:
    x = 0

    def __init__(self, Var):
        self.Var = Var
        pass

    def __add__(self):   # overload + operator
        pass

    def addUser(self, name):
        pass

    def _processUser(self, userName):  # private
        pass

    def __ne__(self, other):   # overload the != operator
        pass


class anotherclass(Myclass):

    def __init__(self, newVar):
        self.newVar=newVar
        Myclass.__init__(self, newVar)   #inheritence

        #super().__init__(newVar)    # another way for inheritance
        #super(AnotherClass, self).__init__(newVar)   

        pass
