from random import randint
from time import perf_counter

from sequential_msp import AlgorithmMSP_Sequential
from parallel_msp import Algorithm_MSP_Parallel


arr_size = 1000
matrix = [[randint(-10, 10) for _ in range(arr_size)] for _ in range(arr_size)]

seq_pre = perf_counter()
print(AlgorithmMSP_Sequential(matrix, len(matrix), len(matrix[0])))
seq_post = perf_counter()
para_pre = perf_counter()
print(Algorithm_MSP_Parallel(matrix, len(matrix), len(matrix[0])))
para_post = perf_counter()

print(f'Sequential execution time:  {seq_post-seq_pre}')
print(f'Parallel execution time     {para_post-para_pre}')
