import ch.bildspur.realsense.*;
import javax.swing.Timer;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.concurrent.*;
import processing.serial.*; 

//port
Serial myPort;

//camera
RealSenseCamera camera = new RealSenseCamera(this);

//variables
int range1 = 800;
int range2 = 600;
int range3 = 400;
int range4 = 200;
int maxDist = 2000;
boolean switchVar = true;

// depth variables
float valLeft, valRight;
int valConvertLeft, valConvertRight;

void setup()
{
  size(640, 480);

  // width, height, fps, depth-stream, color-stream
  camera.start(640, 480, 30, true, true);
  
  String portName = "COM3";
  myPort = new Serial(this, portName, 9600);
  
}

void draw()
{
  background(0);

  // read frames
  camera.readFrames();

  // show color image
  image(camera.getColorImage(), 0, 0);
  
// get the first camera depth from left and right
  int cameraDepth = camera.getDepth(160, 240);
  int cameraDepthRight = camera.getDepth(480,240);
    delay(10); 
// get the second camera depth from left and right
  int cameraDepth2 = camera.getDepth(160, 240);
  int cameraDepth2Right = camera.getDepth(480,240);
// map the values for left
if (abs(cameraDepth-cameraDepth2) < 100) {
  if (cameraDepth <= maxDist) {
  valLeft = map(cameraDepth, 0, maxDist, 50, 255);
  valConvertLeft = (int)valLeft;
  myPort.write(valConvertLeft);
  }

// map the values for right
if (abs(cameraDepthRight-cameraDepth2Right) < 100) {
  if (cameraDepthRight <= maxDist) {
  valRight = map(cameraDepthRight, 0, maxDist, 50, 255);
  valConvertRight = (int)valRight;
  myPort.write(valConvertRight);
  }
  
  fill(0, 255, 255);
  textSize(20);
  textAlign(RIGHT, BOTTOM);
  text(cameraDepth,160, 240);

  fill(0, 255, 255);
  textSize(20);
  textAlign(RIGHT, BOTTOM);
  text(cameraDepthRight,480, 240);
  
  senseDepth(cameraDepth);
  
   senseDepth(cameraDepthRight);

 // System.out.println(myPort.read());
  
}

void senseDepth(int camDepth){
  if(camDepth < range4){ 
    displayText("WAY TOO CLOSE");
  } else if(camDepth > range4 && camDepth <= range3) { 
    displayText("TOO CLOSE");
  } else if(camDepth > range3 && camDepth <= range2) { 
    displayText("CLOSE");
  } else if(camDepth > range2 && camDepth <= range1) { 
    displayText("KINDA CLOSE");
  }

  /*if(camDepth < range1){
     myPort.write('1');
  } else {
     myPort.write('0');
  }*/
}

void displayText(String text){
    fill(255,255,255);
    textSize(20);
    textAlign(LEFT,BOTTOM);
    text(text, mouseX, mouseY);
}

/*void depthSense(int camDepthInit, int camDepth2){
  if (abs(camDepthInit-camDepth2) < 100) {
  if (camDepthInit <= maxDist) {
  float val = map(camDepthInit, 0, maxDist, 50, 255);
  int val1 = (int)val;
  myPort.write(val1);
  //int cameraDepth = 260;
  }
  }*/
