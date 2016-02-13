import functools


from functools import lru_cache    # least recently used
@lru_cache(maxsize=None)

def add(x,y):
    return x + y


add5 = functiools.partial(add, 5)
result = add5(add,5)
