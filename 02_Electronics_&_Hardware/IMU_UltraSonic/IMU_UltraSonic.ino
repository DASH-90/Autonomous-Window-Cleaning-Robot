#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <NewPing.h>

#define TRIGGER_PIN 7          // Ultrasonic sensor trigger pin
#define ECHO_PIN 6             // Ultrasonic sensor echo pin
#define MAX_DISTANCE 400       // Maximum distance to measure (in cm)

Adafruit_MPU6050 mpu;
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

void setup() {
  Serial.begin(115200);
  while (!Serial)
    delay(10); // Wait for Serial monitor to open

  // Initialize MPU-6050
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip!");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU6050 Found!");

  mpu.setAccelerometerRange(MPU6050_RANGE_2_G);
  mpu.setGyroRange(MPU6050_RANGE_250_DEG);
  mpu.setFilterBandwidth(MPU6050_BAND_5_HZ);

  delay(100); // Stabilize sensor
}

void loop() {
  // Read distance from ultrasonic sensor
  unsigned int distance = sonar.ping_cm();
  if (distance == 0) {
    Serial.println("No object detected within range.");
  } else {
    Serial.print("Distance: ");
    Serial.print(distance);
    Serial.println(" cm");
  }

  // Read acceleration data from MPU-6050
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  Serial.print("Acceleration -> X: ");
  Serial.print(a.acceleration.x);
  Serial.print(" m/s^2, Y: ");
  Serial.print(a.acceleration.y);
  Serial.print(" m/s^2, Z: ");
  Serial.print(a.acceleration.z);
  Serial.println(" m/s^2");

  Serial.println("-------------------------------------");
  delay(500); // Delay between readings
}
