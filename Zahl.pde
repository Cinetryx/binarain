class Zahl {
  float x;
  float y;
  float t;
  //float threshold = 40;
  String numb;
  float op;
  float sz;
  color col;
  boolean trig;
  int timer;
  float boost;
 
  
  Zahl() {
    trig = false;
    x = random(0,width);
    y = random(0,height);
    t = random(0.3,1.5);
    float ran = random(0,1);
    if(ran>0.5){
      numb = "0";
    }
    else{
      numb = "1";
    }
    sz = 10;
    op = 100;
  }

  void display(PImage prevFrame) {
    noStroke();
    
    
    color currCol = cam.get(int(x),int(y));
    color prevCol = prevFrame.get(int(x),int(y));
    
    float r1 = red(currCol); 
    float g1 = green(currCol); 
    float b1 = blue(currCol);
    float r2 = red(prevCol); 
    float g2 = green(prevCol); 
    float b2 = blue(prevCol);
    float diff = dist(r1, g1, b1, r2, g2, b2);
    
    if(diff>threshold){
      sz = 25;
      op = 255;
      col = prevCol;//currCol;
      trig = true;
      timer = 50;
    }
    
    if(timer>0)timer--;
    else trig=false;
    if(this.y>height){
      sz=20;
      op=50;
      trig=false;
    }
    
    if(trig==true)fill(col,op);
    else fill(currCol,op);
    textSize(sz);
    
    if(sz>20)sz-=0.3;
      
    if(op>50)op-=5;
    
    
    text(numb,x*scl,y*scl);
    
    
  
  }

  void move() {
  
    y = y +t;
    
    if (y > height) {
      y=0;
    }

  }
}
