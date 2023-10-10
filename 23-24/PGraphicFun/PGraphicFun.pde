PGraphics pg;
PGraphics pg1;

ArrayList<Ball> balls;

void setup(){
  size(1400,800);
  
  pg = createGraphics(450,450);
  pg1 = createGraphics(450,450);
  createBalls();
  
}

void createBalls(){
  balls = new ArrayList<Ball>();
  final int ballCount = 10;
  
  for (int i=0; i<ballCount; i++){
    float radius = random(5,30);
    float b = random(120,150);
    int c = color(b, b, b, random(100,200));
    PVector position = new PVector(100, 100);
    PVector velocity = PVector.random2D();
    velocity.setMag(random(4, 10));
    
    balls.add(new Ball(position, velocity, radius, c));
    
  }
}

void drawSimple(PGraphics pg)
{
  int x = 1;
  int y = 1;
  int vx = 1;
  int vy = 1;
//do a for loop increasing
    vx++;
    vy++;
    
fill(255,126,126,150);
ellipse(x*vx,y*vy,200,200);  
  
}


void drawBalls(PGraphics pg)
{
    pg.beginDraw();
    pg.background(0);
     pg.noStroke(); // Disable stroke (outlines)
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
        //pg.ellipse(position.x, position.y, radius*2, radius*2);
        pg.rect(position.x*2, position.y*2, radius/2, radius/2);
        pg.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        // pg.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        pg.rect(position.x/2, position.y/2, radius/2, radius/2);
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
    drawBalls(pg);  
 
   
        if (state == 1)
    {
                  drawSimple(pg1); 
        image(pg1, 0, 0);  

    }
else{
      drawKaleidoscope(pg);
    }
}


void keyPressed()
{
  
  state++;
    if (state>1) state = 0;
   /*
  if (keyCode == RIGHT) {
    state++;
    if (state>2) state = 0;
  } else if (keyCode == LEFT) {
    state--;
        if (state<0) state = 2;
  } */
}
