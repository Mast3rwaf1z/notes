#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include <errno.h>
#include <math.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define ARRSIZE 60

/*
This program generates temperature data apporximately every second, and calculates an average from the last 60 data points
This program opens a FIFO file (Named pipe) and sends the temperature and average through it. The FIFO is made at destination \tmp\myfifo
The format of the data is as such: "{day}/{month}/{year}	{hour}:{minute}:{second}	{temperature}	{average}" The delimiter is \t
Closing the read end of the FIFO automatically closes this file after the last command in the while loop is executed
*/





// Errno source code https://www.tutorialspoint.com/c_standard_library/c_macro_errno.htm
extern int errno;														// Create errno integer. This integer indicates the last error that occured
int FD;																	// Create File Descriptor which is used to indicate the FIFO file

// SIGINT(Ctrl+C) Handling Source https://www.tutorialspoint.com/c_standard_library/c_function_signal.htm
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
// Source for time stamps https://www.includehelp.com/c-programs/system-date-time-linux.aspx
// Source for srand https://stackoverflow.com/questions/1108780/why-do-i-always-get-the-same-sequence-of-random-numbers-with-rand
int main (int argc, char *argv[])
{
	printf("Started program\n");
	
	// Specify function to run when Interrupt Signal (Ctrl+C) is caught
	signal(SIGINT, Sig_Handler);
	
	// Create FIFO (Named pipe) file and open it
	char * myFIFO = "/tmp/myfifo";
	mkfifo(myFIFO, 0666);
	FD = open(myFIFO, O_WRONLY);
	if (FD == NULL)
	{
		fprintf(stderr, "Value of errno: %d\n", errno);
    	fprintf(stderr, "Error opening file: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	// Array to store the string to be sent through the pipe
	char TempStr[50];

	// Create variables used for making random values and storing temperature
	double TempArr[ARRSIZE], Sum, Avg;
	double x, y, s, S, R1, R2;

	// Change the random function seed according to the time, then make the initial temperature a random value between 0 and 30
	srand(time(NULL));
	float Temp = 30*((double) rand()/(RAND_MAX));
	int Index = 0;														// Used as pointer for TempArr

	for(int i = 0; i<ARRSIZE; i++)
	{
		TempArr[i] = Temp;
	}

	// Time variables to get the time stamp
	time_t T;
    struct tm tm;

    

	while(1)
	{
		do
        {		
        	// Generating numbers between -1 and 1		
			x = 2*((double) rand()/(RAND_MAX))-1;
			y = 2*((double) rand()/(RAND_MAX))-1;
			// Trying to compute Marsaglia polar method
			s = x*x + y*y;
		}while(s > 1 || s == 0);

		// Creating two normally distributed random numbers
		S = sqrt((-2*log(s))/s);
		R1 = (x*S)/4;
		R2 = (y*S)/4;

		sleep(1);

		// Add the first random value to the temperature, if the temperature would go bellow 0 or above 30 then subtract the random number instead
		if ((Temp + R1) > 30 || (Temp + R1) < 0)
		{
			Temp -= R1;
		}
		else
		{
			Temp += R1;
		}
		
		// Add the new temperature the temperature array and update the index
		TempArr[Index] = Temp;
		Index = (Index + 1) % ARRSIZE;

		// Compute the average using the values in TempArr
		Sum = 0;
		for(int i = 0; i < ARRSIZE; i++)
		{
			Sum = Sum + TempArr[i];
		}
		Avg = Sum/ARRSIZE;

		// Get current time
		T = time(NULL);
		tm = *localtime(&T);

		// Print the string that is to be sent to the pipe then set it in TempStr array
		printf("%02d/%02d/%04d\t%02d:%02d:%02d\t%f\t%f\n", tm.tm_mday, tm.tm_mon + 1, tm.tm_year + 1900, tm.tm_hour, tm.tm_min, tm.tm_sec, Temp, Avg);
		sprintf(TempStr, "%02d/%02d/%04d\t%02d:%02d:%02d\t%f\t%f", tm.tm_mday, tm.tm_mon + 1, tm.tm_year + 1900, tm.tm_hour, tm.tm_min, tm.tm_sec, Temp, Avg);

		// Try and write the data in TempStr to the pipe
		if (write(FD, TempStr, strlen(TempStr) + 1) == -1)
		{
			fprintf(stderr, "Value of errno: %d\n", errno);
    		fprintf(stderr, "Error closing file: %s\n", strerror(errno));
			exit(EXIT_FAILURE);
		}

		// Wait a second then repeat the same things that happen in the first half of the while loop but with second random number
		sleep(1);
		if ((Temp + R2) > 30 || (Temp + R2) < 0)
		{
			Temp -= R2;
		}
		else
		{
			Temp += R2;
		}

		TempArr[Index] = Temp;
		Index = (Index + 1) % ARRSIZE;
		
		Sum = 0;
		for(int i = 0; i < ARRSIZE; i++)
		{		
			Sum = Sum + TempArr[i];
		}
		Avg = Sum/ARRSIZE;

		T = time(NULL);
		tm = *localtime(&T);

		printf("%02d/%02d/%04d\t%02d:%02d:%02d\t%f\t%f\n", tm.tm_mday, tm.tm_mon + 1, tm.tm_year + 1900, tm.tm_hour, tm.tm_min, tm.tm_sec, Temp, Avg);
		sprintf(TempStr, "%02d/%02d/%04d\t%02d:%02d:%02d\t%f\t%f", tm.tm_mday, tm.tm_mon + 1, tm.tm_year + 1900, tm.tm_hour, tm.tm_min, tm.tm_sec, Temp, Avg);

		if (write(FD, TempStr, strlen(TempStr) + 1) == -1)
		{
			fprintf(stderr, "Value of errno: %d\n", errno);
    		fprintf(stderr, "Error closing file: %s\n", strerror(errno));
			exit(EXIT_FAILURE);
		}
	}
	printf("While loop exited somehow");
}

