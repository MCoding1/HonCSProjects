//
// hello_3d.pde
//


import processing.video.*;
import peasy.*;


PeasyCam cam;

PImage fur;
PGraphics pg;
Capture capture;

void setup()
{
    size(800, 600, P3D);
    cam = new PeasyCam(this, 0, 0, 0, 500);
    fur = loadImage("fur.jpg");

    pg = createGraphics(200, 200);
    drawInsidePG();

    capture = new Capture(this, Capture.list()[0]);
    capture.start();
}


void drawAxes()
{
    final int size = 200;
    stroke(255, 0, 0);
    line(-size, 0, 0, size, 0, 0);
    stroke(0, 255, 0);
    line(0, -size, 0, 0, size, 0);
    stroke(0, 0, 255);
    line(0, 0, -size, 0, 0, size);
}


void drawRect()
{
    pushMatrix();
    translate(0, 0, 100);
    beginShape();
    noStroke();
    vertex(-100, -100);
    vertex(-100, 100);
    vertex(100, 100);
    vertex(100, -100);
    endShape();
    popMatrix();
}


void drawRectWithTexture(PImage img)
{
    textureMode(NORMAL);

    pushMatrix();
    translate(0, 0, 100);
    beginShape();
    noStroke();
    texture(img);
    vertex(-100, -100, 0, 0);
    vertex(-100, 100, 0, 1);
    vertex(100, 100, 1, 1);
    vertex(100, -100, 1, 0);
    endShape();
    popMatrix();
}




void draw()
{
    background(0);

    //translate(width/2, height/2);
    //box(100);

    drawAxes();

    // front face
    drawRect();

    // back face
    pushMatrix();
    rotateY(PI);
    drawRectWithTexture(fur);
    popMatrix();

    // left face
    pushMatrix();
    rotateY(PI/2);
    drawRectWithTexture(pg);
    popMatrix();

    // bottom

    if (capture.available())
        capture.read();

    pushMatrix();
    rotateX(PI/2);
    drawRectWithTexture(capture);
    popMatrix();
}


void drawInsidePG()
{
    pg.beginDraw();

      // rectangle outline
      pg.stroke(255);
      pg.strokeWeight(2);
      pg.noFill();
      pg.rect(0, 0, pg.width, pg.height);

      // eyes
      pg.fill(0, 255, 0);
      pg.ellipse(75, 75, 20, 50);
      pg.ellipse(125, 75, 20, 50);

      // mouth
      pg.fill(0, 0, 255);
      pg.ellipse(100, 150, 75, 25);

    pg.endDraw();
}
