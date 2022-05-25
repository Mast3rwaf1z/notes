#include <krnl.h>
#define stack_size 150
int v = 0;

void setup(){                                                       //equivalent to int main
    k_init(2, 0, 0);
    auto print_v = []{while(true){                                  //define task
        k_sleep(100);                                               //sleep for 100 ms
        Serial.println(v);                                          //do task
    }};
    auto increment_v = []{while(true){                              //define task
        k_sleep(2000);                                              //sleep for 2000 ms
        v++;                                                        //do task
    }};
    Serial.begin(115200);                                           //init serial
    k_crt_task(print_v, 1, stack_size, new char[stack_size]);       //create higher prio task
    k_crt_task(increment_v, 2, stack_size, new char[stack_size]);   //create lower prio task
    k_start(1);                                                     //start krnl tasks
}

void loop(){}                                                       //never runs