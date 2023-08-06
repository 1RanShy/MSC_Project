#include "vibrator.h"
#include "humanSensor.h"
#include "hc_sr04.h"
#include "gp2y0a0yk0f.h"

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200);
}

void loop()
{
  // put your main code here, to run repeatedly:
  //  vibratorTest();
  //humanSensorTest();
  //  sr04Test();

    testInfrared();

}
void sr04Test()
{
  SR04 d1(10, 9);
  d1.getDistance();
  delay(500);
}


void humanSensorTest()
{
  HumanSensor h1(16);
  Serial.println(h1.getValue());
  delay(1000);
}


void vibratorTest()
{
  Vibrator v1(14, 15);

  //  v1.setStatus(on);
  delay(500);

  v1.setStatus(off);
  delay(500);

}

void testInfrared()
{
  int distance = 0;
  GP2Y0A02YK0F irSensor(A0);
  distance = irSensor.getDistanceCentimeter();
  Serial.print("\nDistance in centimeters: ");
  Serial.print(distance);
  delay(500);
}
