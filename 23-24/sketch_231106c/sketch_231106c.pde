float noiseScale = 0.1;

void setup() {
size(800,400);
}

void draw() {
  background(0);
  for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, mouseY*noiseScale/2);
    //stroke(noiseVal*105, 108, 51);
    stroke(noiseVal*105, 231, 191);
    line(x, mouseY+noiseVal*180, x*2, height*180);
  }
  
    for (int x=0; x < width; x++) {
    float noiseVal = noise((mouseX+x)*noiseScale, mouseY*noiseScale/2);
    //stroke(noiseVal*105, 108, 51);
    stroke(noiseVal*105, 231, 10);
    line(x, mouseY+noiseVal, x*2, height/2);
  }
}
