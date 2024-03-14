import numpy as np
from multiprocessing import Process, get_context
from multiprocessing.pool import Pool as pool

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

def inner(args):
    j, k, A1, A2 = args
    return A2[j] + A1[j][k]

def outer(args):
    A, i, N, M = args
    temp = np.zeros([M, 1])
    Sums = list()
    for k in range(i, N):
        #with pool(processor_count) as p:
        #    temp = p.map(inner, [(j, k, A, temp) for j in range(M)])
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
    #return max([outer((A, i, N, M)) for i in range(N)])
    
