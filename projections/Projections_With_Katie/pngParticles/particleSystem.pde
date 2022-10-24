class particleSystem {
  ArrayList<Particle> particles;
  PVector gravity;
  PVector position;
  float r, b, g;
  float lifeSpan= 100;
  particleSystem(float x, float y) {
    particles = new ArrayList <Particle>();
    gravity = new PVector(0, 0.1);
    position = new PVector (x, y);
    r= random(255);
    b= random(255);
    g= random(255);
  }
  void run() {
    if (lifeSpan>0) {
      for (int i=0; i<1; i++) {
        Particle p = new Particle(new PVector(position.x, position.y), new PVector (random(-1, 1), random(-1, 1)), r, b, g);
        particles.add(p);
      }
    }
    position.add(0, 0);
    for (int i = particles.size()-1; i > -1; i--) {
      Particle p = particles.get(i);
      if (p.death()) {
        particles.remove(p);
      }
    }
    for (Particle p : particles) {

      p.applyGravity();
      p.update();
      p.display();
      //p.checkEdgesBounce();
    }
    lifeSpan--;
  }
  boolean dead(){
    return particles.size()==0;
  }
}
