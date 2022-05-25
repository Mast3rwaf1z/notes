#include <krnl.h>

const int led_pin = 13;
#define stack_size 150
char task1_stack[stack_size];
char task2_stack[stack_size];

void loop1(){
    while(true){
        k_sleep(50);
        digitalWrite(led_pin, LOW);
        k_sleep(50);
        digitalWrite(led_pin, HIGH);
    }
}

void loop2(){
    int counter = 0;
    while(true){
        k_sleep(400);
        counter++;
        Serial.println(counter);
    }
}

void setup(){
    pinMode(led_pin, OUTPUT);
    digitalWrite(led_pin, LOW);
    Serial.begin(115200);
    k_init(2, 0, 0);
    k_t* task_1 = k_crt_task(loop1, 1, stack_size, task1_stack);
    k_t* task_2 = k_crt_task(loop2, 1, stack_size, task2_stack);
    int res = k_start(1);
    for(;;);
}

void loop(){}
