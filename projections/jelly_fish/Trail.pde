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
    tint(0,lifeSpan);
    image(smallLight, position.x, position.y);
  }
}
