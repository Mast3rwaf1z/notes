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
k_msg_t* scheduler;
k_msg_t* status_queue;
#define floor_count 10

void monitor_buttons(){                                 //Service request
    Serial << "Started service request task" << endl;
    int recv, in;
    for(;;){
        sleep(10);
        in = Serial.read();                             //read from serial to simulate buttons, this is Monitor Floor Buttons
        if(in != 10 && in != -1){
            recv = in - 48;
            send(scheduler, &recv);
        }
    }
}

int get_from_scheduler(){                                       //Scheduler, should output where to move the elevator next
    int recv;
    receive(scheduler, &recv, 0, new int);
    return recv;
}

void run_elevator(){
    Serial << "Started run elevator task" << endl;
    int elevator_status = 0;
    int next_floor = 0;
    for(;;){
        sleep(10);
        if(elevator_status == next_floor){
            next_floor = get_from_scheduler();
            if(next_floor == -1){
                continue;
            }

        }
        else if(elevator_status < next_floor){
            elevator_status++;
            k_eat_msec(100);
            send(status_queue, &elevator_status);
        }
        else{
            elevator_status--;
            k_eat_msec(100);
            send(status_queue, &elevator_status);
        }
    }
}

void status(){
    Serial << "Started status printing task" << endl;
    int elevator_status;
    for(;;){
        sleep(1000);
        receive(status_queue, &elevator_status, -1, new int);
        if(elevator_status == 0){
            Serial << "Elevator is at ground floor" << endl;
        }
        else{
            Serial << "Elevator is at floor #" << elevator_status << endl;
        }
    }
}

main(){
    Serial.begin(115200);
    init(3, 0, 2);
    create_task(monitor_buttons, 1, stack_size, new char[stack_size]);
    create_task(run_elevator, 2, stack_size, new char[stack_size]);
    create_task(status, 3, stack_size, new char[stack_size]);
    scheduler = create_queue(10, sizeof(int), new char[10]);
    status_queue = create_queue(10, sizeof(int), new char[10]);
    start(1);
}