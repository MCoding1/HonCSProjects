class Fluid{
  float x, y, w, h, c;
  
  Fluid(float xIn, float yIn, float wIn, float hIn, float cIn){
    x = xIn;
    y = yIn;
    w = wIn;
    h = hIn;
    c = cIn;
  }
  
  void display(){
    rectMode(CORNER);
    noStroke();
    fill(125,100);
    rect(x,y,w,h);
  }

}
