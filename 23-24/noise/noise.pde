float x,y;

void setup(){
  size(400,400);
}

void draw(){
x+=1;

y = random(height);
strokeWeight(3);
point(x,y);
}
