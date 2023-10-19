//
// hello_pgraphics.pde
//


PGraphics pg;


void setup()
{
    size(400, 400);

    pg = createGraphics(200, 200);
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

void draw()
{
    background(0);

    // draw into the offscreen buffer (the PGraphics object)

    drawInsidePG();

    // use the offscreen buffer as an image

    image(pg, 0, 0);
    image(pg, 200, 200);
    image(pg, mouseX-pg.width/2, mouseY-pg.height/2);
}
