import numpy as np
def AlgorithmMSP_1D(a, n):
    min_pSum = 0
    pSum = [0]
    maxA = -np.inf
    for i in range(n):
        pSum.append(pSum[i]+a[i])
        maxA = max(maxA, pSum[i+1] - min_pSum)
        min_pSum = min(min_pSum, pSum[i+1])
    return maxA

def AlgorithmMSP_Sequential(A, N, M):
    maxA = -np.inf
    for i in range(N):
        temp = np.zeros([M, 1])
        for k in range(i, N):
            for j in range(M):
                temp[j] = temp[j]+A[j][k]
            pSum = AlgorithmMSP_1D(temp, M)
            if pSum > maxA:
                maxA = pSum
    return maxA

if __name__ == "__main__":
    from sys import argv
    from random import randint
    if len(argv) > 1:
        size = int(argv[1])
    else:
        size = 1000
    mat = [[randint(-10, 10) for _ in range(size)] for _ in range(size)]
    print(AlgorithmMSP_Sequential(mat, len(mat), len(mat[0])))