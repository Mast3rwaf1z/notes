#define _ void loop
#define main void setup
_(){}

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
        rotation_count++;
    }
}

void read_and_send_rotation_count(){
    for(;;){
        sleep(10);
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
        int cumulative_distance = (recv - ticks) * calibration_constant;
        Serial.print("distance traveled: "); Serial.print(distance_traveled); Serial.print(" centimeters. cumulative distance: "); 
        Serial.print(cumulative_distance); Serial.println(" centimeters");
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