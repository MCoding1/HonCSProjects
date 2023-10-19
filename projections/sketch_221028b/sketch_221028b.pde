import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

 import processing.sound.*;
SinOsc sine;

SoundFile soundFile;
AudioIn mic;
FFT fft;
int sampleCount = 100;
int bandCount = 512;
float[] spectrum = new float[bandCount];

void setup() {
  fullScreen();
  background(255);
    
  mic = new AudioIn(this, 0);
  mic.start();
  
  fft = new FFT(this, bandCount);
  fft.input(mic);
    
  // Create the sine oscillator
  sine = new SinOsc(this);
  sine.play();
  //sine.freq(500);
  //every 60 is a whole step
  //every 30 half step
  //adding numbers goes up
  //G is 392
  //A 440
}      

//**********

public float getTotalLevel(float[] data, int begin, int end){
  if(begin >= end) return 0;
  
  float total = 0;
  
  for(int i=begin; i<end; i++)
  total += data[i];
  
  return total;
}

String isSongBeat(){
  fft.analyze(spectrum);
  float low = getTotalLevel(spectrum, 50, 100); // greater than 1
  println(low);
  if(low>.06 && low<.1){
    return "Medium";
  }else if(low>=.1){
    return "High";
  }else{
    return "Low";
  }
}
//*******

void draw() {
  
   println(isSongBeat());
   
   if (isSongBeat()=="Medium") {
   }else if(isSongBeat()=="High"){
   }else{
   }
}
