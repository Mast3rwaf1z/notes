#include <enhanced_ino.hpp>

#include <krnl.h>
#define init k_init
#define create_task k_crt_task
#define start k_start
#define sleep k_sleep
#define create_queue k_crt_send_Q
#define send k_send
#define isr_receive ki_receive
#define receive k_receive
#define stack_size 150
k_msg_t* queue;
k_msg_t* isr_queue;
int interrupt_pin = 3;
int interrupt_count = 0;
boolean isr_running = false;

void isr(){
    interrupt_count++;
    int in;
    for(int i = 0; i < queue->nr_el; i++){
        isr_receive(queue, &in, new int);
        if(in != 0){
            Serial << "isr received: " << in << endl;
        }
    }
    delay(1000);
    for(int i = 0; i < 6; i++){
        int message = random(1, 11);
        send(isr_queue, &message);
    }
}

void task1(){
    for(;;){
        sleep(1000);
        for(int i = 0; i < 7; i++){
            int message = random(1, 11);
            send(queue, &message);
        }
    }
}

void task2(){
    int recv;
    for(;;){
        receive(isr_queue, &recv, 0, new int);
        if(recv != 0){
            Serial << "Task2 received: " << recv << endl;
        }
    }
}

main(){
    Serial.begin(115200);
    attachInterrupt(digitalPinToInterrupt(interrupt_pin), isr, LOW);
    pinMode(interrupt_pin, INPUT);
    init(2, 0, 2);
    create_task(task1, 1, stack_size, new char[stack_size]);
    create_task(task2, 2, stack_size, new char[stack_size]);
    queue = create_queue(10, sizeof(int), new char[10]);
    isr_queue = create_queue(10, sizeof(int), new char[10]);
    start(1);
}