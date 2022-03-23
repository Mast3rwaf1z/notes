import numba
from random import randint
from time import perf_counter
from math import floor
from sequential_random_set import gen_csv

@numba.jit(nopython=True, parallel=True)
def gen_set(sets:int, set_size:int, l:list[int]):
    result = [[l.pop(randint(0, len(l)-1)) for _ in numba.prange(set_size)] for _ in numba.prange(sets)]
    return result, l

def function(elements:int, sets:int):
    set_size = floor(elements/sets)
    gen_csv(elements)

    # read and save the generated csv in memory
    with open("numbers.csv", "r") as file:
        _in = file.read()
        l = [int(element) for element in _in.split(sep=",")]

    _pre = perf_counter()
    gen_set(sets, set_size, l)
    _post = perf_counter()
    print(f'jit time:           {_post - _pre} ms')



if __name__ == "__main__":
    from sys import argv
    elements = int(argv[1]) #n elements
    sets = int(argv[2]) #k sets

    result, remainder = function(elements, sets)

    for set in result:
        print(set)
    print(remainder)