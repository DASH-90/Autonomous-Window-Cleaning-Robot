char reading;
int in1 = 9;
int in2 = 8;
int ConA = 10;
//speed control range(0-255)
void speedA(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(ConA,100);
}
//changing direction
void dirA(){
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  analogWrite(ConA,100);
}
//turning OFF
void turnOFF(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  analogWrite(ConA,0);
}
void setup() {
  Serial.begin(9600);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(ConA, OUTPUT);
}
void loop() {
  if (Serial.available() > 0) {
    reading = Serial.read();
    switch (reading) {
      case'A': speedA();
        break;
      case'B': dirA();
        break;
      case'X': turnOFF();
        break;

    }
  }
}
