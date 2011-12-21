void triggerLedPattern(int i){
  
  if (i == 1){
    ledFade(2);
  }
  if (i == 2){
    ledBlink(2, 500);
  }
}



void ledFade(int j){
  for (int k = 0; k < j; k++){
      for (int i = 0; i < 255; i++) { // loop from 0 to 254 (fade in)
        analogWrite(ledPin, i);      // set the LED brightness
        delay(10); // Wait 10ms because analogWrite
                   // is instantaneous and we would
                   // not see any change
      }
    
      for (int i = 255; i >= 0; i--) { // loop from 255 to 1 (fade out)
    
        analogWrite(ledPin, i); // set the LED brightness
        delay(10);           // Wait 10ms
      }
  }
}

void ledBlink(int times, int pause)
{
  for (int i = 0; i < times; i++){
    digitalWrite(ledPin, HIGH);   // sets the LED on
    delay(pause);                  // waits for a second
    digitalWrite(ledPin, LOW);    // sets the LED off
    delay(pause);                  // waits for a second
  }
}

