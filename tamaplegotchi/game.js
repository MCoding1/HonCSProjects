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

let on = false;

function setup() {
  createCanvas(500, 500);
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
  if (mouseX > (width*3 / (4) - 2) && mouseX < (width*3 / (4) - 2)+width/6 && mouseY > (height / 3 - 2) / 3 && mouseY < (height / 3 - 2) +height/6) {
    on = !on
  }
}

let img;
let img2;
let img3;
let img4;
function preload() {
  img = loadImage('data/shell.png');
  img2 = loadImage('data/cat.png');
  img3 = loadImage('data/orangecat.png');
  img4 = loadImage('data/catsleep.png');
  img5 = loadImage('data/realcat.png');
  img6 = loadImage('data/home.png');
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

//  ellipse(x,y,50,50);
//  x++;
//  y--:
//  if(dist())



//////***/////////***/////////***/////////***/////////***/////////***/////////***///

//pop-up
  let square = {
    x: random(width*3 / (4) - 2, width*3 / (4) + 2),
    y: random(height / 3 - 2, height / 3 + 2),
    w: width / 6,
    h: height / 6,
  }


  //draw a rectangle
  noStroke();
  fill(255, 255, 255);
  rect(square.x, square.y, square.w, square.h);


  fill(0);
  textSize(10);
  text('A Tamagotchi?', 383, 215);

  //let the rectangle pop when mouse is inside of it
  if (mouseX > (width*3 / (4) - 2) && mouseX < (width*3 / (4) - 2)+width/6 && mouseY > (height / 3 - 2) / 3 && mouseY < (height / 3 - 2) +height/6) {
    square.x = width / 3;
    square.y = height / 3;square.w = square.w * 2
    square.h = square.h * 2
  }

  //define "on"
  if (on) {
    noStroke();
    fill(255, 236, 184);
    rect(width / 3, height / 3, width / 3, height / 3);

    fill(0);
    textSize(10);
    text('This is a Tamagotchi...', 191, 215);
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
