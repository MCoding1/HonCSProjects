//visual novel game (do in p5js so can do on website)
//Journey to find marlborough
//don't have a phone, in a random place, dont know the language, have 10,000
//must use your wits, must make friends, must conserve resources, must make it 15 days
//(half way across the world) get paid tuition for marlborough and college and life

//Music Credits:
//Main Theme (Overture) | The Grand Score by Alexander Nakarada | https://creatorchords.com/
//Music promoted by https://www.chosic.com/free-music/all/
//Attribution 4.0 International (CC BY 4.0)
//https://creativecommons.org/licenses/by/4.0/


//new class called dialogue, in it have all different variables to show per dialogue including text person or color etc, in each scene (s1) as creating in main class input arraylist of dialogue for that one scene, in scene 1 as mouse clicks you go through arraylist of dailogues

String gameState = "START";
int score = 0;

PImage horse;
PImage trees;
PImage light;
PFont mono;

boolean playinghaunt = false;
boolean playinggame = false;
boolean scene1 = false;
boolean scene2 = false;
boolean scene3 = false;

float transparency = 255;
import processing.sound.*;
SoundFile game;
SoundFile thunder;
SoundFile haunt;

int currentScene;
//ArrayList<Scene> scenes;
//S1 s1 = new S1();
int s1 = 1;

void setup() {
  fullScreen();

  game = new SoundFile(this, "game.mp3");

  haunt = new SoundFile(this, "intro.mp3");

  thunder = new SoundFile(this, "thunder.mp3");

  textSize(30);
  textAlign(CENTER);

  noCursor();
  horse = loadImage("horse.png");
  horse.resize(30, 60);

  trees = loadImage("trees.jpg");
  trees.resize(width, height);

  light = loadImage("light.png");

  //currentScene = 0;
  //scenes = new ArrayList<Scene>();
  //scenes.add(S1);
}


void draw() {
  background(#9862FF);
  noCursor();

  //change to different screens
  if (gameState == "START") {
    if (!playinghaunt) {
      haunt.loop();
      playinghaunt = true;
    }
    playinggame = false;
    game.stop();
    drawStart();
  } else if (gameState == "GAME") {
    haunt.stop();
    if (!playinggame) {
      game.loop();
      playinggame = true;
    }
    playinghaunt = false;

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
  //  haunt.play();
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
  text("Press Space To Begin (IF YOU DARE)", width/2, height/2+100);

  textSize(20);
  text("Click For A Surprise", width/8, height/16);
}

void drawGame() {

  background(#DEADFF);

  textSize(20);
  //don't have a phone, in a random place, dont know the language, have 10,000
  //must use your wits, must make friends, must conserve resources, must make it 15 days
  //(half way across the world) get paid tuition for marlborough and college and life

  if (s1 == 1) {
    fill(#9BB4FF);
    // noStroke();
    rect(0, 700, width, 400);
    fill(#1E1921);
    text("Welcome, you are currently in a random place in the world. What I can tell you is that you are half way across the world from the infamous Marlborough School in Los Angeles California. \n I’ve given you 40 days to make it half way across the world. You may notice your phone is missing, this is by design. You only have 10,000 dollars and your wits to make it across. \n  Be careful who you befriend, and remember to conserve your resources...we wouldnt want a dire sitation on our hands, this is only a game ofcourse. And if you win? Fully paid tuition for any educational \n advancements for life, including any degrees your heart and wits desire. Now run along! The time is ticking...", width/2, height/2+280);
  } else if (s1 == 2) {
    rect(0, 700, width, 400);
    fill(#FF4359);
    text("Task #1: Explore the surrouding area", width/2, height/2+280);
  } else if (s1 == 3) {
    rect(0, 700, width, 400);
    fill(#FF4359);
    text("Task #2: Make a friend", width/2, height/2+280);
  }
  fill(255);
  rect(width-150, height-100, 130, 30);
  fill(0);
  textSize(20);
  text("Click to continue", width-90, height-80);
}

void drawEnd() {
  fill(#FF6AEB);
  textSize(20);
  text("It's Over!", width/2, height/4-20);
}

void mousePressed() {
  println("hi 1");
  if (gameState == "START") {
    if (transparency > 0) {
      transparency -= 0.1;
    }
    tint(255, transparency);
    image(light, random(0, width), random(0, height/2));
    thunder.play();
    noTint();
  }

  if (gameState == "GAME") {
    println("hi 2");

    s1=s1+1;

    if (s1 == 1) {

      println("SCENE 1");
    } else if (s1 == 2) {
      println("SCENE 2");
    } else if (s1 == 3) {
      println("SCENE 3");
    }
  }
}
