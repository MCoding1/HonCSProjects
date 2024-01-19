//visual novel game (do in p5js so can do on website)
//Journey to find marlborough
//don't have a phone, in a random place, dont know the language, have 10,000
//must use your wits, must make friends, must conserve resources, must make it 15 days
//(half way across the world) get paid tuition for marlborough and college and life

// put in game cursor
//put sally on start screen

//Music Credits:
//Main Theme (Overture) | The Grand Score by Alexander Nakarada | https://creatorchords.com/
//Music promoted by https://www.chosic.com/free-music/all/
//Attribution 4.0 International (CC BY 4.0)
//https://creativecommons.org/licenses/by/4.0/
String gameState = "START";
int score = 0;

PImage horse;
PImage trees;
PImage light;
       PFont mono;
       
       float transparency = 255;
import processing.sound.*;
SoundFile game;
SoundFile thunder;

void setup(){
fullScreen();

  game = new SoundFile(this, "game.mp3");
  game.loop();
  
    thunder = new SoundFile(this, "thunder.mp3");

  textSize(30);
  textAlign(CENTER);
 
    noCursor();
   horse = loadImage("horse.png");
    horse.resize(30,60);

       trees = loadImage("trees.jpg");
    trees.resize(width,height);
    
           light = loadImage("light.png");
 
}


void draw(){
background(#9862FF);

//change to different screens
  if (gameState == "START") {
    drawStart();
  } else if (gameState == "GAME") {
    drawGame();
  } else if (gameState == "END") {
    drawEnd();
  }

  imageMode(CENTER);
   image(horse, mouseX, mouseY);
}

void keyPressed() {
  if (gameState == "START") {
    gameState = "GAME";
  } else if (gameState == "END") {
    gameState = "START";
    resetGame();
  }
}

  void resetGame() {
    score = 0;
  }
  
  void drawStart() {
background(#9862FF);
tint(255, 126);
image(trees, width/2, height/2);


    noTint();
           mono = createFont("The_Centurion.ttf", 128);
    textFont(mono);
fill(255);
  textSize(80);
  text("Journey To Find Marlborough", width/2, height/2);
    textSize(30);
  text("Don't Press Space", width/2, height/2+100);
  
    textSize(20);
  text("Click For A Surprise", width/8, height/16);
}

void drawGame() {
  fill(#FF6AEB);
  textSize(20);
  text("Do this to win!", width/2, height/4-20);

}

void drawEnd() {
  fill(#FF6AEB);
  textSize(20);
  text("It's Over!", width/2, height/4-20);

}
  
  void mousePressed() {
    if (gameState == "START") {
 if (transparency > 0) {
 transparency -= 0.1; 
 }
  tint(255, transparency);
           image(light, random(0,width), random(0,height/2));
      thunder.play();
noTint();
  } 
}
