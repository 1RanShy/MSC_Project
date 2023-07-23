#ifndef VIBRATOR_H
#define VIBRATOR_H

#include <Arduino.h>

#define on true
#define off false

class Vibrator
{
  private:
    int led = 0;
    int vibrator = 0;

  public:
    Vibrator(int ledPin, int vibratorPin);
    void setLed(int pin);
    void setVibrator(int pin);
    int getLedPin();
    int getVibratorPin();
    void setStatus(bool flag);
};

#endif
