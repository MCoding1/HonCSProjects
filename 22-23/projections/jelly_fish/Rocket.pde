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
    stroke(0);
    tint(0, 0);
    image(smallLight,position.x, position.y);

    if (fuse%1 == 0) {
      Trail t = new Trail(position, new PVector (0, 0), color(255));
      t.lifeSpan = 10;
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
