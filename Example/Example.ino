/**********************实例化1个LED对象，用7号叫控制，让他闪烁10次，并在串口打印出它的状态。10次完毕后释放回收引脚**********************/
#include "./HEADER/LED.h"

/*
  Uart output and input
*/

serialPrint test;

// 初始化串口波特率为11520:
void setup()
{
    // 使用Serial.begin()函数来初始化串口波特率,参数为要设置的波特率
    Serial.begin(115200);
}

// the loop routine runs over and over again forever:
void loop()
{

    test.printx();
    delay(500); // 延时500ms
}