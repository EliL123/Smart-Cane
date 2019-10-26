import ch.bildspur.realsense.*;
import javax.swing.Timer;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.concurrent.*;

//camera
RealSenseCamera camera = new RealSenseCamera(this);

//variables
int range1 = 800;
int range2 = 600;
int range3 = 400;
int range4 = 200;
boolean switchVar = true;

void setup()
{
  size(640, 480);

  // width, height, fps, depth-stream, color-stream
  camera.start(640, 480, 30, true, true);
  
  
  
}

void draw()
{
  background(0);

  // read frames
  camera.readFrames();

  // show color image
  image(camera.getColorImage(), 0, 0);
  
  int cameraDepth = camera.getDepth(mouseX, mouseY);
  
  fill(0, 255, 255);
  textSize(20);
  textAlign(RIGHT, BOTTOM);
  text(cameraDepth, mouseX, mouseY);
  
  senseDepth(cameraDepth);
  
  
}

void senseDepth(int camDepth){
  if(camDepth < range4){ 
    fill(255,255,255);
    textSize(20);
    textAlign(LEFT,BOTTOM);
    text("WAY TOO CLOSE", mouseX, mouseY);
  } else if(camDepth > range4 && camDepth <= range3) { 
    fill(255,255,255);
    textSize(20);
    textAlign(LEFT,BOTTOM);
    text("TOO CLOSE", mouseX, mouseY);
  } else if(camDepth > range3 && camDepth <= range2) { 
    fill(255,255,255);
    textSize(20);
    textAlign(LEFT,BOTTOM);
    text("CLOSE", mouseX, mouseY);
  } else if(camDepth > range2 && camDepth <= range1) { 
    fill(255,255,255);
    textSize(20);
    textAlign(LEFT,BOTTOM);
    text("KINDA CLOSE", mouseX, mouseY);
  }
}
