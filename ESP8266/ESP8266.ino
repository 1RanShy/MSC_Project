
void setup() {
  // put your setup code here, to run once:
  pinMode(4, INPUT);//右边第三个引脚
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(4));
  delay(1000);
}
