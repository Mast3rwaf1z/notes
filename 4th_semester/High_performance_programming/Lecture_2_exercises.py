from math import ceil
from multiprocessing import Process

arr=[i for i in range(100)]
p=4
target=3

def algorithm(start_index, end_index):
    for i in range(start_index, end_index):
        if arr[i] == target:
            print(f'match mp: {arr[i]}')


for i in range(p):
    start_index = int(i*ceil(len(arr)/p))
    end_index = int((i+1)*ceil(len(arr)/p))
    Process(target=lambda: algorithm(start_index, end_index)).start()

for i in arr:
    if i == target:
        print(f'match seq: {i}')