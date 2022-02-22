from random import randint
from multiprocessing import Process
from time import sleep

result:list

def multiply_row(index:int, row:list, integer:int) -> int:
    global result
    final = 0
    for entry in row:
        final = final + (entry * integer)
    result[index] = final
    print(f'finished task {index}')


def algorithm(array:list[list], vector:list):
    for i in range(len(array)):
        row = array[i]
        Process(target=lambda: multiply_row(i, row, vector[i])).start()

size = 4
result = [i for i in range(size)]
array = [[randint(0,100) for i in range(size)] for i in range(size)]

vector = [randint(0, 100) for i in range(size)]

algorithm(array, vector)
sleep(1)
print(result)
