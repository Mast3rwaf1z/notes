#include <enhanced_ino.hpp>


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