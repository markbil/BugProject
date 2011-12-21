#include <XBee.h>


// XBEE setup -------------------------------
XBee xbee = XBee();
XBeeResponse response = XBeeResponse();
// create reusable response objects for responses we expect to handle 
Rx16Response rx16 = Rx16Response();
Rx64Response rx64 = Rx64Response();


int pinElwire = 13;
int speakerPin = 10;
int ledPin = 9;

// LED indicating XBee status
int statusLed = 4;
int errorLed = 3;
int dataLed = 5;

int ELWIRE_PATTERN = 1;
int LED_PATTERN = 2;
int SPEAKER_PATTERN = 3;
int ELWIRE_MANUAL = 4;
int LED_MANUAL = 5;
int SPEAKER_MANUAL = 6;


// XBEE setup -------------------------------





//// duration in mSecs, frequency in hertz
//void playTone(long duration, int freq) {
//    duration *= 1000;
//    int period = (1.0 / freq) * 1000000;
//    long elapsed_time = 0;
//    while (elapsed_time < duration) {
//        digitalWrite(pinSpeaker,HIGH);
//        delayMicroseconds(period / 2);
//        digitalWrite(pinSpeaker, LOW);
//        delayMicroseconds(period / 2);
//        elapsed_time += (period);
//    }
//}
    





// flash control LEDs to indicate status of the XBee     
void flashLed(int pin, int times, int wait) {
    
    for (int i = 0; i < times; i++) {
      digitalWrite(pin, HIGH);
      delay(wait);
      digitalWrite(pin, LOW);
      
      if (i + 1 < times) {
        delay(wait);
      }
    }
}

// turn LED on    
void ledOn(int pin) {
      digitalWrite(pin, HIGH);
}

// turn LED off    
void ledOff(int pin) {
      digitalWrite(pin, LOW);
}
