void triggerElwirePattern(int i){
  
  if (i == 1){
    elwire(pinElwire, 1, 1, 3);
  }
  if (i == 2){
    elwire(pinElwire, 2, 2, 1);
  }
}

void elwire(int pin, int onsec, int offsec, int blinktimes){
    for (int i = 0; i < blinktimes; i++){
      digitalWrite(pin, HIGH);   // set the LED on
      delay(onsec * 1000);       // wait for a second
      digitalWrite(pin, LOW);    // set the LED off
      delay(offsec * 1000);      // wait for a second
  }
}
