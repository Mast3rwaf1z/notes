from math import ceil
from multiprocessing import Process

array = range(int(input("input arrsize: ")))
target = int(input("input target: "))
processors = int(input("input processors: "))

def algorithm(start_index, end_index):
    for num in array[start_index:end_index]:
        if num == target:
            print(f'match mp: {num}')

for i in range(processors):
    start_index = int(i*ceil(len(array)/processors))
    end_index = int((i+1)*ceil(len(array)/processors))
    Process(target=lambda: algorithm(start_index, end_index)).start()

for num in array:
    if num == target:
        print(f'match seq: {num}')
