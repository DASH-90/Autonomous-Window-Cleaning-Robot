#define step 8
#define dir 9


void setup() {
  pinMode(step,OUTPUT);
  pinMode(dir,OUTPUT);
}

void loop() {
  digitalWrite(dir,HIGH);
  for(int x = 0; x < 400; x++){ //x is controling the number of turns (200 = 1 turn)
    digitalWrite(step,HIGH);
    delayMicroseconds(600); // speed control
    digitalWrite(step,LOW); 
    delayMicroseconds(600);
  }
  delay(1000);
  //direction change
  digitalWrite(dir,LOW);
  for(int x = 0; x < 400; x++) {
    digitalWrite(step,HIGH);
    delayMicroseconds(600);
    digitalWrite(step,LOW);
    delayMicroseconds(600);
  }
  delay(1000);
}
