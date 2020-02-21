//test comment

import processing.video.*;
Zahl[] zahlen;

Capture cam;
PImage prevFrame;
float threshold = 90;
int camMode;
float scl;
int ct;
int ssCount;

void setup() {
  //size(640, 360);
  fullScreen();
  ct = 0;
  ssCount = 0;

  cam = new Capture(this, 640, 360);
  scl = (float)height/(float)cam.height;
  
  cam.start();
  prevFrame = createImage(cam.width, cam.height, RGB);
  zahlen = new Zahl [20000];
  for (int i = 0; i < zahlen.length; i++) {
    zahlen[i] = new Zahl();
  }
  background(255);
}

void captureEvent(Capture cam) {
  prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height); 
  prevFrame.updatePixels();  
  cam.read();
  
  
  //
  switch(camMode){
    case 1:
      break;
    case 2:
      cam.filter(GRAY);
      break;
    case 3:
      cam.filter(POSTERIZE, 2);
      break;
    case 4:
      cam.filter(THRESHOLD, 0.5);
      break;
    case 5:
      filter(OPAQUE);
      break;
    case 6:
      filter(DILATE);
      break;
    case 7:
      filter(BLUR);
      break;
    case 8:
      filter(ERODE);
      break;
  }

  
}

void draw() {
  ct+=1;
  if(ct%100==0){
    saveFrame("screenshot"+ssCount+++".jpg");
  }
  loadPixels();
  cam.loadPixels();
  prevFrame.loadPixels();
  
  //float diff = 0;
  /*for (int x = 0; x < cam.width; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {

      int loc = x + y * cam.width;           
      color current = cam.pixels[loc];    
      color previous = prevFrame.pixels[loc]; 

      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      if (diff < threshold) {
        pixels[loc] = previous;
        
      }
    }
  }*/
  updatePixels();
  
  for (int i = 0; i < zahlen.length; i++) {
    
    zahlen[i].display(prevFrame);
    zahlen[i].move();
  }
}

void keyPressed(){
  switch(key){
    case '1':
      camMode = 1; 
      break;
    case '2':
      camMode = 2;
      break;
    case '3':
      camMode = 3;
      break;
    case '4':
      camMode = 4;
      break;
        case '5':
      camMode = 5;
      break;
    case '6':
      camMode = 6;
      break;
    case '7':
      camMode = 7;
      break;
    case '8':
      camMode = 8;
      break;
    case 's':
      saveFrame("screenshot-########.png");
      break;
  }
  
  if(keyCode == UP)threshold+=1;
  if(keyCode == DOWN)threshold-=1;
  println(threshold);
  
}
