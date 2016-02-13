def fib(n):
    if n < 2:
        return n
    else:
        return fib(n-1) + fib(n-2)

class Multiplytwonumbers:
    def __init__(self):
        pass

    def __call__(self, i, j):
        return i * j


multiplyInstance = Multiplytwonumbers()
result = multiplyInstance(3, -5)
print(result)   
