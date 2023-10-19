//
// hello_fft.pde
//


import processing.sound.*;


AudioIn mic;
SoundFile soundFile;

Waveform waveform;
FFT fft;

int sampleCount = 100;
int bandCount = 512;
float[] spectrum = new float[bandCount];


ArrayList<Particle> particles;


void setup()
{
    size(1000, 800);
    background(255);

    waveform = new Waveform(this, sampleCount);
    fft = new FFT(this, bandCount);

    mic = new AudioIn(this, 0);
    mic.start();

    soundFile = new SoundFile(this, "superstylin.mp3");
    soundFile.play();

    waveform.input(soundFile);
    fft.input(soundFile);

    particles = new ArrayList<Particle>();
}

void draw()
{
    background(0);
    fft.analyze(spectrum);

    stroke(255);

    drawWaveform();
    drawFFT();
    drawCircles();

    for (Particle p : particles)
        p.draw();

    for (int i=particles.size()-1; i>=0; i--)
    {
        PVector position = particles.get(i).position;
        if (position.x < 0 || position.x > width)
            particles.remove(i);
    }
}


void drawWaveform()
{
    waveform.analyze();

    beginShape();
    for(int i=0; i<sampleCount; i++)
    {
      vertex(
        map(i, 0, sampleCount, 0, width),
        map(waveform.data[i], -1, 1, 0, height*.25)
      );
    }
    endShape();
}


void drawFFT()
{
    for(int i=0; i<bandCount; i++)
    {
        float x = map(i, 0, bandCount, 0, width);
        line(x, height/2, x, height/2-spectrum[i]*height/2*5);
    }
}


void drawCircles()
{
    float low = getTotalLevel(spectrum, 0, 5);
    float mid = getTotalLevel(spectrum, 5, 50);
    float high = getTotalLevel(spectrum, 50, bandCount);

    int minSize = width/10;
    int maxSize = width/6;
    float lowSize = map(low, 0, 1, minSize, maxSize);
    float midSize = map(mid, 0, 1, minSize, maxSize);
    float highSize = map(high, 0, 1, minSize, maxSize);

    noStroke();
    fill(255, 0, 0);
    ellipse(width*.25, height*.75, lowSize, lowSize);

    fill(0, 255, 0);
    ellipse(width*.5, height*.75, midSize, midSize);

    fill(0, 0, 255);
    ellipse(width*.75, height*.75, highSize, highSize);

    fill(255);
    textAlign(CENTER);
    text("particles: " + particles.size(), width/2, height*.95);

    if (low > .3)
        addParticle();
}


void addParticle()
{
    PVector position = new PVector(width/2, height*.95);
    float angle = random(-3*PI/4, -PI/4);
    PVector velocity = PVector.fromAngle(angle);
    velocity.setMag(random(3, 5));
    particles.add(new Particle(position, velocity));
}


float getTotalLevel(float[] data, int begin, int end)
{
    if (begin >= end) return 0;

    float total = 0;

    for (int i=begin; i<end; i++)
        total += data[i];

    return total;
}
