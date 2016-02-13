def morning(name):
    return 'Good Morning, {}!'.format(name)

def greeting(greetingFunction, name):
    return greetingFunction(name)

def createPowerFunction(power):
    return lambda x: x ** power


def main():
    print(greeting(morning, 'Tian'))

    

    # lambda function
    adder = lambda x, y: x + y
    print(adder(3, 10))

    squareFunction = createPwerFunction(2)
    print('-2 ^ 2 = {} | -3 ^


    l = [1,2,3,4]
    l2 = list(map(lambda x: x ** 2, l))


if __name__ == '__main__':
    main()
