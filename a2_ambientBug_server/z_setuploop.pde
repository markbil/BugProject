void setup(void)
{
  
  // start ethernet and server:
  Ethernet.begin(mac, ip);
  //this command is called if a page is called that is not on the server
  webserver.setFailureCommand(&my_failCmd);
  //This command  is called if you try to load /parsed.html
  webserver.setDefaultCommand(&helloCmd);
  webserver.addCommand("elwire.html", &elwireCmd);
  webserver.addCommand("elwire_manual.html", &elwireCmd_manual);
  webserver.addCommand("led.html", &ledCmd);
  webserver.addCommand("speaker.html", &speakerCmd);
  webserver.begin();

  // initialise xbee feedback LEDs
  pinMode(statusLed, OUTPUT);
  pinMode(errorLed, OUTPUT);
  
  //start XBees
  xbee.begin(9600);
  
  Serial.begin(9600);

}


void loop(void)
{ 
  
    char buff[64];
    int len = 64;
    webserver.processConnection(buff, &len);
  
}
