#include <Wire.h>
#include <Adafruit_INA219.h>
Adafruit_INA219 ina219;

int in1 = 9;
int in2 = 8;
int ConA = 10;

void setup(void) {
    Serial.begin(9600);
  while (!Serial) 
  {
    delay(1);
  }
 
  // Initialize the INA219.
  if (! ina219.begin())
  {
    Serial.println("Failed to find INA219 chip");
    while (1) 
    {
      delay(10);
    }
  }
  // To use a slightly lower 32V, 1A range (higher precision on amps):
  //ina219.setCalibration_32V_1A();
  // Or to use a lower 16V, 400mA range, call:
  //ina219.setCalibration_16V_400mA();
 
  Serial.println("Measuring voltage, current, and power with INA219 ...");

  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(ConA, OUTPUT);
}
//speed control range(0-255)
void speedA(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  analogWrite(ConA,255);
}
//changing speed and direction
void speedB(){
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  analogWrite(ConA,255);
}
//turning OFF
void turnOFF(){
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);
  analogWrite(ConA,0);
}

void loop(void) {
  speedB();

  float shuntvoltage = 0;
  float busvoltage = 0;
  float current_mA = 0;
  float loadvoltage = 0;
  float power_mW = 0;
 
  shuntvoltage = ina219.getShuntVoltage_mV();
  busvoltage = ina219.getBusVoltage_V();
  current_mA = ina219.getCurrent_mA();
  power_mW = ina219.getPower_mW();
  loadvoltage = busvoltage + (shuntvoltage / 1000);
 

  Serial.print(current_mA);

  Serial.println("");
 
  delay(1000);

}
