#include <enhanced_ino.hpp>

#define pin 3

void func(){
    Serial << "Here!" << endl;
}


main(){
    Serial.begin(115200);
    pinMode(pin, INPUT);
    attachInterrupt(digitalPinToInterrupt(pin), func, LOW);
}