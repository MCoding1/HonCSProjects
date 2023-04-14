//have camera and popup drawing first in an outside function, then go into game states for the screen
//click screen to start game, click screen to restart game, left button goes to settings and moves through options, middle button selects option, right button goes back
// or we can do left button settings, arrow keys to go through options, middle button to select and right button to go home?
//get game screen for home, shop, and "action room" running, be able to name pet once on start screen, score changes when feed pet, if feed pet too much dies, end screen, get under the hood working
//or can have start screen and end, left button goes to left side shop, right button goes to right side action room, middle button goes home, buy things by clicking on then and will get popup yes or no clik Y yes or N no

//function setup()
//{
  //let fs = fullscreen();
  //fullscreen(!fs);
//background(0);
  //createCanvas(800, 800);



//}

//function draw()
//{
//createCanvas(fullscreen());

//}

//!!!!!!UOI@IU#$UOI#O# use assignment 9 from processing semester 1 for game states

//make egg wiggle and cat hatch, name cat, have time running? have a pause, age and weight funciton?
//Feed pet food (burger/bread (japanese fish ice cream?)) or snack (cake, candy), play with pet to make happy
// take pet to bathroom
//pet complain/scold
//if overfed or not taken to bathroom or not play will get sick and fall
//can cure pet by using one medecine option
//Baby, Child, Teenager, Adult growth stages over time (evolve)
//when pet old or not cared for it dies, if it didnt have a kid the family line ends
//currency called Gotchi Points while playing games, and can use the currency in an in-game
//shop to buy different foods, toys, accessories, or even room decorations for the pet

let on = false;

let action = false;

let home = true;

let shop = false;

var startTime, endTime;

const photo = new Boolean(false);


function setup() {
cnv = createCanvas(500, 500);
  background(250, 203, 152);
//  x = 50;
//  y = 50;
}

let img;
let img2;
let img3;
let img4;
let img5;
let img6;
let img7;
let img8;
function preload() {
  img = loadImage('data/shell.png');
  img2 = loadImage('data/cat.png');
  img3 = loadImage('data/orangecat.png');
  img4 = loadImage('data/catsleep.png');
  img5 = loadImage('data/realcat.png');
  img6 = loadImage('data/home.png');
  img7 = loadImage('data/camera.png');
  img8 = loadImage('data/flash.png');
  img9 = loadImage('data/house.png');
  img10 = loadImage('data/left.png');
  img11 = loadImage('data/right.png');
  img12 = loadImage('data/shop.png');
  img13 = loadImage('data/action.png');
}

function mousePressed() {
  if (mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 100) {
    let fs = fullscreen();
    fullscreen(!fs);
  }
//pop-up
  //light up the rectangle when clicking inside of it
  if (mouseX > (width*3 / (4) + 20) && mouseX < (width*3 / (4) + 20)+width/8 && mouseY > (height / 3 - 110) && mouseY < (height / 3 - 110) +height/8) {
    on = !on
  }

  if (mouseX > 400 && mouseX < 454 && mouseY > 8 && mouseY < 40) {
   save(cnv, 'myCanvas.jpg');
   //console.log(result);
  // photo = true;

  // function start() {
//  startTime = new Date();
  //};
  }

  //action screen
  if (mouseX > 192 && mouseX < 207 && mouseY > 398 && mouseY < 413) {
    action = true;
    home = false;
    shop = false;
    //image(img13, 172, 205, 150, 147); //action

    //image(img5, 230, 287, 80, 55); // cat
    //image(img5, 230, 287, 200, 55); // mega cat

  }

  //home screen
  if (mouseX > 237 && mouseX < 252 && mouseY > 410 && mouseY < 425) {
    home = true;
    action = false;
    shop = false;
  }
  //shop screen
  if (mouseX > 285 && mouseX < 300 && mouseY > 400 && mouseY < 415) {
    shop = true;
    home = false;
    action = false;
  }
}

function draw() {

  noStroke();
  fill(255, 181, 218);
  rect(0,0,48,20);
  fill(255);
  textSize(8);
  text('Fullscreen', 5, 12);


  // Top-left corner of the img is at (0, 0)
  // Width and height are the img's original width and height
  image(img, 0, 0, 500, 500);
  //image(img2, 160, 200, 180, 180);
  image(img6, 172, 205, 150, 147); //home

  image(img5, 230, 287, 80, 55); // cat

  image(img7, 398, 8, 60, 40); //camera

//  image(img7, 398, 8, 60, 40); //camera

//fix time things cause its messing up popup!!!
  //  if (photo = true){
  //  image(img8, 398, 8, 60, 40); // flash camera
    // get seconds
  //  var seconds = Math.round(timeDiff);
  //  console.log(seconds + " seconds");
  //    if((seconds = Math.round(timeDiff))>=500){
    //      function end() {
      //      endTime = new Date();
        //    var timeDiff = endTime - startTime; //in ms
            // strip the ms
        //    timeDiff /= 1000;
          //  }

  //    }
  //}else{
  //  image(img7, 398, 8, 60, 40); //camera
  //}

//  ellipse(x,y,50,50);
//  x++;
//  y--:
//  if(dist())

//game screens

//action screen
if (action){
  image(img13, 172, 205, 150, 147); //action

  image(img5, 230, 298, 80, 55); // cat
}

//home Fullscreen
if (home){
  image(img6, 172, 205, 150, 147); //home

  image(img5, 235, 300, 60, 40); // cat
}
//shop Fullscreen
if (shop){
  image(img12,172, 205, 150, 147); //shop

  image(img5, 170, 300, 80, 55); // cat
}

//////***/////////***/////////***/////////***/////////***/////////***/////////***///

//pop-up
  let square = {
    x: random(width*3 / (4) + 20, width*3 / (4) + 24),
    y: random(height / 3 - 110, height / 3 - 114),
    w: width / 8,
    h: height / 8,
  }



  //draw a rectangle
  noStroke();
  fill(random(0,255),random(0,10),random(150,160));
  rect(square.x, square.y, square.w, square.h);


  fill(255);
  textSize(8);
  text('A Tamagotchi?', 405, 89);

  //let the rectangle pop when mouse is inside of it
  if (mouseX > (width*3 / (4) + 20) && mouseX < (width*3 / (4) + 20)+width/8 && mouseY > (height / 3 - 110) && mouseY < (height / 3 - 110) +height/8) {
    square.x = width / 3;
    square.y = height / 3;square.w = square.w * 2
    square.h = square.h * 2
  }

  //define "on"
  if (on) {
    noStroke();
    fill(255, 236, 184);
    rect(width / 3, height / 3 + 20, width / 3, height / 3);

    textSize(9);
    fill(0);
    textWrap(WORD);
    text('Tamagotchi was a portmanteau combining the two Japanese words tamago (たまご), which means "egg", and uotchi (ウオッチ) "watch". My game is an online version, and my virtual spin off is a game where you watch over a cat named maple for TaMAPLEgotchi. Tamagotchi was invented by Aki Maita and released by Bandai on November 23, 1996 in Japan and in the USA on May 1, 1997, quickly becoming one of the biggest toy fads of the late 1990s and the early 2000s.', 181, 195, width /3 - 13);
  }


  //////***/////////***/////////***/////////***/////////***/////////***/////////***///

//oxff RGB (#color does not work in java or javascript)
fill(255, 239, 85);
ellipse(200, 404, 20, 20);
ellipse(245, 417, 20, 20);
ellipse(290, 406, 20, 20);

image(img9, 237, 410, 15, 15); //house
image(img10, 192, 398, 15, 15); //left
image(img11, 285, 400, 15, 15); //right
}

// initially hide the divs using css or js

//Use this for game states? https://stackoverflow.com/questions/15469545/how-do-you-program-game-states-in-javascript



//How to put temporary web server
//python3 -m http.server
//how to open game
//http://localhost:8000/tamaplegotchi.html
//how to close the server
//cntrl c <-NOT COMMAND C
//to update it do shift + reload
