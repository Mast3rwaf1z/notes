//include this in the top of arduino code to enable a nicer C++ feel
#define main void loop(){} void setup           //disable void loop
#define endl "\n"                               //define endl as known in C++
template<typename T>                            //create typename equivalent to Any in python
Print& operator<<(Print& serial, T value){      //define an operator for Serial equivalent to cout
    serial.print(value);                        //print the value passed to the operator
    return serial;                              //return the Serial object
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



const int calibration_constant = 10;
int rotation_count = 0;

void shaft_rotation_counter(){
    for(;;){
        sleep(100);
        rotation_count++;
        send(queue, &rotation_count);
    }
}

void determine_distance(){
    int recv = 0;
    int ticks = 0;
    for(;;){
        ticks++;
        sleep(10);
        receive(queue, &recv, 0, NULL);
        int distance_traveled = recv * calibration_constant;
        Serial << "Distance traveled: " << distance_traveled << " centimeters" << endl;
    }
}

main(){
    Serial.begin(115200);
    init(2, 0, 1);
    queue = create_queue(10, 10, new char*);
    create_task(shaft_rotation_counter, 1, stack_size, new char[stack_size]);
    create_task(determine_distance, 1, stack_size, new char[stack_size]);
    start(1);
}