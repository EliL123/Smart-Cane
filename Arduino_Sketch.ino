#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int val; // Data received from the serial port 
int bright;
int ledPin = 9; // Set the pin to digital I/O 13
void setup() { 
   pinMode(ledPin, OUTPUT); // Set pin as OUTPUT 
   Serial.begin(9600); // Start serial communication at 9600 bps 

   lcd.begin(16, 2);
}
void loop() {
   if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
    bright = 255-val;
  //   Serial.print(bright);
     //digitalWrite(ledPin, HIGH);
       analogWrite(ledPin, bright); // turn the LED on
     lcd.println(val);
   delay(100); // Wait 10 milliseconds for next reading
   }

}
