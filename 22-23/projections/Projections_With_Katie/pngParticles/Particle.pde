class Particle {
  PVector position, velocity, acceleration;
  float topSpeed, radius, mass;
  float angle, angleVel, angleAcc;
  float r, b, g, lifeSpan, c;



  //Constructor Function
  Particle(PVector pIn, PVector vIn, float red, float blue, float green) {
    //assign initial values based on parameters passed into constructor
    position = new PVector(pIn.x,pIn.y);
    velocity = new PVector(vIn.x, vIn.y);
    acceleration = new PVector(0, 0);
    topSpeed = 10;
    radius = 10;
    mass = 1;
    r=red;
    b=blue;
    g=green;
    lifeSpan=255;
    c = (red+blue+green)/3;
  }

  boolean death() {
    if (lifeSpan<0) {
      return true;
    } else {
      return false;
    }
  }


  //applyForce Function
  void applyForce(PVector force) {
    //divide force by mover mass
    PVector f = PVector.div(force, mass);
    //add the resulting vector to acceleration
    acceleration.add(f);
  }

  //applyGravity Function
  void applyGravity() {
    //add the gravity vector to acceleration
    acceleration.add(0,-0.001);
  }

  void update() {
    lifeSpan-=1;
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

/*
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
  
*/
/*
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
*/
  void display() {
    noStroke();
    //tint(r,b,g,lifeSpan);
    tint(c, lifeSpan);
    image(light, position.x,position.y);
  }

}
