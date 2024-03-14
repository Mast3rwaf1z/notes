#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

#define threads 3

struct toThreads {
	int * A;
	int N;
	int M;
	int max;
	int x1;
	int x2;
	int y1;
	int y2;
	char id;
} args[threads];


int * randArray;

int msp1D(int *a, int n, int * from, int * to){
	int prefrom = 0, min_pSum = 0, pSum[n];
	pSum[0] = a[0];
	int maxA = -10000;
	for (int i = 1; i < n; i++) {
		pSum[i] = pSum[i-1] + a[i];
	}
	for (int i = 0; i < n; i++) {
		if (pSum[i] - min_pSum > maxA) {
			maxA = pSum[i] - min_pSum;
			*to = i;
			*from = prefrom;
		}
		else if (min_pSum > pSum[i]) {
			min_pSum =  pSum[i];
			prefrom = i+1;
		}
	}
	return maxA;
}

void *msppar(void * input) {
	struct toThreads * coms = input;
	coms->max = -10000, 
	coms->x1 =0;
	coms->x2=0;
	coms->y1=0;
	coms->y2=0;

	for (int i = coms->id; i < coms->N; i+=threads) {
		int temp[coms->M], from =0, to=0;
		for (int h = 0; h < coms->M; h++) temp[h] = coms->A[h+coms->M*i];
		int pSum = msp1D(temp, coms->M, &from, &to);
		if (pSum > coms->max) { coms->max = pSum; coms->x1 = from; coms->x2= to; coms->y1 = coms->y2 = i;}
		for (int k = i+1; k < coms->N; k++) {
			for (int j = 0; j < coms->M; j++) temp[j] += coms->A[j+coms->M*k]; 
			int pSum = msp1D(temp, coms->M, &from, &to);
			if (pSum > coms->max) { coms->max = pSum; coms->x1 = from; coms->x2= to; coms->y1 =i; coms->y2 = k;}
		}
	}
}


void mspseq(int *A, int N, int M) {
	int maxA = -10000, x1 =0, x2=0, y1=0, y2=0;
	for (int i = 0; i < N; i++) {
		int temp[M], from =0, to=0;
		for (int h = 0; h < M; h++) temp[h] = A[h+M*i];
		int pSum = msp1D(temp, M, &from, &to);
		if (pSum > maxA) { maxA = pSum; x1 = from; x2= to; y1 = y2 = i;}
		for (int k = i+1; k < N; k++) {
			for (int j = 0; j < M; j++) 
				temp[j] += A[j+M*k]; 
			int pSum = msp1D(temp, M, &from, &to);
			if (pSum > maxA) { maxA = pSum; x1 = from; x2= to; y1 =i; y2 = k;}
		}
	}
	printf("Sum is %d,  [%d:%d,%d:%d]", maxA, y1+1, y2+1,x1+1, x2+1);
}

int main(void)
{
	int sz;
	printf("Enter the size of array in 2 dimensions ");
	scanf("%d",&sz);
	int n = sz;
	sz *= n;
	srand(time(0));
	randArray = malloc(sizeof(int) * sz);
	if (randArray == NULL) return 1;
        int i;
	for(i=0;i<sz;i++)
		randArray[i]=rand()%20-10;   //Generate number between -10 and 10

	if (n < 15) {
		printf("\nElements of the array::");
		for(i=0;i<sz;i++) {
			if (i%n == 0) printf("\n");
			printf("%d ", randArray[i]);
		}
	}
	printf("\n");

	pthread_t thread[threads], iret[threads];
	for (int i = 0; i < threads; i++) {
		args[i] = (struct toThreads){randArray, n, n, 0, 0, 0 , 0, 0, i};
		iret[i] = pthread_create( &thread[i], NULL, msppar, (void*) &args[i]);
	}
	for (int i = 0; i < threads; i++) {
		pthread_join(thread[i], NULL);
	}
	printf("max %d %d %d %d", args[0].max, args[1].max, args[2].max, args[3].max);
    int maks = 0, index;
	for (int i = 0; i < threads; i++)
    { 
        if (maks < args[i].max) {
            maks = args[i].max;
			index = i;
		}
    }
	printf("Sum is %d,  [%d:%d,%d:%d]", args[index].max, args[index].y1+1, args[index].y2+1,args[index].x1+1, args[index].x2+1);

	free(randArray);
	return 0;
}
