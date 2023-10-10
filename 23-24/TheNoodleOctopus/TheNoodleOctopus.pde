float xnoise, ynoise;
void setup() {
  size(2000, 2000, P3D);
  noStroke();
  fill(255, 200);
  xnoise = random(10);
  ynoise = random(10);
}
void draw() {
  background(0);
  translate(width/2, height/2, 0);
  float ynoisehere = ynoise;
  float xnoisehere = ynoise;
  for (float y = -(height/8); y<= (height/8); y+=3) {
    ynoisehere +=0.02;
    for (float x = -(width/8); x <= (width/8); x+=3) {
      xnoisehere +=0.02;
      fill(noise(ynoisehere)*255, x, noise(xnoisehere)*255,  200);
      drawPoint(x, y, noise(xnoisehere, ynoisehere));
    }
  }
  xnoise +=0.1;
  ynoise +=0.1;
}
void drawPoint(float x, float y, float noiseFactor) {
  pushMatrix();
  translate(x*noiseFactor*4, y*noiseFactor*4, -y);
  float edgeSize = noiseFactor *26;
  ellipse(0, 0, edgeSize, edgeSize);
  popMatrix();
}
