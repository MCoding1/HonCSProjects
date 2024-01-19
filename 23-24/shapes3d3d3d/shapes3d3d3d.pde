import peasy.*;

PeasyCam cam;

PGraphics pg;

float x,y,z,s,r;

void setup()
{
    size(800, 600, P3D);
    cam = new PeasyCam(this, 0, 0, 0, 500);
    
    pg = createGraphics(200, 200);

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

    //vertex(-100, -100);
    //vertex(-100, 100);
    //vertex(100, 100);
    //vertex(100, -100);

  for (int z = 30; z < 200; z = z+1) {
    z+=5;
  }
    for (int i = 0; i < 200; i = i+1) {
          beginShape();
    noStroke();
    r = 0;
    vertex(r, 0, i+z);
    vertex(r+5, 0, i+z);    
    vertex(r, 100, i+z);
    vertex(r+5, 100, i+z);
        endShape();
    r+=5;
  
}
    //vertex(10, -100);
    //vertex(x,y,z);

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


} 
