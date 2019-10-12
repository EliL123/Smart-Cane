import ch.bildspur.realsense.*;

RealSenseCamera camera = new RealSenseCamera(this);

void setup()
{
  size(640, 480);

  // width, height, fps, depth-stream, color-stream
  camera.start(640, 480, 30, true, true);
}
void draw()
{
  background(255);

  // read frames
  camera.readFrames();
   
  // show color image
  image(camera.getColorImage(), 0, 0);

  
  // -- or --
  
  // create grayscale image form depth buffer
  // min and max depth
  camera.createDepthImage(0, 6000);
  
  // show color image
  image(camera.getDepthImage(), 0, 0);
}
