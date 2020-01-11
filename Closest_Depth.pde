import ch.bildspur.realsense.*;
import javax.swing.Timer;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.concurrent.*;
import processing.serial.*; 

//camera
RealSenseCamera camera = new RealSenseCamera(this);

//variables

// depth variables
int maxDepth = 1000;
int readDepth;
int beginWidth = 100;
int beginHeight = 100;
int width = 640;
int height = 480;
int closestXValue = 0;
int closestYValue = 0;
char side = 'N';

void setup()
{
  size(640, 480);

  // width, height, fps, depth-stream, color-stream
  camera.start(width, height, 30, true, true);
  
}

void draw()
{
  background(0);
  
  // read frames
  camera.readFrames();
  
  // create grayscale image form depth buffer
  // min and max depth
  camera.createDepthImage(0, 5000);   
  
  // show color image
  image(camera.getDepthImage(), 0, 0);
  
  // show borders
  noFill();
  rect(beginWidth,beginHeight,440,280);
  
  
  // loop through all the pixels
  for(int x = beginWidth; x < width - 100; x++){
    for(int y = beginHeight; y < height - 100; y++){
       readDepth = camera.getDepth(x,y);
       if(readDepth < maxDepth && readDepth != 0){ // ignoring zeroes, if the depth we got is the lowest so far
         maxDepth = readDepth; // track lowest depth
         closestXValue = x;
         closestYValue = y;
         System.out.println(maxDepth);
       }
    }
  }
  
  // what side is the closest point on?
  if(closestXValue < 320){ // if on the left side
    side = 'L'; // set to left
  } else { // if on the right side
    side = 'R'; // set to right
  }
  
  // print the closest depth
  fill(255,0,0);
  textSize(40);
  textAlign(RIGHT, BOTTOM);
  circle(closestXValue, closestYValue, 10);
  // print depth in millimeters, side its on, at location of closest depth
  text(maxDepth + " " + side, closestXValue, closestYValue);
  
  // reset back to 1000 to refind closest value
  maxDepth = 1000;
  
}
