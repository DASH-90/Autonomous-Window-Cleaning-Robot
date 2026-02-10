int in1 = 4;
int in2 = 5;
int in3 = 2;
int in4 = 3;
int ENA = 9;
int ENB = 10;

void setup() {
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(ENB, OUTPUT);
}
//speed control range(0-255)
void speedA(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(ENB,55);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
  analogWrite(ENA,55);
}
//changing speed and direction
void speedB(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(ENB,255);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
  analogWrite(ENA,255);
}
//turning OFF
void turnOFF(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  analogWrite(ENB,0);
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
  analogWrite(ENA,0);
}

void loop() {
  speedA();
  delay(5000);
  turnOFF();
  delay(1000);
  speedB();
  delay(5000);
  turnOFF();
  delay(1000);
}
