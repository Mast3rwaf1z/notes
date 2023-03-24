#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

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
    FD = open(myFIFO, O_RDONLY);
    if (FD == NULL)
	{
		fprintf(stderr, "Value of errno: %d\n", errno);
    	fprintf(stderr, "Error opening file: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	char TempStr[50];
    sleep(0.5);
    while(1)
    {
        sleep(1);
        read(FD, TempStr, 80);
        printf("Read %s from FIFO\n", TempStr);
    }
}