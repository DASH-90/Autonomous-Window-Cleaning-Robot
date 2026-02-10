#include <Servo.h>

Servo esc;  // Object to control the ESC
int potPin = A0;  // Pin connected to potentiometer
int val;  // Variable to store potentiometer value

void setup() {
  esc.attach(9);  // Pin connected to ESC signal wire
  esc.writeMicroseconds(1000);
}

void loop() {
  val = analogRead(potPin);  // Read potentiometer value
  val = map(val, 0, 1023, 1000, 2000);  // Map potentiometer value to ESC PWM range
  esc.writeMicroseconds(val);  // Send PWM signal to ESC
  delay(20);  // Small delay to ensure stability
}