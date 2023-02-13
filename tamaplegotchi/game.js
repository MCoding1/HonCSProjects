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

var startTime, endTime;

const photo = new Boolean(false);

function setup() {
cnv = createCanvas(500, 500);
  background(250, 203, 152);
//  x = 50;
//  y = 50;
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
   photo = true;

   function start() {
  startTime = new Date();
  };
  }
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

  image(img5, 200, 287, 100, 70); // cat

  image(img7, 398, 8, 60, 40); //camera

//  image(img7, 398, 8, 60, 40); //camera

//fix time things cause its messing up popup!!!
    if (photo = true){
    image(img8, 398, 8, 60, 40); // flash camera
    // get seconds
    var seconds = Math.round(timeDiff);
    console.log(seconds + " seconds");
      if((seconds = Math.round(timeDiff))>=500){
        let photo = false;
          function end() {
            endTime = new Date();
            var timeDiff = endTime - startTime; //in ms
            // strip the ms
            timeDiff /= 1000;
            }
      }
  }else{
    image(img7, 398, 8, 60, 40); //camera
  }

//  ellipse(x,y,50,50);
//  x++;
//  y--:
//  if(dist())



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
