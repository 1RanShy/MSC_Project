#include <SoftwareSerial.h>
#include "hc_sr04.h"


SoftwareSerial mySerial(4, 0); // RX, TX
SR04 s1(4, 0);
float distance = 0.0;
String test = "1345";
void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(9600);



  Serial.println("Goodnight moon!");

  // set the data rate for the SoftwareSerial port
  mySerial.begin(9600);
  mySerial.println("Hello, world?");
}

void loop() { // run over and over
  
  distance = s1.getDistance();
  
  if (mySerial.available()) {
    mySerial.println("Received");
    test = mySerial.readString();
  }
  mySerial.println("12345");
  Serial.println(test);
  Serial.println("Goodnight moon!");
//  Serial.println("diatance");
  delay(500);

}
