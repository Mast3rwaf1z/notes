from random import randint
from multiprocessing import Process, Array

size = 10
result = Array("i", [0 for i in range(size)])

def multiply_row(index:int, row:list, integer:int) -> int:
    global result
    final = 0
    for entry in row:
        final = final + (entry * integer)
    result[index] = final
    print(f'finished task {index} with array {result[:]}')


def algorithm(array:list[list], vector:list):
    for i in range(len(array)):
        row = array[i]
        Process(target=lambda: multiply_row(i, row, vector[i])).start()

array = [[randint(0,100) for i in range(size)] for i in range(size)]

vector = [randint(0, 100) for i in range(size)]

algorithm(array, vector)
