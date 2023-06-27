#include "humanSensor.h"

HumanSensor::HumanSensor(int humanSensorPin)
{
  humanSensor = humanSensorPin;
  pinMode(humanSensor, INPUT);
}

void HumanSensor::setPin(int humanSensorPin)
{
  humanSensor = humanSensorPin;
}

int HumanSensor::getPin()
{
  return humanSensor;
}

int HumanSensor::getValue()
{
  return digitalRead(humanSensor);
}
