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
int interrupt_pin = 3;
int interrupt_count = 0;

void isr(){
    interrupt_count++;
    Serial << "isr " << interrupt_count << endl;
    int in, lost;
    for(int i = 0; i < queue->nr_el; i++){
        receive(queue, &in, 0, &lost);
        Serial.println(in);
    }
}

void task(){
    while(true){
        int message = 1;
        sleep(1000);
        send(queue, &message);
    }
}

main(){
    Serial.begin(115200);
    attachInterrupt(digitalPinToInterrupt(interrupt_pin), isr, LOW);
    pinMode(interrupt_pin, INPUT_PULLUP);
    init(1, 0, 1);
    create_task(task, 1, stack_size, new char[stack_size]);
    queue = create_queue(10, sizeof(int), new char[10]);
    start(1);
}