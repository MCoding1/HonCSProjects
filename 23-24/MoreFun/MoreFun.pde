//NAUR THIS ISNT IT
PGraphics[] pgs = new PGraphics[3];

ArrayList<Ball> balls;

void setup(){
  size(1400,800);
  
  for (int i = 0; i < pgs.length; i++) {
    pgs[i] = createGraphics(450, 450);
  }
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

void drawBalls(PGraphics pg)
{
    pg.beginDraw();
    pg.background(0);
     pg.noStroke(); // Disable stroke (outlines)
    for (Ball b : balls)
      b.display(pg);
    pg.endDraw();
}

void drawBalls1(PGraphics pg1)
{
    pg1.beginDraw();
    pg1.background(0);
     pg1.noStroke(); // Disable stroke (outlines)
    for (Ball b : balls)
      b.display(pg1);
    pg1.endDraw();
}

void drawBalls2(PGraphics pg2)
{
    pg2.beginDraw();
    pg2.background(0);
     pg2.noStroke(); // Disable stroke (outlines)
    for (Ball b : balls)
      b.display(pg2);
    pg2.endDraw();
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
    
    void display1(PGraphics pg1)
    {
        pg1.fill(c);
        pg1.ellipse(position.x, position.y, radius*2, radius*2);
        pg1.rect(position.x*2, position.y*2, radius/2, radius/2);
        //pg1.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        // pg1.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        pg1.rect(position.x/2, position.y/2, radius/2, radius/2);
        position.add(velocity);

        if (position.x<radius || position.x>pg1.width-radius)
          velocity.x *= -1;
        if (position.y<radius || position.y>pg1.height-radius)
          velocity.y *= -1;
    }
    
    void display2(PGraphics pg2)
    {
        int q = color(random(0,255), random(0,255), random(0,255), random(100,200));  
        pg2.fill(q);
        //pg2.ellipse(position.x, position.y, radius*2, radius*2);
        pg2.rect(position.x*2, position.y*2, radius/2, radius/2);
        pg2.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        // pg2.triangle(position.x, position.y, position.x*2, position.y*2, radius*2, radius*2);
        pg2.rect(position.x/2, position.y/2, radius/2, radius/2);
        position.add(velocity);

        if (position.x<radius || position.x>pg2.width-radius)
          velocity.x *= -1;
        if (position.y<radius || position.y>pg2.height-radius)
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
  drawBalls(pgs[state]);
  
  // Display the kaleidoscope effect for the current PGraphics object
  drawKaleidoscope(pgs[state]);
}


void keyPressed() {
  // Increment the state variable to switch between PGraphics objects
  state++;
  if (state >= pgs.length) {
    state = 0; // Reset the state variable when it exceeds the number of PGraphics objects
  }
}
