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
}
function draw() {
  // Top-left corner of the img is at (0, 0)
  // Width and height are the img's original width and height
  image(img, 0, 0, 500, 500);
  //image(img2, 160, 200, 180, 180);
  image(img4, 200, 250, 200, 200);

//  ellipse(x,y,50,50);
//  x++;
//  y--:
//  if(dist())
}

// initially hide the divs using css or js

//Use this for game states? https://stackoverflow.com/questions/15469545/how-do-you-program-game-states-in-javascript



//How to put temporary web server
//python3 -m http.server
//how to open game
//http://localhost:8000/tamaplegotchi.html
//how to close the server
//cntrl c <-NOT COMMAND C
//
