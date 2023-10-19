class ParticleSystem {
  ArrayList<Particle> particles;
  PVector position;
  color c;

  ParticleSystem(int x, int y) {
    //initialize the particle arrayList
    particles = new ArrayList<Particle>();
    position = new PVector(x, y);
    //c = color(random(255), random(255), random(255));
    float r = random(0,255);
    c = color(r, r, r);
    
    for (int i = 0; i < 90; i++) {
      //populate the arraylist with particles using a for loop
      PVector v = PVector.random2D();
//      v.mult(random(3, 4));      
      v.mult(random(3, 4));
      Particle particle = new Particle(position, v, c);
      particles.add(particle);
    }
  }

//checks size of particle array list so if there are no more it returns true so they can be removed after fading
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
