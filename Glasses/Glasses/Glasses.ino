#include "vibrator.h"
#include "hc_sr04.h"
#include "gp2y0a0yk0f.h"
Vibrator v1(5, 16);
SR04 s1(4, 0);

float distance = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(4, INPUT);//右边第三个引脚
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:

  distance = s1.getDistance();

  if (distance <= 50.0)
  {

    v1.setStatus(true);
  }
  else
  {

    v1.setStatus(false);

  }
  delay(500);

  Serial.println("diatance");
}

void testInfrared()
{
  int distance = 0;
  GP2Y0A02YK0F irSensor(A0);
  distance = irSensor.getDistanceCentimeter();
  Serial.print("\nDistance in centimeters: ");
  Serial.print(distance);
  delay(2000);
}
