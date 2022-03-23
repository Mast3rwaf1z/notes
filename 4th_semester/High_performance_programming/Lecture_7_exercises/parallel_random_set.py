from math import floor
from multiprocessing import Process, Array
from time import perf_counter
from main import gen_csv
from random import randint

def gen_set(set_size:int, l:list):
    #pop a random index from the list
    set = [l.pop(randint(0, len(l)-1)) for _ in range(set_size)]
    #print(set)

def function(elements:int, sets:int):
    set_size = floor(elements/sets)

    # read and save the generated csv in memory
    with open("numbers.csv", "r") as file:
        _in = file.read()
        l = [int(element) for element in _in.split(sep=",")]

    _pre = perf_counter()
    # generate processes
    processes = [Process(target=gen_set, args=(set_size, l,)) for _ in range(sets)]
    for process in processes:
        process.start()
    for process in processes:
        process.join()
    _post = perf_counter()
    #print(f'remainder: {l}')
    print(f'parallel time:      {_post - _pre} ms')
    return 0, l

if __name__ == "__main__":
    from sys import argv
    elements = int(argv[1]) #n elements
    sets = int(argv[2]) #k sets

    gen_csv(elements)

    result, remainder = function(elements, sets)

    for set in result:
        print(set)
    print(remainder)

    
