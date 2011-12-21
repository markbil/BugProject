#include <XBee.h>
#include <SPI.h>
#include <Ethernet.h>

//---  XBEE-SETUP ---------------------------

XBee xbee = XBee();
unsigned long start = millis();

// allocate two bytes for to hold a 10-bit analog reading
uint8_t payload[9]; // payload array lenght needs to be one higher than the number of bytes to be transmitted

// 16-bit addressing: Enter address of remote XBee, typically the coordinator
Tx16Request tx_5001 = Tx16Request(0x5001, payload, sizeof(payload));
Tx16Request tx_5002 = Tx16Request(0x5002, payload, sizeof(payload));
Tx16Request tx_5003 = Tx16Request(0x5003, payload, sizeof(payload));
Tx16Request tx_5004 = Tx16Request(0x5004, payload, sizeof(payload));
Tx16Request tx_5005 = Tx16Request(0x5005, payload, sizeof(payload));
TxStatusResponse txStatus = TxStatusResponse();

//values to be transmitted 10 Bit, i.e. (0-1023)
//int value1 = 1;
//int value2 = 0;

//* Ethernet shield attached to pins 10, 11, 12, 13

int statusLed = 6;
int errorLed = 7;

int ELWIRE_PATTERN = 1;
int LED_PATTERN = 2;
int SPEAKER_PATTERN = 3;
int ELWIRE_MANUAL = 4;
int LED_MANUAL = 5;
int SPEAKER_MANUAL = 6;


//--- ETHERNET / WEBDUINO SETUP--------------

#define WEBDUINO_FAIL_MESSAGE "<h1>Request Failed</h1>"
#include "SPI.h" // new include
#include "avr/pgmspace.h" // new include
#include "Ethernet.h"
#include "WebServer.h"

#define VERSION_STRING "0.1"

#define PREFIX ""
WebServer webserver(PREFIX, 80);

#define NAMELEN 32
#define VALUELEN 32


static uint8_t mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
static uint8_t ip[] = { 192, 168, 0, 102 };

P(Page_start) = "<html><head><title>Web_Parms_1 Version " VERSION_STRING "</title></head><body>\n";
P(Page_end) = "</body></html>";
P(Get_head) = "<h1>GET from ";
P(Post_head) = "<h1>POST to ";
P(Unknown_head) = "<h1>UNKNOWN request for ";
P(Default_head) = "unidentified URL requested.</h1><br>\n";
P(Raw_head) = "raw.html requested.</h1><br>\n";
P(Parsed_head) = "parsed.html requested.</h1><br>\n";
P(Good_tail_begin) = "URL tail = '";
P(Bad_tail_begin) = "INCOMPLETE URL tail = '";
P(Tail_end) = "'<br>\n";
P(Parsed_tail_begin) = "URL parameters:<br>\n";
P(Parsed_item_separator) = " = '";
P(Params_end) = "End of parameters<br>\n";
P(Post_params_begin) = "Parameters sent by POST:<br>\n";
P(Line_break) = "<br>\n";












