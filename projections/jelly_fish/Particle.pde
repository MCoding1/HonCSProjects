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
    radius = 1;
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
    acceleration.mult(0.9);
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
