#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int * temp;

int msp1D(int *a, int n){
	int min_pSum = 0;
	int pSum[n];
	pSum[0] = 0;
	int maxA = -10000;
	for (int i = 0; i < n; i++)
		pSum[i+1] = pSum[i] + a[i];
	for (int i = 1; i < n+1; i++) {
		if (pSum[i] - min_pSum > maxA) 
			maxA = pSum[i] - min_pSum;
		if (min_pSum > pSum[i]) 
			min_pSum =  pSum[i];
	}
	return maxA;
}

int mspseq(int *A, int N, int M) {
	int maxA = -10000;
	for (int i = 0; i < N; i++) {
		for (int h = 0; h < M; h++)
			temp[h] = A[h+i*M];
		int pSum = msp1D(temp, M);
		if (pSum > maxA) maxA = pSum;
		for (int k = i+1; k < N; k++) {
			for (int j = 0; j < M; j++)
				temp[j] += A[j+M*k];
			int pSum = msp1D(temp, M);
			if (pSum > maxA)
				maxA = pSum;
		}
	}
	return maxA;
}

int main(void)
{
	int sz, i;
	printf("Enter the size of array in 2 dimensions ");
	scanf("%d",&sz);
	int n = sz;
	sz *= n;
	int * randArray = malloc(sizeof(int) * sz);
	temp = malloc(sizeof(int)* n);
	if (randArray == NULL) return 1;
	srand(time(0));
	for(i=0;i<sz;i++)
		randArray[i]=rand()%20-10;   //Generate number between -10 and 10

	if (n < 15) {
		printf("\nElements of the array::");
		for(i=0;i<sz;i++)
		{
			if (i%n == 0) printf("\n");
			printf("%d ", randArray[i]);
		}
	}
	printf("\nMSP2d: %d\n", mspseq(randArray, n, n));
	free(randArray);
	free(temp);
	return 0;
}
