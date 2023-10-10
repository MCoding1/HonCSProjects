//
// hello_pgraphics_2.pde
//


PGraphics pg1;
PGraphics pg2;

ArrayList<Ball> balls;


void setup()
{
    size(400, 400);

    pg1 = createGraphics(200, 200);
    pg2 = createGraphics(200, 200);

    createBalls();
}


void createBalls()
{
    balls = new ArrayList<Ball>();
    final int ballCount = 50;

    for (int i=0; i<ballCount; i++)
    {
        float radius = random(5, 15);
        int c = color(random(256), random(256), random(256));
        PVector position = new PVector(100, 100);
        PVector velocity = PVector.random2D();
        velocity.setMag(random(2, 6));

        balls.add(new Ball(position, velocity, radius, c));
    }
}


void drawSimple(PGraphics pg)
{
    pg.beginDraw();

    pg.fill(0, 0, 255);
    pg.ellipse(100, 100, 100, 100);

    pg.fill(0, 255, 0);
    pg.ellipse(150, 150, 100, 50);

    pg.fill(255, 0, 0);
    pg.rect(20, 20, 100, 20);

    pg.endDraw();
}


void drawBalls(PGraphics pg)
{
    pg.beginDraw();
    pg.background(0);
    for (Ball b : balls)
      b.display(pg);
    pg.endDraw();
}


class Ball
{
    PVector position;
    PVector velocity;
    float radius;
    int c;

    Ball(PVector position, PVector velocity, float radius, int c)
    {
        this.position = position;
        this.velocity = velocity;
        this.radius = radius;
        this.c = c;
    }

    void display(PGraphics pg)
    {
        pg.fill(c);
        pg.ellipse(position.x, position.y, radius*2, radius*2);
        position.add(velocity);

        if (position.x<radius || position.x>pg.width-radius)
          velocity.x *= -1;
        if (position.y<radius || position.y>pg.height-radius)
          velocity.y *= -1;
    }
}


int state = 0;


void drawKaleidoscope(PGraphics pg)
{
    int n = 7;
    for (int i=0; i<n; i++)
    {
        pushMatrix();
        translate(width/2, height/2);
        rotate(2*PI*i/n);
        image(pg, 0, 0);
        popMatrix();
    }
}


void draw()
{
    background(0);

    drawSimple(pg1); 
    drawBalls(pg2); 

    if (state == 0)
    {
        image(pg1, 0, 0);
        image(pg2, 200, 200);
    }
    else if (state == 1)
    {
        drawKaleidoscope(pg1);
    }
    else
    {
        drawKaleidoscope(pg2);
    }
}


void keyPressed()
{
    state++;
    if (state>2) state = 0;
}
