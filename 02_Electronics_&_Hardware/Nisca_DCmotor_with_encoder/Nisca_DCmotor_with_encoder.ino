volatile unsigned int temp1, counter1 = 0; //This variable will increase or decrease depending on the rotation of encoder
volatile unsigned int temp2, counter2 = 0; //This variable will increase or decrease depending on the rotation of encoder

#define IN1 9
#define IN2 8
#define IN3 7
#define IN4 6
#define speedL 10
#define speedR 11

#define on 0
#define off 1
int relay1=4;
int relay2=5;

  //  setup

void setup()
{
  Serial.begin (9600);

  pinMode(2, INPUT_PULLUP); // internal pullup input pin 2 
  pinMode(3, INPUT_PULLUP); // internalเป็น pullup input pin 3
  pinMode(12, INPUT_PULLUP); // internal pullup input pin 12 
  pinMode(13, INPUT_PULLUP); // internalเป็น pullup input pin 13
  //Setting up interrupt
  //A rising pulse from encodenren activated ai0(). AttachInterrupt 0 is DigitalPin nr 2 on moust Arduino.
  attachInterrupt(0, ai0, RISING);  
  //B rising pulse from encodenren activated ai1(). AttachInterrupt 1 is DigitalPin nr 3 on moust Arduino.
  attachInterrupt(1, ai1, RISING);
  //A rising pulse from encodenren activated ai2(). AttachInterrupt 0 is DigitalPin nr 12 on moust Arduino.
  attachInterrupt(0, ai2, RISING);  
  //B rising pulse from encodenren activated ai3(). AttachInterrupt 1 is DigitalPin nr 13 on moust Arduino.
  attachInterrupt(1, ai3, RISING);

  for(int i=4 ; i<=11 ; i++)
  {
    pinMode(i, OUTPUT); 
  } 
}

  //  encoder
void ai0()
{
  // ai0 is activated if DigitalPin nr 2 is going from LOW to HIGH
  // Check pin 3 to determine the direction
  if(digitalRead(3)==LOW) {
  counter1++;
  }else{
  counter1--;
  }
}   
void ai1()
{
  // ai0 is activated if DigitalPin nr 3 is going from LOW to HIGH
  // Check with pin 2 to determine the direction
  if(digitalRead(2)==LOW) {
  counter1--;
  }else{
  counter1++;
  }
}
void ai2()
{
  // ai2 is activated if DigitalPin nr 12 is going from LOW to HIGH
  // Check pin 13 to determine the direction
  if(digitalRead(13)==LOW) {
  counter2++;
  }else{
  counter2--;
  }
}   
void ai3()
{
  // ai3 is activated if DigitalPin nr 13 is going from LOW to HIGH
  // Check with pin 12 to determine the direction
  if(digitalRead(12)==LOW) {
  counter2--;
  }else{
  counter2++;
  }
}

  //  speed control range(0-255)

void forword()
{
  digitalWrite(relay1,on);
  digitalWrite(relay2,off);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW); 
  digitalWrite(IN3, HIGH); 
  digitalWrite(IN4, LOW);
  analogWrite(speedL,255);
  analogWrite(speedR,255); 
}
void backword()
{
  digitalWrite(relay1,off);
  digitalWrite(relay2,on);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW); 
  digitalWrite(IN3, HIGH); 
  digitalWrite(IN4, LOW);
  analogWrite(speedL,255);
  analogWrite(speedR,255); 
}
void left()
{
  digitalWrite(relay1,on);
  digitalWrite(relay2,off);                
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW); 
  digitalWrite(IN3, HIGH); 
  digitalWrite(IN4, LOW); 
  analogWrite(speedL,0);
  analogWrite(speedR,255); 
}
void right()
{
  digitalWrite(relay1,on);
  digitalWrite(relay2,off);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW); 
  digitalWrite(IN3, LOW); 
  digitalWrite(IN4, LOW);
  analogWrite(speedL,255);
  analogWrite(speedR,0); 
}
void stopp()
{
  digitalWrite(relay1,on);
  digitalWrite(relay2,off);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW); 
  digitalWrite(IN3, LOW); 
  digitalWrite(IN4, LOW);
  analogWrite(speedL,0);
  analogWrite(speedR,0);
}

 
  //  loop
void loop() 
{
  //  //  encoder
  // // Send the value of counter1
  // if( counter1 != temp1 ){
  // Serial.println (counter1);
  // temp1 = counter1;
  // serial.println("######################");
  // }
  // // Send the value of counter2
  // if( counter2 != temp2 ){
  // Serial.println (counter2);
  // temp2 = counter2;
  // serial.println("@@@@@@@@@@@@@@@@@@@@@@");
  // }

  // move

  forword();
  delay(5000);
  stopp();
  delay(1000);
  backword();
  delay(5000);
  stopp();
  delay(1000);
  right();
  delay(5000);
  stopp();
  delay(1000);
  left();
  delay(5000);
  stopp();
  delay(1000);
}
