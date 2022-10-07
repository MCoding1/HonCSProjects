/**
 * BeatDetection
 * by Alex Miller
 *
 * This sketch shows how to use the BeatDetector class to detect spikes
 * in sound energy that correspond to rhythmic beats. Change the sensitivity
 * value to adjust how much dampening the algorithm uses (higher values
 * make the algorithm less sensitive).
 *
 * This sketch also draws a debug view which renders the underlying energy
 * levels computed by the beat detection algorithm.
 */

import processing.sound.*;

SoundFile night;
BeatDetector beatDetector;
PImage img;

void setup() {
  fullScreen();
  background(255);
img = loadImage("band.png");

  night = new SoundFile(this, "night.mp3");
  night.loop();
  
  beatDetector = new BeatDetector(this);
  beatDetector.input(night);
  
  // The sensitivity determines how long the detector will wait after detecting
  // a beat to detect the next one.
  beatDetector.sensitivity(140);
}

void draw() {
 //background(#FFDEDF);

  // Draw debug graph in the background
  drawDebug();

  // If a beat is currently detected, light up the indicator
  if (beatDetector.isBeat()) {



    
             float s = random(0,4);
            //print(s);
  if (s >= 0 && s<1){
    background(#8049FA);


  }else if (s >= 1 && s<2){
    background(#FFD883);

  
  }else if (s >= 2 && s<3){
    background(#FA2B43);

 
  }else {
    background(#C50D66);

  } 
  tint(255, 126);
  image(img, width/8, 150);
    //image(img, 0, 0, width, height);
    fill(255); 

  } else {
    fill(0);
  }

  stroke(255);
  strokeWeight(1);
  rect(20, 20, 15, 15);
  
  fill(255);
  textAlign(LEFT, TOP);
  text("BEAT DETECTED", 40, 20);
}

void drawDebug() {
  
        float y = random(247, 255);
      float x = random(44, 255);
      float z = random(40, 50);      
      stroke(y, x, z);
  //stroke(0);
  strokeWeight(2);  
  double[] energyBuffer = beatDetector.getEnergyBuffer();
  int cursor = beatDetector.getEnergyCursor();
  float last = (float) energyBuffer[cursor] / 100 * height;
  float spacing = (float) width / (energyBuffer.length - 1);
  for (int j = 1; j < energyBuffer.length; j++) {
    int index = (j + cursor) % energyBuffer.length;    
    float energy = (float) energyBuffer[index] / 100 * height;
    line((j - 1) * spacing, height - last * 1, j * spacing, height - energy);
    last = energy;
  }

  boolean[] beatBuffer = beatDetector.getBeatBuffer();
  for (int j = 1; j < beatBuffer.length; j++) {
    int index = (j + cursor) % energyBuffer.length;
    boolean beat = beatBuffer[index];
    if (beat) {

  
     // rect(0,0,width,height);
     
      //stroke(0);
      line(j * spacing, 0, j * spacing, height);
      //float r = random(0, 255);
     // float x = random(0, 255);
      //float z = random(0, 255);      
      //fill(r, x, z); 

  float r = random(0, 2);
    if(r>= 0 && r<2){
    fill(250, 80, 61, 50);
      ellipse(j * spacing, 0, j * spacing/2, height/3);
      fill(0);
      stroke(0);
      strokeWeight(2);
      ellipse((j * spacing)-(spacing/4), 0, (j * spacing/2)/8, height/10);
      ellipse((j * spacing)+(spacing/4), 0, (j * spacing/2)/8, height/10);
      line((j * spacing)-(spacing/4), 60, (j * spacing)+(spacing/4), 60);
  }else {

      
          fill(219, 255, 230, 50);
      ellipse(j * spacing, 0, j * spacing/2, height/3);
      fill(0);
      stroke(0);
      strokeWeight(2);
      ellipse((j * spacing)-(spacing/4), 0, (j * spacing/2)/8, height/10);
      ellipse((j * spacing)+(spacing/4), 0, (j * spacing/2)/8, height/10);
      //line((j * spacing)-(spacing/4), 60, (j * spacing)+(spacing/4), 60);   
      arc((j * spacing)-(spacing/4), 60, (j * spacing/2)-20, height/10, 0, PI / 2.0);
  }
        

  
    }
  }
}
