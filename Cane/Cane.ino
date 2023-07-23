#include <SoftwareSerial.h>
#include "hc_sr04.h"

SoftwareSerial mySerial(2, 3); // RX, TX
SR04 s1(13, 12); //echo trig
float distance = 0.0;
String x = "xxx";
float setDistance = 50;
void setup() {
  // Open serial communications and wait for port to open:
  Serial.begin(9600);
  mySerial.begin(9600);

}

void loop() { // run over and over

  distance = s1.getDistance();
  if (mySerial.available()) {

    x = mySerial.readString();
    if (x == "20")
    {
      setDistance = 20;
    }
    if (x == "40")
    {
      setDistance = 40;
    }

    if (x == "60")
    {
      setDistance = 60;
    }
    if (x == "80")
    {
      setDistance = 80;
    }

    if (x == "100")
    {
      setDistance = 100;
    }
    if (x == "150")
    {
      setDistance = 150;
    }
    if (x == "200")
    {
      setDistance = 200;
    }
  }
  if (distance <= setDistance)
  {
    mySerial.println("Unsafe");
  }
  else
  {
    mySerial.println("Safe");
  }
  mySerial.println(distance);
  Serial.println(x);
  delay(500);

}
