//include this in the top of arduino code to enable a nicer C++ feel
#define main void loop(){} void setup           //disable void loop
#define endl "\n"                               //define endl as known in C++
template<typename T>                            //create typename equivalent to Any in python
Print& operator<<(Print& serial, T value){      //define an operator for Serial equivalent to cout
    serial.print(value);                        //print the value passed to the operator
    return serial;                              //return the printer, in this case Serial
}


const int ledpin = 13;
const int interrupt2 = 2;
const int interrupt3 = 3;
const int interrupt8 = 8;
volatile boolean state = LOW;

void high(){
    if(!state){
        digitalWrite(ledpin, HIGH);
        Serial << "Set LED high" << endl;
        state = HIGH;
    }
}

void low(){
    if(state){
        digitalWrite(ledpin, LOW);
        Serial << "Set LED low" << endl;
        state = LOW;
    }
}

main(){
    pinMode(ledpin, OUTPUT);
    pinMode(interrupt2, INPUT_PULLUP);
    pinMode(interrupt3, INPUT_PULLUP);
    pinMode(interrupt8, INPUT_PULLUP);
    Serial.begin(115200);
    digitalWrite(ledpin, LOW);
    attachInterrupt(digitalPinToInterrupt(interrupt2), low, LOW);
    attachInterrupt(digitalPinToInterrupt(interrupt3), high, LOW);
}