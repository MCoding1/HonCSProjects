//when rocket detenates it makes a particle system, numbers at bottom are number of particle systems which also have life spans
ArrayList<ParticleSystem> systems;
ArrayList<Rocket> rockets;
PVector gravity;
PVector wind;
Fluid fluid;
PImage bigLight;
PImage smallLight;

ParticleSystem ps;

void setup() {
  fullScreen();

  fluid = new Fluid(0, 0, width, height, 0.01);
  gravity = new PVector(0.01, .003);
  wind = new PVector(0, 0);

  systems = new ArrayList<ParticleSystem>();
  rockets = new ArrayList<Rocket>();
  bigLight = loadImage("whiteLight.png");
//  bigLight.resize(25, 25);
  bigLight.resize(50, 40);
  smallLight = loadImage("whiteLight.png");
  smallLight.resize(8, 8);
  imageMode(CENTER);
}

void draw() {
  blendMode(ADD);
  background(0);
  if (millis() % 10 == 0) {
    PVector launchPoint = new PVector(width/2, height);
    PVector mouse = new PVector(random(width), random(height/2));
    PVector dir = PVector.sub(mouse, launchPoint);
    dir.normalize();
    dir.mult(random(5, 10));
    Rocket rock = new Rocket(launchPoint, dir);
    rockets.add(rock);
  }
  for (int i = rockets.size()-1; i >-1; i--) {
    Rocket r = rockets.get(i); 
    r.run(); 
    if (r.detonated) {
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
