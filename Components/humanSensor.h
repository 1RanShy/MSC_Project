#ifndef HUMANSENSOR_H
#define HUMANSENSOR_H

#include <Arduino.h>

class HumanSensor {

  private:
    int humanSensor = 0;

  public:
    HumanSensor(int humanSensorPin);
    void setPin(int humanSensorPin);
    int getPin();
    int getValue();

};


#endif
