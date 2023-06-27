```c++
//测试 振动马达
#include "vibrator.h"
Vibrator v1(14, 15);

void setup()
{
  // put your setup code here, to run once:
}

void loop()
{
  // put your main code here, to run repeatedly:
  v1.setStatus(on);
  delay(500);

  v1.setStatus(off);
  delay(500);
}

```



```c++
//测试人体传感器
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

/*
测试结果:
1. 角度宽的时候能测试的距离很近
2. 角度窄的时候能测试的距离很远
3. 只检测有温度的生物: 小猫,小狗,人体等生物.
*/
```

