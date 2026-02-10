int trig = 12;
int echo = 11;
long duration, distance;
#define step 8
#define dir 9

void setup() {
  Serial.begin(9600);
  pinMode(trig, OUTPUT );
  pinMode(echo, INPUT );
  pinMode(step,OUTPUT);
  pinMode(dir,OUTPUT);
}
void loop() {
  get_distance();
  delay(100);
  if(distance<50)
  {
    digitalWrite(dir,HIGH);
    while(1){
      digitalWrite(step,HIGH);
      delayMicroseconds(1000); // speed control
      digitalWrite(step,LOW); 
      delayMicroseconds(1000);
      get_distance();
      if(distance > 50)
      {
        break;
      }
    }
  }
}
long get_distance(){
    digitalWrite(trig, LOW);
    delayMicroseconds(2);
    digitalWrite(trig, HIGH);
    delayMicroseconds(10);
    digitalWrite(trig, LOW);
    duration = pulseIn(echo, HIGH);
    distance = (duration / 2) * 0.0343;   //343*(100/1000000)=343/10000
    Serial.println(distance);
    return distance;
}