#ifndef HC_SR04_h
#define HC_SR04_h

#include <Arduino.h>
class SR04
{
  private:
    int echo = 0;
    int trig = 0;
    float duration, distance;
  public :

    SR04(int echoPin, int trigPin);

    float getDistance();


    void setEcho(int echoPin);


    int getEcho();


    void setTrig(int trigPin);


    int getTrig();

};

#endif
