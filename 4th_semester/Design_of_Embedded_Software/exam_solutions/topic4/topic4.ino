#define _ void loop
#define main void setup
_(){}

#include <krnl.h>
#define init k_init
#define create_task k_crt_task
#define start k_start
#define sleep k_sleep

const int led_pin = 13;
#define stack_size 150
char task1_stack[stack_size];
char task2_stack[stack_size];

void loop1(){
    while(true){
        sleep(50);
        digitalWrite(led_pin, LOW);
        sleep(50);
        digitalWrite(led_pin, HIGH);
    }
}

void loop2(){
    int counter = 0;
    while(true){
        sleep(400);
        counter++;
        Serial.println(counter);
    }
}

main(){
    pinMode(led_pin, OUTPUT);
    digitalWrite(led_pin, LOW);
    Serial.begin(115200);
    k_init(2, 0, 0);
    create_task(loop1, 1, stack_size, task1_stack);
    create_task(loop2, 1, stack_size, task2_stack);
    int res = start(1);
    for(;;);
}

