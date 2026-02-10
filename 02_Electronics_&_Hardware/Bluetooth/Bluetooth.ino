int led = 13;
char reading;
void setup() {
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    reading = Serial.read();
    switch (reading) {
      case'F': digitalWrite(led, 1);
        break;
      case'S': digitalWrite(led, 0);
        break;
    }
  }
}
