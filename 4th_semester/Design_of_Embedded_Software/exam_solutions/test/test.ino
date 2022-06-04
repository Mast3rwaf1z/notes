#include <krnl.h>
#define main void setup
#define _ void loop
_(){}//irrelevant

#define init k_init
#define create_task k_crt_task
#define start k_start
#define sleep k_sleep
#define create_queue k_crt_send_Q
#define send k_send
#define receive k_receive
#define stack_size 150
k_msg_t* queue;


void task1(){
    Serial.println("running task 1");
    int counter = 0;
    while(true){
        sleep(1000);
        counter++;
        String message = "message" + counter;
        send(queue, &message);
    }
}

void task2(){
    Serial.println("running task 2");
    String in;
    int loss_count;
    while(true){
        sleep(10000);
        for(int i = 0; i < queue->nr_el; i++){
            receive(queue, &in, 0, &loss_count);
            Serial.print("received: "); Serial.println(in);
        }
        Serial.println("");
    }
}

main(){
    Serial.begin(115200);
    init(2, 0, 1);
    create_task(task1, 1, stack_size, new char[stack_size]);
    create_task(task2, 1, stack_size, new char[stack_size]);
    queue = create_queue(10, sizeof(String), new char[10]);
    start(1);
}
