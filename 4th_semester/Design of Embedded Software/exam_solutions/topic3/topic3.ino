#include <enhanced_ino.hpp>

class super_cool_protocol{
    byte start = 0x2;
    byte escape = 0x10;
    byte escape_scalar = 0x20;
    byte stop = 0x3;
    byte type = 0x2;
    byte dummy_byte = 0xff;
    private:
    enum State{
        escaped,
        not_escaped,
        decode
    };
    State state = not_escaped;
    byte dataframe[(17*2)-2];
    int length = 18;
    void build_dataframe(){
        //layer2
        dataframe[0] = start;                                         //start byte
        dataframe[1] = get_length();                                  //packet length
        //layer3   
        dataframe[2] = type;                                          //packet type
        dataframe[3] = random(0x0, 0xff);                             //ReceiverID low
        dataframe[4] = random(0x0, 0xff);                             //ReceiverID middle
        dataframe[5] = random(0x0, 0xff);                             //ReceiverID high
        dataframe[6] = random(0x0, 0xff);                             //Transducer Level
        dataframe[7] = random(0x0, 0xff);                             //Quiet time
        dataframe[8] = random(0x0, 0xff);                             //Masters in range N
        dataframe[9] = random(0x0, 0xff);                             //RSSI-1
        dataframe[10] = random(0x0, 0xff);                            //TxID_1_LOW
        dataframe[11] = random(0x0, 0xff);                            //TxID_1_MIDDLE
        dataframe[12] = random(0x0, 0xff);                            //TxID_1_HIGH
        dataframe[13] = random(0x0, 0xff);                            //TxID_1_time_low
        dataframe[14] = random(0x0, 0xff);                            //TxID_1_time_high
        //layer 2   
        dataframe[15] = random(0x0, 0xff);                            //checksum lower
        dataframe[16] = random(0x0, 0xff);                            //checksum upper
        dataframe[17] = stop;                                         //stop byte
    }

    public:
    super_cool_protocol(){
        build_dataframe();
    }

    super_cool_protocol(String packet){ //for each char, bytes are seperated by | //
        int next = 0;
        int index = 0;
        for(int length = 0;; length++){
            next = packet.indexOf("|", index+1);
            if(next == -1){
                this->length = length;
                break;
            }
            dataframe[length] = (byte) packet.substring(index, next).toInt();
            index = next+1;
        }
        this->state = escaped;
    }

    State get_state(){
        return state;
    }
    byte* get_dataframe(){
        return dataframe;
    }
    int get_length(){
        //return sizeof(this->dataframe) / sizeof(this->dataframe[0]);
        return length;
    }
    //returns 1 if the state machine was successful, 0 if it failed
    int state_machine(){
        Serial << "Running state machine" << endl;
        switch(state){
            case not_escaped:
                Serial << "converting 0x2, 0x3 and 0x10 to escape chars" << endl;
                
                for(int i = 1; i < get_length() - 1; i++){
                    if(dataframe[i] == start || dataframe[i] == stop || dataframe[i] == escape){
                        int index = i;
                        length++;
                        for(int j = get_length(); j > index; j--){
                            dataframe[j] = dataframe[j-1];
                        }
                        dataframe[index] = escape;
                        dataframe[index+1] = dataframe[index+1] + escape_scalar;
                    }
                }
                state = escaped;
                return 1;
            case escaped:
                Serial << "Restoring 0x2 and 0x3 from escape chars" << endl;
                for(int i = 1; i < get_length() - 1; i++){
                    if(dataframe[i] == escape){
                        int index = i;
                        length--;
                        for(int j = index; j < get_length(); j++){
                            dataframe[j] = dataframe[j+1];
                        }
                        dataframe[index] = dataframe[index] - escape_scalar;
                    }
                }
                return 1;
            case decode:
                return 1;

        }
        return 0;
    }
};
Print& operator<<(Print& printer, super_cool_protocol packet){
    byte* dataframe = packet.get_dataframe();
    int length = packet.get_length();
    printer << "[";
    printer << dataframe[0];
    for(int i = 1; i < length; i++){
        if(dataframe[i] >= 100){
            printer << "," << dataframe[i];
        }
        else{
            printer << ",\t" << dataframe[i];
        }
    }
    printer << "]";
    return printer;
}

main(){
    Serial.begin(115200);
    super_cool_protocol packet = super_cool_protocol();
    Serial << "Dataframe:                \t" << packet << endl;
    Serial << "State:                    \t" << packet.get_state() << endl;
    packet.state_machine();
    Serial << "Dataframe post conversion:\t" << packet << endl;

    packet.state_machine();
    Serial << "Restored dataframe:       \t" << packet << endl;

    //read from serial
    String in;
    for(;;){
        for(;;){
            in = Serial.readString();   //run echo "2|0|16|34|16|35|16|48|16|34|16|35|16|48|16|34|16|35|16|48|16|34|16|35|16|48|16|34|0|3|" >> /dev/ttyACM0 to get an interesting dataframe
            if(in != ""){
                break;
            }
        }
        super_cool_protocol in_packet = super_cool_protocol(in);
        Serial << "from serial:            \t" << in_packet << endl;
        in_packet.state_machine();
        Serial << "converted:              \t" << in_packet << endl;
    }

}