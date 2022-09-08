import processing.sound.*;

ArrayList<ParticleSystem> systems;
ArrayList<Rocket> rockets;
PVector gravity;
PVector wind;
Fluid fluid;
PImage bigLight;
PImage smallLight;

ParticleSystem ps;
SoundFile explosion;
SoundFile launch;


function setup() {
  createCanvas(600, 600);

  explosion = new SoundFile(this, "Explosion9.wav");
  launch  = new SoundFile(this, "missileLaunch.wav");
  launch.amp(0.1);

  fluid = new Fluid(0, 0, width, height, 0.01);
  gravity = new PVector(0, 0.03);
  wind = new PVector(0, 0);

  systems = new ArrayList<ParticleSystem>();
  rockets = new ArrayList<Rocket>();
  bigLight = loadImage("whiteLight.png");
  bigLight.resize(25, 25);
  smallLight = loadImage("whiteLight.png");
  smallLight.resize(8, 8);
  imageMode(CENTER);
}

function draw() {
  blendMode(ADD);
  background(0);
  if (millis() % 20 == 0) {
    PVector launchPoint = new PVector(width/2, height);
    PVector mouse = new PVector(random(width), random(height/2));
    PVector dir = PVector.sub(mouse, launchPoint);
    dir.normalize();
    dir.mult(random(3, 5));
    Rocket rock = new Rocket(launchPoint, dir);
    rockets.add(rock);
    launch.play();
  }
  for (int i = rockets.size()-1; i >-1; i--) {
    Rocket r = rockets.get(i);
    r.run();
    if (r.detonated) {
      explosion.play();
      systems.add(new ParticleSystem(int(r.position.x), int(r.position.y)));
      rockets.remove(r);
    }
  }

  for (ParticleSystem system : systems) {
    system.run();
  }

  for (int i = systems.size()-1; i > -1; i--) {
    ParticleSystem ps = systems.get(i);
    if (ps.isDead()) {
      systems.remove(i);
    }
  }
  println(rockets.size());
  //fluid.display();
  //solid.display();
}

void mouseClicked() {
  PVector launchPoint = new PVector(width/2, height);
  PVector mouse = new PVector(mouseX, mouseY);
  PVector dir = PVector.sub(mouse, launchPoint);
  dir.normalize();
  dir.mult(random(3, 5));
  Rocket r = new Rocket(launchPoint, dir);
  rockets.add(r);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    wind = new PVector(0.05, 0);
  } else if (keyCode == LEFT) {
    wind = new PVector(-0.05, 0);
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    wind = new PVector(0, 0);
  }
}

class Fluid{
  float x, y, w, h, c;

  Fluid(float xIn, float yIn, float wIn, float hIn, float cIn){
    x = xIn;
    y = yIn;
    w = wIn;
    h = hIn;
    c = cIn;
  }

  void display(){
    rectMode(CORNER);
    noStroke();
    fill(125,100);
    rect(x,y,w,h);
  }

}

class Mover {
  //declare motion vectors
  PVector position, velocity, acceleration;
  //declare top speed and display size
  float topSpeed, radius, mass;
  float angle, angleVel, angleAcc;

  //Constructor Function
  Mover(PVector pIn, PVector vIn) {
    //assign initial values based on parameters passed into constructor
    position = new PVector(pIn.x, pIn.y);
    velocity = new PVector(vIn.x, vIn.y);
    acceleration = new PVector(0, 0);
    topSpeed = 10;
    radius = 20;
    mass = 1;
  }

  void checkSolid(Solid s) {
    if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y + radius + velocity.y > s.y && position.y < s.y) {
      position.y = s.y-radius;
      velocity.y*=-1;
    } else if (position.x + radius + velocity.x > s.x && position.x < s.x
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x-radius;
      velocity.x*=-1;
    } else if (position.x > s.x + s.w && position.x - radius + velocity.x < s.x +s.w
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x+s.w+radius;
      velocity.x*=-1;
    } else if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y > s.y + s.h && position.y-radius + velocity.y< s.y+s.h) {
      position.y=s.y+s.h+radius;
      velocity.y*=-1;
    }
  }

  boolean isInFluid(Fluid f) {
    if (position.x > f.x && position.x < f.x+f.w && position.y > f.y && position.y < f.y+f.h) {
      return true;
    } else {
      return false;
    }
  }

  void applyDrag(Fluid f) {
    float speed = velocity.mag();
    float dragSize = speed*speed*f.c;
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragSize);
    applyForce(drag);
    angleVel*=0.9;
  }

  //applyForce Function
  void applyForce(PVector force) {
    //divide force by mover mass
    PVector f = PVector.div(force, mass);
    //add the resulting vector to acceleration
    acceleration.add(f);
  }

  //applyGravity Function
  void applyGravity(PVector gravity) {
    //add the gravity vector to acceleration
    acceleration.add(gravity);
  }

  void update() {
    angleAcc = acceleration.x/10;
    angleVel += angleAcc;
    angle += angleVel;

    //add acceleration to velocity
    velocity.add(acceleration);
    //limit magnitude of velocity
    velocity.limit(topSpeed);
    //add velocity to position
    position.add(velocity);
    //reset acceleration to zero
    acceleration.mult(0);
  }

  void checkEdgesWrap() {
    if (position.x > width + radius) {
      position.x = 0 - radius;
    } else if (position.x < 0 - radius) {
      position.x = width + radius;
    }

    if (position.y > height + radius) {
      position.y = 0 - radius;
    } else if (position.y < 0 - radius) {
      position.y = height + radius;
    }
  }

  void checkEdgesBounce() {
    if (position.x > width) {
      position.x = width;
      velocity.x*=-1;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x*=-1;
    }

    if (position.y > height) {
      position.y = height;
      velocity.y*=-1;
    } else if (position.y < 0) {
      position.y = 0;
      velocity.y*=-1;
    }
  }

  void display() {
    fill(100);
    pushMatrix();
    translate(position.x,position.y);
    rotate(angle);
    rectMode(CENTER);
    rect(0, 0, radius*2, radius*2);
    popMatrix();
  }
}

class Particle {
  //declare motion vectors
  PVector position, velocity, acceleration;
  //declare top speed and display size
  float topSpeed, radius, mass;
  float angle, angleVel, angleAcc;
  int lifeSpan;
  ArrayList<Trail> trails;
  color c;


  //Constructor Function
  Particle(PVector pIn, PVector vIn, color cIn) {
    //assign initial values based on parameters passed into constructor
    position = new PVector(pIn.x, pIn.y);
    velocity = new PVector(vIn.x, vIn.y);
    acceleration = new PVector(0, 0);
    topSpeed = 10;
    radius = 10;
    mass = 1;
    lifeSpan = 255;
    c = cIn;
    trails = new ArrayList<Trail>();
  }

  void checkSolid(Solid s) {
    if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y + radius + velocity.y > s.y && position.y < s.y) {
      position.y = s.y-radius;
      velocity.y*=-1;
    } else if (position.x + radius + velocity.x > s.x && position.x < s.x
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x-radius;
      velocity.x*=-1;
    } else if (position.x > s.x + s.w && position.x - radius + velocity.x < s.x +s.w
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x+s.w+radius;
      velocity.x*=-1;
    } else if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y > s.y + s.h && position.y-radius + velocity.y< s.y+s.h) {
      position.y=s.y+s.h+radius;
      velocity.y*=-1;
    }
  }

  boolean isInFluid(Fluid f) {
    if (position.x > f.x && position.x < f.x+f.w && position.y > f.y && position.y < f.y+f.h) {
      return true;
    } else {
      return false;
    }
  }

  //function to check if particle is dead
  boolean isDead() {
    if (lifeSpan < 0) {
      return true;
    } else {
      return false;
    }
  }

  void applyDrag(Fluid f) {
    float speed = velocity.mag();
    float dragSize = speed*speed*f.c;
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragSize);
    applyForce(drag);
    angleVel*=0.9;
  }

  //applyForce Function
  void applyForce(PVector force) {
    //divide force by mover mass
    PVector f = PVector.div(force, mass);
    //add the resulting vector to acceleration
    acceleration.add(f);
  }

  //applyGravity Function
  void applyGravity(PVector gravity) {
    //add the gravity vector to acceleration
    acceleration.add(gravity);
  }

  void update() {
    lifeSpan-=3;

    if (lifeSpan%4 == 0) {
      Trail t = new Trail(position, new PVector (0, 0), c);
      t.lifeSpan = lifeSpan/2;
      trails.add(t);
    }
    //Removes dead particles
    for (int i = trails.size()-1; i > -1; i--) {
      Trail t = trails.get(i);
      if (t.isDead()) {
        trails.remove(t);
      }
    }

    //use an enhanced for loop to cycle through each particle in the arrayList
    for (Trail t : trails) {
      t.applyGravity(gravity);
      t.update();
      //p.checkEdgesBounce();
      t.display();
    }

    applyDrag(fluid);

    angleAcc = acceleration.x/10;
    angleVel += angleAcc;
    angle += angleVel;

    //add acceleration to velocity
    velocity.add(acceleration);
    //limit magnitude of velocity
    velocity.limit(topSpeed);
    //add velocity to position
    position.add(velocity);
    //reset acceleration to zero
    acceleration.mult(0);
  }

  void checkEdgesWrap() {
    if (position.x > width + radius) {
      position.x = 0 - radius;
    } else if (position.x < 0 - radius) {
      position.x = width + radius;
    }

    if (position.y > height + radius) {
      position.y = 0 - radius;
    } else if (position.y < 0 - radius) {
      position.y = height + radius;
    }
  }

  void checkEdgesBounce() {
    if (position.x > width) {
      position.x = width;
      velocity.x*=-1;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x*=-1;
    }

    if (position.y > height) {
      position.y = height;
      velocity.y*=-1;
    } else if (position.y < 0) {
      position.y = 0;
      velocity.y*=-1;
    }
  }

  void display() {
    tint(c, lifeSpan);
    image(bigLight, position.x, position.y);
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector position;
  color c;

  ParticleSystem(int x, int y) {
    //initialize the particle arrayList
    particles = new ArrayList<Particle>();
    position = new PVector(x, y);
    c = color(random(255), random(255), random(255));

    for (int i = 0; i < 50; i++) {
      //populate the arraylist with particles using a for loop
      PVector v = PVector.random2D();
      v.mult(random(3, 4));
      Particle particle = new Particle(position, v, c);
      particles.add(particle);
    }
  }

  boolean isDead() {
    if (particles.size() < 1) {
      return true;
    } else {
      return false;
    }
  }

  void run() {


    //Removes dead particles
    for (int i = particles.size()-1; i > -1; i--) {
      Particle p = particles.get(i);
      if (p.isDead()) {
        particles.remove(p);
      }
    }

    //use an enhanced for loop to cycle through each particle in the arrayList
    for (Particle p : particles) {
      p.applyGravity(gravity);
      p.update();
      //p.checkEdgesBounce();
      p.display();
    }
  }
}

class Rocket {
  PVector position, velocity;
  int fuse;
  boolean detonated;
  ArrayList<Trail> trails;

  Rocket(PVector pIn, PVector vIn) {
    position = pIn;
    velocity = vIn;
    detonated = false;
    fuse = int(random(50, 100));
    trails = new ArrayList<Trail>();
  }

  void run() {
    fuse--;
    position.add(velocity);
    if (fuse<0) {
      detonated = true;
    }
    stroke(255);
    tint(255,255);
    image(smallLight,position.x, position.y);

    if (fuse%1 == 0) {
      Trail t = new Trail(position, new PVector (0, 0), color(255));
      t.lifeSpan = 80;
      trails.add(t);
    }
    //Removes dead particles
    for (int i = trails.size()-1; i > -1; i--) {
      Trail t = trails.get(i);
      if (t.isDead()) {
        trails.remove(t);
      }
    }

    //use an enhanced for loop to cycle through each particle in the arrayList
    for (Trail t : trails) {
      t.applyGravity(gravity);
      t.update();
      //p.checkEdgesBounce();
      t.display();
    }
  }
}

class Solid{
  float x, y, w, h;

  Solid(float xIn, float yIn, float wIn, float hIn){
    x = xIn;
    y = yIn;
    w = wIn;
    h = hIn;
  }

  void display(){
    rectMode(CORNER);
    noStroke();
    fill(125);
    rect(x,y,w,h);
  }

}

class Trail extends Particle {
  Trail(PVector pIn, PVector vIn, color cIn) {
    super(pIn, vIn, cIn);
  }

  void update() {
    lifeSpan-=5;
    applyDrag(fluid);

    angleAcc = acceleration.x/10;
    angleVel += angleAcc;
    angle += angleVel;

    //add acceleration to velocity
    velocity.add(acceleration);
    //limit magnitude of velocity
    velocity.limit(topSpeed);
    //add velocity to position
    position.add(velocity);
    //reset acceleration to zero
    acceleration.mult(0);
  }

  void display() {
    tint(c,lifeSpan);
    image(smallLight, position.x, position.y);
  }
}

class Vehicle {
  //declare motion vectors
  PVector position, velocity, acceleration;
  //declare top speed and display size
  float topSpeed, radius, mass;
  float angle, angleVel, angleAcc;

  //Constructor Function
  Vehicle(PVector pIn, PVector vIn) {
    //assign initial values based on parameters passed into constructor
    position = new PVector(pIn.x, pIn.y);
    velocity = new PVector(vIn.x, vIn.y);
    acceleration = new PVector(0, 0);
    topSpeed = 10;
    radius = 20;
    mass = 1;
  }

  void checkSolid(Solid s) {
    if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y + radius + velocity.y > s.y && position.y-radius < s.y+s.h) {
      position.y = s.y-radius;
      velocity.y*=-1;
    } else if (position.x + radius + velocity.x > s.x && position.x - radius < s.x +s.w
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x-radius;
      velocity.x*=-1;
    } else if (position.x + radius > s.x && position.x - radius + velocity.x < s.x +s.w
      && position.y + radius > s.y && position.y-radius < s.y+s.h) {
      position.x = s.x+s.w+radius;
      velocity.x*=-1;
    } else if (position.x + radius > s.x && position.x - radius < s.x +s.w
      && position.y + radius > s.y && position.y-radius + velocity.y< s.y+s.h) {
      position.y=s.y+s.h+radius;
      velocity.y*=-1;
    }
  }

  boolean isInFluid(Fluid f) {
    if (position.x > f.x && position.x < f.x+f.w && position.y > f.y && position.y < f.y+f.h) {
      return true;
    } else {
      return false;
    }
  }

  void applyDrag(Fluid f) {
    float speed = velocity.mag();
    float dragSize = speed*speed*f.c;
    PVector drag = velocity.get();
    drag.normalize();
    drag.mult(-1);
    drag.mult(dragSize);
    applyForce(drag);
    angleVel*=0.9;
  }

  //applyForce Function
  void applyForce(PVector force) {
    //divide force by mover mass
    PVector f = PVector.div(force, mass);
    //add the resulting vector to acceleration
    acceleration.add(f);
  }

  //applyGravity Function
  void applyGravity(PVector gravity) {
    //add the gravity vector to acceleration
    acceleration.add(gravity);
  }

  void update() {
    //angleAcc = acceleration.x/10;
    angleVel += angleAcc;
    angle += angleVel;

    //add acceleration to velocity
    velocity.add(acceleration);
    velocity.mult(0.999);
    //limit magnitude of velocity
    velocity.limit(topSpeed);
    //add velocity to position
    position.add(velocity);
    //reset acceleration to zero
    acceleration.mult(0);
  }

  void checkEdgesWrap() {
    if (position.x > width + radius) {
      position.x = 0 - radius;
    } else if (position.x < 0 - radius) {
      position.x = width + radius;
    }

    if (position.y > height + radius) {
      position.y = 0 - radius;
    } else if (position.y < 0 - radius) {
      position.y = height + radius;
    }
  }

  void checkEdgesBounce() {
    if (position.x > width) {
      position.x = width;
      velocity.x*=-1;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x*=-1;
    }

    if (position.y > height) {
      position.y = height;
      velocity.y*=-1;
    } else if (position.y < 0) {
      position.y = 0;
      velocity.y*=-1;
    }
  }

  void display() {
    fill(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    rectMode(CENTER);
    //rect(0, 0, radius*2, radius*2);
    triangle(0,-radius,radius/2,radius,-radius/2,radius);
    popMatrix();
  }

  void vehicleKeyPressed() {
    if (keyCode == RIGHT) {
      angleVel = 0.1;
    } else if (keyCode == LEFT) {
      angleVel = -0.1;
    }
    //if up key is pressed
    if (keyCode == UP) {
      //apply a force to the vehicle IN the direction it is facing
      //create a PVector
      PVector thrust = new PVector(0,-1);
      //rotate the PVector to face in same direction as vehicle
      thrust.rotate(angle);
      //apply the force vector
      applyForce(thrust);
    }
  }

  void vehicleKeyReleased() {
    if (keyCode == RIGHT || keyCode == LEFT) {
      angleVel = 0;
    }
  }
}
