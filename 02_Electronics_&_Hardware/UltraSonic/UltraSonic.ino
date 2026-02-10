int trig = 12;
int echo = 11;
long duration, distance;

void setup() {
  Serial.begin(9600);
  pinMode(trig, OUTPUT );
  pinMode(echo, INPUT );
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
}
