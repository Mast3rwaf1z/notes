from random import randint
from multiprocessing import Process, Array
#from threading import Thread as Process

size = 4
result = Array("i", [0 for i in range(size)]) # for multiprocessing
#result = range(size) # for threading

def multiply_row(index:int, row:list, vector:int) -> int:
    global result
    final = 0
    for i in range(len(row)):
        final = final + (row[i] * vector[i])
    result[index] = final

def check_process_array(array:list[Process]):
    for process in array:
        if process.is_alive():
            return True
    return False

def algorithm(matrix:list[list], vector:list):
    processes:list[Process] = []
    for i in range(len(matrix)):
        row = matrix[i]
        processes.append(Process(target=lambda: multiply_row(i, row, vector)))
        processes[i].start()
    while check_process_array(processes):
        pass
    return True

if __name__ == "__main__":
    matrix = [[randint(0,100) for i in range(size)] for i in range(size)]
    vector = [randint(0, 100) for i in range(size)]
    algorithm(matrix, vector)

    print("matrix")
    for i in range(len(matrix)):
        row = matrix[i]
        print(f'row {i}: {row}')
    print()
    print(f'vector: {vector}')
    print(f'result{result[:]}')
