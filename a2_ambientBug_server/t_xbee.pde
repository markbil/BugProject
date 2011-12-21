/*
address: XBee ID of the destination XBee
bugnr: number of the destination Bug
object: 1 = EL-wire, 2 = LEDS, 3 = Speaker
pattern: tba
*/



void sendToXBee(int address, int medium, int pattern){

  // start transmitting after a startup delay.  Note: this will rollover to 0 eventually so not best way to handle
    if (millis() - start > 1000) {  //15000
    
          //Data INTO PAYLOAD
          //break down 10-bit reading into two bytes and place in payload
      
          //value1 INTO PAYLOAD
          payload[0] = medium >> 8 & 0xff;  // payload[0] = MSB.  
          payload[1] = medium & 0xff;      // 0xff = 1111 1111, i.e. cuts of the MSB from pin5 and all is left is the LSB
          
          //value2 INTO PAYLOAD
          payload[2] = pattern >> 8 & 0xff;
          payload[3] = pattern & 0xff; //LSB
            
             
          switch (address)
          {
          case 5001:
              xbee.send(tx_5001);
              break;
          case 5002:
              xbee.send(tx_5002);
              break;
          case 5003:
              xbee.send(tx_5003);
              break;
          case 5004:
              xbee.send(tx_5004);
              break;
          case 5005:
              xbee.send(tx_5005);
              break;    
          }  
             
    
          // flash TX indicator
          flashLed(statusLed, 1, 100);
    }
  
    // after sending a tx request, we expect a status response
    // wait up to 5 seconds for the status response
    if (xbee.readPacket(5000)) {
        // got a response!

        // should be a znet tx status            	
    	if (xbee.getResponse().getApiId() == TX_STATUS_RESPONSE) {
    	   xbee.getResponse().getZBTxStatusResponse(txStatus);
    		
    	   // get the delivery status, the fifth byte
           if (txStatus.getStatus() == SUCCESS) {
            	// success.  time to celebrate
             	flashLed(statusLed, 5, 50);
           } else {
            	// the remote XBee did not receive our packet. is it powered on?
             	flashLed(errorLed, 3, 500);
           }
        }      
    } else {
      // local XBee did not provide a timely TX Status Response -- should not happen
      flashLed(errorLed, 2, 50);
    }
    
    delay(2000);
}

//sends manual commands to an XBee
void sendToXBee_elwire_manual(int address, int onsec, int offsec, int repetition){

  // start transmitting after a startup delay.  Note: this will rollover to 0 eventually so not best way to handle
    if (millis() - start > 3000) {  //15000
          
          int medium = ELWIRE_MANUAL; //4
          
          //Data INTO PAYLOAD
          //break down 10-bit reading into two bytes and place in payload
      
          //medium code: elwire_manual
          payload[0] = ELWIRE_MANUAL >> 8 & 0xff;  // payload[0] = MSB.  
          payload[1] = ELWIRE_MANUAL & 0xff;
          
          //value1 INTO PAYLOAD
          payload[2] = onsec >> 8 & 0xff;  // payload[0] = MSB.  
          payload[3] = onsec & 0xff;      // 0xff = 1111 1111, i.e. cuts of the MSB from pin5 and all is left is the LSB
          
          //value2 INTO PAYLOAD
          payload[4] = offsec >> 8 & 0xff;
          payload[5] = offsec & 0xff; //LSB
          
          //value3 INTO PAYLOAD
          payload[6] = repetition >> 8 & 0xff;
          payload[7] = repetition & 0xff; //LSB
            
             
          switch (address)
          {
          case 5001:
              xbee.send(tx_5001);
              Serial.print("sending data to xbee 5001");
              break;
          case 5002:
              xbee.send(tx_5002);
              Serial.print("sending data to xbee 5002");
              break;
          case 5003:
              xbee.send(tx_5003);
              Serial.print("sending data to xbee 5003");              
              break;
          case 5004:
              xbee.send(tx_5004);
              Serial.print("sending data to xbee 5004");
              break;
          case 5005:
              xbee.send(tx_5005);
              Serial.print("sending data to xbee 5005");
              break;    
          }  
             
    
          // flash TX indicator
          flashLed(statusLed, 1, 100);
    }
  
    // after sending a tx request, we expect a status response
    // wait up to 5 seconds for the status response
    if (xbee.readPacket(5000)) {
        // got a response!

        // should be a znet tx status            	
    	if (xbee.getResponse().getApiId() == TX_STATUS_RESPONSE) {
    	   xbee.getResponse().getZBTxStatusResponse(txStatus);
    		
    	   // get the delivery status, the fifth byte
           if (txStatus.getStatus() == SUCCESS) {
            	// success.  time to celebrate
             	flashLed(statusLed, 5, 50);
           } else {
            	// the remote XBee did not receive our packet. is it powered on?
             	flashLed(errorLed, 3, 500);
           }
        }      
    } else {
      // local XBee did not provide a timely TX Status Response -- should not happen
      flashLed(errorLed, 2, 50);
    }
    
    delay(2000);
}

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
