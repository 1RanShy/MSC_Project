
#include "vibrator.h"

Vibrator::Vibrator(int ledPin, int vibratorPin)
{
  led = ledPin;
  vibrator = vibratorPin;

  pinMode(led, OUTPUT);
  pinMode(vibrator, OUTPUT);
}

void Vibrator::setLed(int pin)
{
  led = pin;
}

void Vibrator::setVibrator(int pin)
{
  vibrator = pin;
}

int Vibrator::getLedPin()
{
  return led;
}
int Vibrator::getVibratorPin()
{
  return vibrator;
}

void Vibrator::setStatus(bool flag)
{
  if (flag == false)
  {
    digitalWrite(led, LOW);
    digitalWrite(vibrator, LOW);
  }

  else
  {
    digitalWrite(led, HIGH);
    digitalWrite(vibrator, HIGH);
  }
}
