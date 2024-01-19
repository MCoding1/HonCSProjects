float ty = 0;
float tx = 0;

  size(1000,500, P3D);
  background (0);
for (int x =0; x < width; x++){

ty = 0;
for (int y = 0; y < height; y++) {
  float brightness = map(noise(tx,ty), 0, 1, 0, 255);
  stroke(0,brightness,255-brightness);
  //stroke(random(255));
  point(x,height-brightness,y);
  ty+=0.005;
  }

tx+=0.005;
}
