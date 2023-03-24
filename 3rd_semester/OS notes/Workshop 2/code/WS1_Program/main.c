#include<stdio.h>
#include<string.h>
#include<pthread.h>
#include<fcntl.h>
#include"ReaderStub.c"

char current[200000000];
char buffer[255];
char laststr[50];

void *myFileReader(){
    FILE* myfile = fopen("data", "r");
    while (fgets(buffer, sizeof(buffer), myfile))
    {
        strcat(current, buffer);
    }
    fclose(myfile);
    return 0;
}

void *myFileWriter(char *data){
    FILE* myfile = fopen("data", "w");
    fwrite(data, sizeof(data[0]), strlen(data), myfile);
    fclose(myfile);
    return 0;
}

void *writeThread(void *vargp){
    myFileReader();
    printf("read from the data file\n");
    while(1){
        if (laststr != TempStr){
            sleep(1);
            printf("writing new data to file\n");
            strcat(TempStr, "\n");
            myFileWriter(strcat(current, TempStr));
            strcpy(laststr, TempStr);
        }
    }
}

void *readPipe(void *vargp){
    printf("reading from pipe\n");
    mypipe();
}


int main(){
    pthread_t threads[2];
    printf("creating threads\n");
    pthread_create(&threads[0], NULL, readPipe, NULL);
    pthread_create(&threads[1], NULL, writeThread, NULL);
    pthread_join(threads, NULL);

    return 0;
}