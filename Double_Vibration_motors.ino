int val1; // Data received from the serial port 
int val2;
int valInit;
int valFin;
int bright1;
int bright2;
int minDist;
int maxDist;
int ledPin = 10; // Set the pin to digital I/O 13
int ledPin2 = 8; // Set the pin to digital I/O 13
void setup() { 
  while (!Serial);
   pinMode(ledPin, OUTPUT); // Set pin as OUTPUT 
   pinMode(ledPin2, OUTPUT); // Set pin as OUTPUT 
   Serial.begin(9600); // Start serial communication at 9600 bps 
   SerialUSB.begin(9600); // Start serial communication at 9600 bps 
  minDist = 26;
  maxDist = 40;
}
void loop() {
   if (Serial.available()) 
   { // If data is available to read,
    //Programming port, COM4, uses the "Serial" command
    //Native port, COM7/8/9, uses the "SerialUSB" command
     val1 = Serial.read(); // read it and store it in val
     val2 = SerialUSB.read(); // read it and store it in val

    bright1 = 255-val1;
    bright2 = 255-val2;
     }
    analogWrite(ledPin, bright1); // turn the LED on
    analogWrite(ledPin2, bright2);
    Serial.println(bright1);
    delay(5); // Wait 10 milliseconds for next reading1
}
