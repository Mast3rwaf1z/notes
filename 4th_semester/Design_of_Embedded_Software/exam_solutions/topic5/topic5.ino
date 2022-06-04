#define _ void loop
#define main void setup
_(){}

#include <krnl.h>
#define init k_init
#define create_task k_crt_task
#define start k_start
#define sleep k_sleep

#define stack_size 150
int v = 0;

main(){                                                             //equivalent to int main
    init(2, 0, 0);
    auto print_v = []{while(true){                                  //define task
        sleep(100);                                                 //sleep for 100 ms
        Serial.println(v);                                          //do task
    }};
    auto increment_v = []{while(true){                              //define task
        sleep(2000);                                                //sleep for 2000 ms
        v++;                                                        //do task
    }};
    Serial.begin(115200);                                           //init serial
    create_task(print_v, 1, stack_size, new char[stack_size]);      //create higher prio task
    create_task(increment_v, 2, stack_size, new char[stack_size]);  //create lower prio task
    start(1);                                                       //start krnl tasks
}