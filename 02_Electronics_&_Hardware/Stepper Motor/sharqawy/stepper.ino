#define step 8
#define dir 9


void setup() {
  pinMode(step,OUTPUT);
  pinMode(dir,OUTPUT);
}

void loop() {
  directionA();
}
void directionA() {
    digitalWrite(dir,HIGH);
    while(1){
    digitalWrite(step,HIGH);
    delayMicroseconds(1000); // speed control
    digitalWrite(step,LOW); 
    delayMicroseconds(1000);
  }
}