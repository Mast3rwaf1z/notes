#include <enhanced_ino.hpp>

class myprotocol{
    byte start = 0x2;
    byte escape = 0x10;
    byte escape_scalar = 0x20;
    byte stop = 0x3;
    byte type = 0xf;
    byte dummy_byte = 0xff;
    private:
    enum State{
        convert_escape,
        restore
    };
    State state = convert_escape;
    byte dataframe[18];
    void build_dataframe(){
        //layer2
        this->dataframe[0] = start;                                         //start byte
        this->dataframe[1] = this->length();                                //packet length
        //layer3   
        this->dataframe[2] = type;                                          //packet type
        this->dataframe[3] = random(0x0, 0xff);                             //ReceiverID low
        this->dataframe[4] = random(0x0, 0xff);                             //ReceiverID middle
        this->dataframe[5] = random(0x0, 0xff);                             //ReceiverID high
        this->dataframe[6] = random(0x0, 0xff);                             //Transducer Level
        this->dataframe[7] = random(0x0, 0xff);                             //Quiet time
        this->dataframe[8] = random(0x0, 0xff);                             //Masters in range N
        this->dataframe[9] = random(0x0, 0xff);                             //RSSI-1
        this->dataframe[10] = random(0x0, 0xff);                            //TxID_1_LOW
        this->dataframe[11] = random(0x0, 0xff);                            //TxID_1_MIDDLE
        this->dataframe[12] = random(0x0, 0xff);                            //TxID_1_HIGH
        this->dataframe[13] = random(0x0, 0xff);                            //TxID_1_time_low
        this->dataframe[14] = random(0x0, 0xff);                            //TxID_1_time_high
        //layer 2   
        this->dataframe[15] = start;                                   //checksum lower
        this->dataframe[16] = dummy_byte;                                   //checksum upper
        this->dataframe[17] = stop;                                         //stop byte
    }

    public:
    myprotocol(){
        build_dataframe();
    }
    myprotocol(byte dataframe[]){

    }
    State get_state(){
        return this->state;
    }
    byte* get_dataframe(){
        return this->dataframe;
    }
    int length(){
        return sizeof(this->dataframe) / sizeof(this->dataframe[0]);
    }
    //returns 1 if the state machine was successful, 0 if it failed
    int state_machine(){
        Serial << "Running state machine" << endl;
        switch(this->state){
            case convert_escape:
                Serial << "converting 0x2 and 0x3 to escape chars" << endl;
                
                for(int i = 1; i < this->length()-1; i++){
                    if(this->dataframe[i] == 0x2 || this->dataframe[i] == 0x3){
                        int index = i;
                        for(int i = index; i < this->length(); i++){
                            this->dataframe[i] = this->dataframe[i-1];
                        }
                    }
                }
                return 1;
                break;
            case restore:
                return 1;
                break;
        }
        return 0;
    }
};

main(){
    Serial.begin(115200);
    myprotocol packet = myprotocol();
    byte* dataframe = packet.get_dataframe();
    Serial << "Dataframe:                   ";
    for(int i = 0; i < packet.length(); i++){
        Serial << dataframe[i] << " ";
    }
    Serial << endl;
    Serial << "State:                       " << packet.get_state() << endl;
    packet.state_machine();
    Serial << "Dataframe post conversion:   ";
    for(int i = 0; i < packet.length(); i++){
        Serial << dataframe[i] << " ";
    }
    Serial << endl;
}