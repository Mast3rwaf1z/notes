#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <math.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define ARRSIZE 60

// Errno source code https://www.tutorialspoint.com/c_standard_library/c_macro_errno.htm
extern int errno;
int FD;

// Source https://www.tutorialspoint.com/c_standard_library/c_function_signal.htm
static void Sig_Handler(int _)
{
	(void)_;
	printf("\nCaught Interrupt Signal. Exiting Program.\n");
	if (close(FD) == -1)
	{
		fprintf(stderr, "Value of errno: %d\n", errno);
    	fprintf(stderr, "Error closing file: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	else
	{
		exit(EXIT_SUCCESS);
	}
}
// Source for named pipe https://www.geeksforgeeks.org/named-pipe-fifo-example-c-program/
int main (int argc, char *argv[])
{
	printf("Started program\n");

	signal(SIGINT, Sig_Handler);
	
	char * myFIFO = "/tmp/myfifo";
	mkfifo(myFIFO, 0666);
	FD = open(myFIFO, O_WRONLY);
	if (FD == NULL)
	{
		fprintf(stderr, "Value of errno: %d\n", errno);
    	fprintf(stderr, "Error opening file: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	char TempStr[50];

	double TempArr[ARRSIZE], Sum, Avg;
	double x, y, s, S, R1, R2;

	for(int i; i<ARRSIZE; i++)
	{
		TempArr[i] = 0;
	}

	float Temp = 30*((double) rand()/(RAND_MAX));
	int Index = 0;



	while(1)
	{
		//printf("Starting while loop\n");
		do
        {		
        	// Generating numbers between -1 and 1		
			x = 2*((double) rand()/(RAND_MAX))-1;
			y = 2*((double) rand()/(RAND_MAX))-1;
			// Trying to compute Marsaglia polar method
			s = x*x + y*y;
		}while(s > 1 || s == 0);

		//printf("Initial R1 is: %f\n", x);
		//printf("Initial R2 is: %f\n", y);

		S = sqrt((-2*log(s))/s);
		R1 = (x*S)/4;
		R2 = (y*S)/4;

		//printf("R1 value is: %f\n", R1);
		//printf("R2 value is: %f\n", R2);

		sleep(1);
		Temp += R1;
		TempArr[Index] = Temp;
		Index = (Index + 1) % ARRSIZE;
		Sum = 0;
		for(int i = 0; i < ARRSIZE; i++)
		{
			Sum = Sum + TempArr[i];
		}
		Avg = Sum/ARRSIZE;
		printf("\nTemperature is: %f\t\tAverage is: %f\n", Temp, Avg);
		sprintf(TempStr, "\nTemperature is: %f\t\tAverage is: %f\n", Temp, Avg);
		write(FD, TempStr, strlen(TempStr) + 1);

		sleep(1);
		Temp += R2;
		TempArr[Index] = Temp;
		Index = (Index + 1) % ARRSIZE;
		Sum = 0;
		for(int i = 0; i < ARRSIZE; i++)
		{		
			Sum = Sum + TempArr[i];
		}
		Avg = Sum/ARRSIZE;
		printf("\nTemperature is: %f\t\tAverage is: %f\n", Temp, Avg);
		sprintf(TempStr, "\nTemperature is: %f\t\tAverage is: %f\n", Temp, Avg);
		write(FD, TempStr, strlen(TempStr) + 1);
	}
}

