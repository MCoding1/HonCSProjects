import processing.pdf.*;
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam; 

int afstand = 70;

boolean record;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 10000);
  noStroke();
  fill(0);
  ortho(-width, width, -height, height);
}

void draw() {
  background(#ffffff);

  if (record) {
    beginRaw(PDF, "cube.pdf");
  }

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      for (int k=0; k<8; k++) {
        pushMatrix();
        translate((i-3)*afstand, (j-3)*afstand, (k-3)*afstand);
        sphere(10);
        popMatrix();
      }
    }
  }

  if (record) {
    endRaw();
    record = false;
  }
}

void keyPressed() {
  record = true;
}
