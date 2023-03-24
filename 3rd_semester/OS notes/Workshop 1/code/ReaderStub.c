#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

/*
This program is made to read the data sent from the temeperature stub throught the FIFO file.
All it does is open the fifo file, wait half a second, then start reading in a while loop every second.
Will close if no data is received for 6 seconds
*/

// Errno source code https://www.tutorialspoint.com/c_standard_library/c_macro_errno.htm
extern int errno;
int FD;
char TempStr[50];

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

void ExitProg()
{
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
int mypipe ()
{
    printf("Started program\n");

	signal(SIGINT, Sig_Handler);
	
	char * myFIFO = "/tmp/myfifo";
    FD = open(myFIFO, O_RDONLY);
    if (FD == NULL)
	{
		fprintf(stderr, "Value of errno: %d\n", errno);
    	fprintf(stderr, "Error opening file: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	int NoDataCnt = 0;
    sleep(0.5);
    while(1)
    {
        sleep(1);
		int R = read(FD, TempStr, 50);
        if (R == -1)
		{
			fprintf(stderr, "Value of errno: %d\n", errno);
    		fprintf(stderr, "Error closing file: %s\n", strerror(errno));
			ExitProg();
		}
		else if (R == 0)
		{
			if(NoDataCnt > 5)
			{
				ExitProg();
			}
			else
			{
				NoDataCnt++;
				sprintf(TempStr, "NULL");
			}
		}
		else
		{
			NoDataCnt = 0;
		}
        printf("From FIFO read:\n%s\n", TempStr);
		//printf("Read returned: %i", R);
    }
}