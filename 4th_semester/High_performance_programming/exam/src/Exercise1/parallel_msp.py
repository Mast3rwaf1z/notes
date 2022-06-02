import numpy as np
from multiprocessing import Process, get_context
from multiprocessing.pool import Pool as pool
from math import floor

processor_count = 8

class NoDaemonProcess(Process):
    @property
    def daemon(self):
        return False
    @daemon.setter
    def daemon(self, value):
        pass
class NoDaemonContext(type(get_context())):
    Process = NoDaemonProcess
class my_cool_pool(pool):
    def __init__(self, *args, **kwargs):
        kwargs['context'] = NoDaemonContext()
        super(my_cool_pool, self).__init__(*args, **kwargs)


def AlgorithmMSP_1D(a, n):
    min_pSum = 0
    pSum = [0]
    maxA = -np.inf
    for i in range(n):
        pSum.append(pSum[i]+a[i])
    for i in range(1, n+1):
        maxA = max(maxA, pSum[i] - min_pSum)
        min_pSum = min(min_pSum, pSum[i])
    return maxA

def AlgorithmMSP_1D_improved(a):
    min_pSum = 0
    pSum = [0]
    maxA = -np.inf
    for i in range(len(a)):
        pSum.append(pSum[i]+a[i])
        maxA = max(maxA, pSum[i+1] - min_pSum)
        min_pSum = min(min_pSum, pSum[i+1])
    return maxA

def get_sums(A:list) -> list:
    sums = [0]
    for i in range(len(A)):
        sums.append(sums[i]+A[i])
    return max(sums)

def AlgorithmMSP_1D_parallel(l, n):
    sublist_length = floor(n/processor_count)
    remainder = (sublist_length*n)-n
    with my_cool_pool(processor_count) as p:
        first_run = p.map(get_sums, [l[sublist_length*n:(sublist_length*n)+sublist_length] for n in range(processor_count)])
    if not remainder == 0:
        first_run.append(get_sums(l[(sublist_length*processor_count):]))
    sums = [0]
    for i in range(len(first_run)):
        sums.append(sums[i] + first_run[i])

    return max(sums)



def inner(args):
    j, k, A1, A2 = args
    return A2[j] + A1[j][k]

def outer(args):
    A, i, N, M = args
    temp = np.zeros([M, 1])
    Sums = list()
    for k in range(i, N):
        temp = [inner((j, k, A, temp)) for j in range(M)]
        Sums.append(AlgorithmMSP_1D(temp, M))
    return Sums

def Algorithm_MSP_Parallel(A, N, M):
    maxA = -np.inf
    with my_cool_pool(processor_count) as p:
        temp = p.map(outer, [(A, i, N, M) for i in range(N)])
        results = []
        for Sums in temp:
            results.extend(Sums)
        maxA = max(results)
    return maxA
    
if __name__ == "__main__":
    from sys import argv
    from random import randint
    if len(argv) > 1:
        size = int(argv[1])
    else:
        size = 100
    mat = [[randint(-10, 10) for _ in range(size)] for _ in range(size)]
    print(Algorithm_MSP_Parallel(mat, len(mat), len(mat[0])))
    #l = [randint(-10, 10) for _ in range(160)]
    #print(AlgorithmMSP_1D_parallel(l, 8))
    #print(AlgorithmMSP_1D(l, 8))
