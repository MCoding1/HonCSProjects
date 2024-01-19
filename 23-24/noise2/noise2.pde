float x,y, t;

void setup(){
  size(400,400);
}

void draw(){
x+=1;

y = map(noise(t),0,1,0,height);
t+=0.01;
//noiseSeed to set same random path
//noiseDetail
strokeWeight(3);
point(x,y);
}
