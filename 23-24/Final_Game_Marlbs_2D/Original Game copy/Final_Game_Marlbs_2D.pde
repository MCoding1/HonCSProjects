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



//For next time:
// first go to loading screen in setup, then trigger doen variable to 1 which 
//leads the start of the loading of the sound files, then trigger done to 2 which
//allows gamestate to be start and everyhting to start running but that should only 
//happen after the pause and loading sequence is done

//scale down images
int score = 0;

//new new
int done = 0;
//

String gameState = "START";

PImage horse;
PImage trees;
PImage light;
PFont mono;
PImage darklord;
PImage girl;
PImage cobble;
PImage diamond;
PImage Jeff;
PImage home;

boolean playinghaunt = false;
boolean playinggame = false;

float transparency = 255;
import processing.sound.*;
SoundFile game;
SoundFile thunder;
SoundFile haunt;

int currentScene;
ArrayList<Scene> scenes;
//S1 s1 = new S1();
int s1 = 1;
int task = 0;
int x, y, vx, vy;

//new things
int idx = 0;
int[] indices;
int startPhase = 0;
//

void setup() {
  fullScreen();
//new
if(startPhase>0){
  game = new SoundFile(this, "game.mp3");

  haunt = new SoundFile(this, "intro.mp3");

  thunder = new SoundFile(this, "thunder.mp3");
}
//new end

  textSize(30);
  textAlign(CENTER);

    x=width/2;
    y=height/2;
    
  noCursor();
  horse = loadImage("horse.png");
  horse.resize(30, 60);

  trees = loadImage("trees.jpg");
  trees.resize(width, height);

  light = loadImage("light.png");
  
    darklord = loadImage("darklord.png");
  darklord.resize(450, 600);
  
      girl = loadImage("girl.png");
  girl.resize(100, 120);
  
    cobble = loadImage("cobble.png");
  cobble.resize(width, height);
  
    diamond = loadImage("diamond.png");
  diamond.resize(50,50);
  
      Jeff = loadImage("Jeff.png");
  Jeff.resize(1000, 1000);

      home = loadImage("home.png");
  home.resize(width, ((3*height)/4));


  currentScene = 0;
  scenes = new ArrayList<Scene>();
  //scenes.add(S1);
  
  vy=1;
  vx=1;
}


void draw() {
  
  //new stuff (was in draw previsouly)
  switch (startPhase)
  {
  case 0: // Start the setup
    println(startPhase);
//    setUpSketch();
    thread("setUpSketch");
    startPhase++;
    return;
  case 1: // During the setup
//    println(startPhase);
    showLoading();
    return;
  }
//  println("-  " + startPhase);

   //new stuff
  if (idx >= width * height)
  {
    println("Done!");
    
    noLoop();
   
    return;
  }
 
  loadPixels();
  pixels[indices[idx++]] = 0xFF000000 + idx * 64; //#000000;
  updatePixels();
  //new stuff end
  
  
  //new new if statement
  if(done == 1){
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
  }  else if (gameState == "TASK") {

    drawTask();
  }
  else if (gameState == "END") {

    drawEnd();
  }

      imageMode(CENTER);
  image(horse, mouseX, mouseY); }
}


  
  
  //new stuff cont
  
  void setUpSketch(){
  println("Starting init");
  indices = new int[width * height];
  // Generate a list of random indices
  for (int i = 1; i < indices.length; i++)
  {
    int j = int(random(0, i+1));
    indices[i] = indices[j];
    indices[j] = i;
  }
    
  delay(5000); // Lengthly initialization here: load stuff, compute things, etc.
  println("Init ended");
  background(255);
  startPhase++;
  print(startPhase);
}
 
int loadingX = (7*width)/8;
void showLoading()
{
  background(0);
  fill(255);
 // textAlign(CENTER);
  textSize(80);
  text("Super awesome game loading...", width/2, height / 2);
  noStroke();
  fill(#803CF0);
  ellipse(loadingX, 2 * (height / 3) - random(20,30), 20, 20);
    fill(#A478F2);
  ellipse(loadingX-50, 2 * (height / 3) - random(20,30), 20, 20);
    fill(#CEBDF0);
    ellipse(loadingX-100, 2 * (height / 3) - random(20,30), 20, 20);
  loadingX += 2;
  if (loadingX > width - 20)
  {
    loadingX = 20;
  }
  
            //new new
    done = 1;
    //
}

//new stuff end
  

void keyPressed() {
  if (gameState == "START") {
    gameState = "GAME";
  } else if (gameState == "END") {

    gameState = "START";
    resetGame();
  }

  if (task==1 || task==2){
    if(keyCode == UP) {
      if(y>=0){
    y=y-5;

    //y-=vy;     
      }

  }else if(keyCode == DOWN){
if(y<=height){
  y=y+5;
   // y+=vy;
 }
  }else if(keyCode == RIGHT){
    if(x<width){
   x=x+5;
// x+=vx;
 }
  }else if(keyCode == LEFT){
    if(x>=0){
   x=x-5;
 //x-=vx;
 }
  }
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
  
    image(home, width/2, height/2);
  //don't have a phone, in a random place, dont know the language, have 10,000
  //must use your wits, must make friends, must conserve resources, must make it 15 days
  //(half way across the world) get paid tuition for marlborough and college and life
  image(darklord, width/8+100, 3*height/4);
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
    task = 1;
  } else if (s1 == 3) {

      fill(#9BB4FF);
    // noStroke();
    rect(0, 700, width, 400);
    fill(#1E1921);
    text("You've found a valuable diamond! Cool beans!", width/2, height/2+280);
  }else if(s1==4){
      rect(0, 700, width, 400);
    fill(#FF4359);
    text("Task #2: Make a friend", width/2, height/2+280);
    task = 2;
  }else if (s1==5){
        fill(#9BB4FF);
    // noStroke();
    rect(0, 700, width, 400);
    fill(#1E1921);
    //have jeff here, and talk with jeff instead of the dark lord
    text("You've met Jeff! I wonder what he really thinks of you...", width/2, height/2+280);
  }
  fill(255);
  rect(width-150, height-100, 130, 30);
  fill(0);
  textSize(20);
  text("Click to continue", width-90, height-80);
}

void drawTask(){

background(#458B3F);
  image(cobble, width/2, height/2-200);



if (task==1){//find diamond takes you back to main screen
  image(diamond, width/4, height/4);
    image(girl, (x), (y));
    
  if(x<=(width/4)+50 && x>=(width/4)-50 && y<=(height/4)+50 && y>=(height/4)-50){
    println("hiiiiiii");
task = 0;
    gameState="GAME";
    s1=3;
}
}else if(task==2){
    image(Jeff, width/3, height/2);
      image(girl, (x), (y));

  if(x<=(width/3)+50 && x>=(width/3)-50 && y<=(height/2)+50 && y>=(height/2)-50){
    println("hoooooooooo");
task = 0;
    gameState="GAME";
    s1=5;
}
}
}

void drawEnd() {
  fill(#FF6AEB);
  textSize(20);
  text("It's Over!", width/2, height/4-20);
}

void mousePressed() {
  println("hi 1");
  
  //new new
  if(done ==1){
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
    }else if(s1 == 4){
            println("SCENE 4");
    }
  }
  
    if(task > 0){
  gameState = "TASK";
}
//new new
  }
  //
}
