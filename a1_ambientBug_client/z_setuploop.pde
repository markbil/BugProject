void setup(void)
{

  pinMode(statusLed, OUTPUT);
  pinMode(errorLed, OUTPUT);
  pinMode(dataLed,  OUTPUT);
  
  pinMode(pinElwire, OUTPUT);
  pinMode(speakerPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  
  xbee.begin(9600);
  flashLed(statusLed, 3, 50);
}


void loop(void)
{ 
    xbee.readPacket();
    
    if (xbee.getResponse().isAvailable()) {
      // got something
      
      if (xbee.getResponse().getApiId() == RX_16_RESPONSE || xbee.getResponse().getApiId() == RX_64_RESPONSE) {
        // got a rx packet
        
        if (xbee.getResponse().getApiId() == RX_16_RESPONSE) {
                xbee.getResponse().getRx16Response(rx16);
                
                flashLed(statusLed, 2, 50);
                
                //VALUE 1 determines which object is used (1 = elwire, 2 = led, 3 = speaker)
                uint8_t analogHigh = rx16.getData(0);
                uint8_t analogLow = rx16.getData(1);
                int medium1 = analogLow + (analogHigh * 256);
                
                
                if (medium1 == ELWIRE_MANUAL) {
                    //do action for elwire
                        ledOn(dataLed);
                        
                        //READ VALUE2
                        uint8_t analogHigh2 = rx16.getData(2);
                        uint8_t analogLow2 = rx16.getData(3);
                        int value2 = analogLow2 + (analogHigh2 * 256);                
                        
                        //READ VALUE3
                        uint8_t analogHigh3 = rx16.getData(4);
                        uint8_t analogLow3 = rx16.getData(5);
                        int value3 = analogLow3 + (analogHigh3 * 256); 
                        
                        //READ VALUE4
                        uint8_t analogHigh4 = rx16.getData(6);
                        uint8_t analogLow4 = rx16.getData(7);
                        int value4 = analogLow4 + (analogHigh4 * 256); 
                        
                        elwire(pinElwire, value2, value3, value4);
                        ledOff(dataLed);
                }
                
                else if (medium1 == ELWIRE_PATTERN){
                    //do action for speaker
                        ledOn(dataLed);
                        //READ VALUE2
                        uint8_t speakerHigh = rx16.getData(2);
                        uint8_t speakerLow = rx16.getData(3);
                        int pattern_nr = speakerLow + (speakerHigh * 256); 
                        
                        //flashLed(errorLed, pattern_nr, 50);
                        //play_rtttl_pattern(pattern_nr);
                        //play_rtttl(song4);
                        triggerElwirePattern(pattern_nr);
                        ledOff(dataLed);
                 }
                
                else if (medium1 == SPEAKER_PATTERN){
                    //do action for speaker
                        ledOn(dataLed);
                        //READ VALUE2
                        uint8_t speakerHigh = rx16.getData(2);
                        uint8_t speakerLow = rx16.getData(3);
                        int pattern_nr = speakerLow + (speakerHigh * 256); 
                        
                        flashLed(errorLed, pattern_nr, 50);
                        //play_rtttl_pattern(pattern_nr);
                        //play_rtttl(song4);
                        triggerSpeakerPattern(pattern_nr);
                        ledOff(dataLed);
                 }
                 
                 else if (medium1 == LED_PATTERN){
                    //do action for speaker
                        ledOn(dataLed);
                        //READ VALUE2
                        uint8_t speakerHigh = rx16.getData(2);
                        uint8_t speakerLow = rx16.getData(3);
                        int pattern_nr = speakerLow + (speakerHigh * 256); 
                        
                        //flashLed(errorLed, pattern_nr, 50);
                        //play_rtttl_pattern(pattern_nr);
                        //play_rtttl(song4);
                        triggerLedPattern(pattern_nr);
                        ledOff(dataLed);
                 }
                 
                  
                flashLed(statusLed, 2, 50);
                
        } else {
                xbee.getResponse().getRx64Response(rx64);

        }
        
        flashLed(statusLed, 1, 10);
        
      } else {
      	// not something we were expecting
        flashLed(errorLed, 1, 25);    
      }
    }
 
}
