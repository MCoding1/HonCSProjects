//
// smoke.pde
//


import java.util.*;
Random generator = new Random();

PImage imgBall;
ArrayList<Particle> particles;
float rate = 5;


void setup()
{
    size(1200, 800, P2D);
    //createTexture();
    imgBall = loadImage("ball.png");

    particles = new ArrayList<Particle>();

    //blendMode(ADD);
}


void draw()
{
    background(0);

    for (Particle p : particles)
        p.display();

    addParticles();
    removeDeadParticles();

    // add wind force based on mouse X position

    float intensity = map(mouseX, 0, width, -.1, .1);
    PVector force = new PVector(intensity, 0);

    for (Particle p : particles)
        p.velocity.add(force);

    // change rate based on mouse Y position

    rate = map(mouseY, 0, height, 10, 0);


    fill(255);
    textSize(20);
    text("Rate: " + rate, width*.05, height*.9);
    text("Particles: " + particles.size(), width*.05, height*.95);
}


Particle createParticle()
{
    PVector position = new PVector(width/2, height*.95);

    float angle = (float)(generator.nextGaussian() * PI/6 - PI/2);
    PVector velocity = PVector.fromAngle(angle);

    float speed = (float)(generator.nextGaussian() * 1 + 2);
    if (speed<0) speed *= -1;
    velocity.setMag(speed);
    return new Particle(position, velocity);
}


void addParticles()
{
    for (int i=0; i<rate; i++)
        particles.add(createParticle());

    if (rate < 1 && random(0, 1) < rate)
        particles.add(createParticle());
}


void removeDeadParticles()
{
    int now = millis();

    for (int i=particles.size()-1; i>=0; i--)
    {
        Particle p = particles.get(i);
        if (p.birthtime + p.lifetime < now)
            particles.remove(i);
    }
}


class Particle
{
    PVector position;
    PVector velocity;
    int birthtime;
    final int lifetime = 5000;
    int c;

    Particle(PVector p, PVector v)
    {
        position = p;
        velocity = v;
        birthtime = millis();

        // choose color by randomizing the hue, but storing as RGB
        colorMode(HSB);
        c = color(random(0, 20), 255, 255);
    }

    void display()
    {
        // increase transparency with time

        int a = (int)map(millis(), birthtime, birthtime + lifetime, 255, 0);
        colorMode(RGB);
        //tint(c, a);
        tint(255, a);

        // draw and update position

        image(imgBall, position.x, position.y);
        position.add(velocity);

        // slight slowdown with time

        velocity.mult(.999);
    }
}


PGraphics createTexture()
{
    // create an image in memory and save it to file

    PGraphics pg = createGraphics(20, 20);

    pg.beginDraw();
      int w = pg.width;
      int h = pg.height;

      int centerX = w/2;
      int centerY = h/2;

      pg.loadPixels();
        for (int i=0; i<h; i++)
        for (int j=0; j<w; j++)
        {
            int index = i*w + j;
            float d = dist(i, j, centerX, centerY);
            int value = (int)map(d, 0, w/2, 255, 0);
            pg.pixels[index] = color(value, value);
        }
      pg.updatePixels();
    pg.endDraw();

    pg.save("ball.png");
    return pg;
}
