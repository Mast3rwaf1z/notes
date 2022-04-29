import numpy as np
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

matrix = [
        [3,-1,0],
        [-4,5,17],
        [7,6,-10]
        ]
result = AlgorithmMSP_Sequential(matrix, 3, 3)
print(result)
