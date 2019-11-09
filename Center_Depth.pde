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
  
  int cameraDepth = camera.getDepth(160, 240);
  int cameraDepthRight = camera.getDepth(480,240);
    delay(10); 
  int cameraDepth2 = camera.getDepth(160, 240);
  int cameraDepth2Right = camera.getDepth(480,240);
  depthSense(cameraDepth, cameraDepth2);
  depthSense(cameraDepthRight, cameraDepth2Right);
  
  fill(0, 255, 255);
  textSize(20);
  textAlign(RIGHT, BOTTOM);
  text(cameraDepth,320, 240);
  
  senseDepth(cameraDepth);
  
   

  System.out.println(myPort.read());
  
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

void depthSense(int camDepthInit, int camDepth2){
  if (abs(camDepthInit-camDepth2) < 100) {
  if (camDepthInit <= maxDist) {
  float val = map(camDepthInit, 0, maxDist, 50, 255);
  int val1 = (int)val;
  myPort.write(val1);
  //int cameraDepth = 260;
  }
  }