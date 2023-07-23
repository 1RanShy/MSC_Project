#include "hc_sr04.h"

SR04::SR04(int echoPin, int trigPin)
{
  echo = echoPin;
  trig = trigPin;
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
}

float SR04::getDistance()
{
  digitalWrite(trig, LOW);
  delayMicroseconds(2);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  duration = pulseIn(echo, HIGH);
  float distance = (duration * .0343) / 2;
  Serial.print("Distance: ");
  Serial.println(distance);

  return distance;
}

void SR04::setEcho(int echoPin)
{
  echo = echoPin;
}

int SR04::getEcho()
{
  return echo;
}

void SR04::setTrig(int trigPin)
{
  trig = trigPin;
}

int SR04::getTrig()
{
  return trig;
}
