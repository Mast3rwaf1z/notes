//include this in the top of arduino code to enable a nicer C++ feel
//credit: https://about.skademaskinen.win/
#define main void loop(){} void setup           //disable void loop
#define endl "\n"                               //define endl as known in C++
template<typename T>                            //create typename equivalent to Any in python
Print& operator<<(Print& serial, T value){      //define an operator for Serial equivalent to cout
    serial.print(value);                        //print the value passed to the operator
    return serial;                              //return the printer, in this case Serial
}

//krnl header for these programs, definitions are for personal use and simplicity
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

void add_floor(){
    for(;;){
        String in = Serial.readStringUntil('\n');
        if(in != ""){
            Serial << in << endl;
            send(queue, &in);
        }
    }
}

main(){
    Serial.begin(115200);
}