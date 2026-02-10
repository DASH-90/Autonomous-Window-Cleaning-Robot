int trig = 12;
int echo = 11;
long duration, distance;
//=============================================
#define step 8
#define dir 9

void setup() {
  Serial.begin(9600);
  pinMode(trig, OUTPUT );
  pinMode(echo, INPUT );
  //=================================================
  pinMode(step,OUTPUT);
  pinMode(dir,OUTPUT);
}
void turnon(){
    digitalWrite(dir,HIGH);
  for(int x = 0; x < 1600; x++){ //x is controling the number of turns (200 = 1 turn)
    digitalWrite(step,HIGH);
    delayMicroseconds(800); // speed control
    digitalWrite(step,LOW); 
    delayMicroseconds(800);
  }
}
void turnoff(){
      digitalWrite(dir,HIGH);
  for(int x = 0; x < 1600; x++){ //x is controling the number of turns (200 = 1 turn)
    digitalWrite(step,LOW);
    delayMicroseconds(800); // speed control
    digitalWrite(step,LOW); 
    delayMicroseconds(800);
  }

}
void loop() {
  digitalWrite(trig, LOW);
  delayMicroseconds(2);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  duration = pulseIn(echo, HIGH);
  distance = (duration / 2) * 0.0343;   //343*(100/1000000)=343/10000
  Serial.println(distance);
  delay(100);

  if(distance<50)
  {
    turnon();
  }
  else
  {
    turnoff();
  }
}