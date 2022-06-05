#include <enhanced_ino.hpp>

//krnl header for these programs, definitions are for personal use and readability
#include <krnl.h>
#define init k_init
#define create_task k_crt_task
#define start k_start
#define sleep k_sleep
#define create_queue k_crt_send_Q
#define send k_send
#define receive k_receive

#define stack_size 150
k_msg_t* message;
k_msg_t* reply;

void producer_task(){
    Serial << "Started producer task" << endl;
    int message_number = 0;
    int recv;
    for(;;){
        k_eat_msec(1000);                       //busy producer
        message_number++;
        send(message, &message_number);
        receive(reply, &recv, 0, new int);
        Serial << " Received reply #" << recv << endl;
    }
}

void consumer_task(){
    Serial << "Started consumer task" << endl;
    int message_number = 0;
    int recv;
    for(;;){
        message_number++;
        receive(message, &recv, 0, new int);
        send(reply, &message_number);
        Serial << "received message #" << recv;
    }
}

main(){
    Serial.begin(115200);
    init(2, 0, 2);
    create_task(producer_task, 2, stack_size, new char[stack_size]);
    create_task(consumer_task, 1, stack_size, new char[stack_size]);
    message = create_queue(10, sizeof(int), new char[10]);
    reply = create_queue(10, sizeof(int), new char[10]);
    start(1);
}