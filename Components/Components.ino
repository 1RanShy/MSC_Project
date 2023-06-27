#include "vibrator.h"
#include "humanSensor.h"
Vibrator v1(14, 15);
HumanSensor h1(16);
void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200);
}

void loop()
{
  // put your main code here, to run repeatedly:
  //  v1.setStatus(on);
  //  delay(500);
  //
  //  v1.setStatus(off);
  //  delay(500);

  Serial.println("Hello World");
  Serial.println(h1.getValue());
  delay(1000);
}
