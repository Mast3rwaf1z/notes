//include this in the top of arduino code to enable a nicer C++ feel
#define main void loop(){} void setup           //disable void loop
#define endl "\n"                               //define endl as known in C++
template<typename T>                            //create typename equivalent to Any in python
Print& operator<<(Print& serial, T value){      //define an operator for Serial equivalent to cout
    serial.print(value);                        //print the value passed to the operator
    return serial;                              //return the printer, in this case Serial
}

#include <krnl.h>
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
    Serial << "running task 1" << endl;
    int counter = 0;
    while(true){
        sleep(1000);
        counter++;
        String message = "message" + counter;
        send(queue, &message);
    }
}

void task2(){
    Serial << "running task 2" << endl;
    String in;
    int loss_count;
    while(true){
        sleep(10000);
        for(int i = 0; i < queue->nr_el; i++){
            receive(queue, &in, 0, &loss_count);
            Serial << "received: " << in << endl;
        }
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
