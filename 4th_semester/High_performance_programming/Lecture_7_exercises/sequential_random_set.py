from math import floor
from random import randint
from os import system
from time import perf_counter


def function(elements:int, sets:int):
    set_size = floor(elements/sets)
    # generate csv

    # read and save the generated csv in memory
    with open("numbers.csv", "r") as file:
        _in = file.read()
        l = [int(element) for element in _in.split(sep=",")]

    _pre = perf_counter()
    # generate set elements
    result = [[l.pop(randint(0, len(l)-1)) for _ in range(set_size)] for _ in range(sets)]
    _post = perf_counter()


    print(f'sequential time:    {_post - _pre} s')
    return result
    

if __name__ == "__main__":
    from sys import argv
    from main import gen_csv

    if len(argv) == 3:
        elements = int(argv[1]) #n elements
        sets = int(argv[2]) #k sets
    else:
        elements = 10000
        sets = 100

    gen_csv(elements)
    
    result = function(elements, sets)
