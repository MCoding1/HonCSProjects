class Solid{
  float x, y, w, h;
  
  Solid(float xIn, float yIn, float wIn, float hIn){
    x = xIn;
    y = yIn;
    w = wIn;
    h = hIn;
  }
  
  void display(){
    rectMode(CORNER);
    noStroke();
    fill(125);
    rect(x,y,w,h);
  }

}
