#include <enhanced_ino.hpp>

#define arrsize 100

main(){
    Serial.begin(115200);
    double da[arrsize];
    for(int i = 0; i < arrsize; i++){
        da[i] = random(-5, 5);
        Serial.println(da[i]);
    }
}