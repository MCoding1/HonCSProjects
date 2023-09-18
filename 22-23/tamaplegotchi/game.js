//taMAPLEgotchi Simulator by: Melodie


//game walkthrough, a key feature I liked (variable methods/local server), future steps(email/progress server, evolution)


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

let x = 221;
let y = 321;
let score = 0;

let on = false; //popup

let pressed = false; //car hood

let action = false;

let home = true;

let shop = false;

let goodbye = false;

let message = false;

let feed = 0;
let play = 0;
let bath = 0;

let purple = false;
let white = false;
let teddy = false;
let doll = false;
let light = false;
let cake = false;
let cat = false;
let mouse = false;

//let mySound = new Audio('smoke.mp3')
//mySound.play()

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
let img9;
let img10;
let img11;
let img12;
let img13;
let img14;
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
  img14 = loadImage('data/plant2.png');//purple plant
  img15 = loadImage('data/plant1.png');//white plant
  img16 = loadImage('data/bear.png');//teddy bear
  img17 = loadImage('data/pet.png');//black cat pet
  img18 = loadImage('data/light.png');//chandelier light
 img19 = loadImage('data/mouse.png');//pet mouse
  img20 = loadImage('data/cake.png');//cake
  img21 = loadImage('data/coin.png');//coin
  img22 = loadImage('data/trunk.png');//under the hood car
    img23 = loadImage('data/low.png');//red low bar
 img24 = loadImage('data/medium.png');//yellow medium bar
 img25 = loadImage('data/high.png');//high light green bar
 img26 = loadImage('data/superhigh.png');//dark green full bar
  img27 = loadImage('data/coinscore.png');//yellow box to track coin score
  img28 = loadImage('data/food.png');//fish to go next to food bar
  img29 = loadImage('data/play.png');//yarn to go next to play bar
  img30 = loadImage('data/bath.png');//bathtub to go next to bath clean bar
  img31 = loadImage('data/bought.png');//bought sign
 img32 = loadImage('data/buy.png');//buy sign
 img33 = loadImage('data/doll.png');//red doll in shop
 img34 = loadImage('data/end.png');//ending background with bus stop
 img35 = loadImage('data/endcat.png');//ending cat with backpack
 img36 = loadImage('data/bus.png');//ending bus with school name
 img37 = loadImage('data/theend.png'); //pixel font says The End for finale
  img38 = loadImage('data/fish.png');//fish action
  img39 = loadImage('data/yarn.png');//yarn action
  img40 = loadImage('data/bathtub.png');//bath action
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

  //pop-up for car hood
    if (mouseX > 30 && mouseX < 84 && mouseY > 415 && mouseY < 473) {
      pressed = !pressed
    }

//clicker for food action
  if (mouseX > 186 && mouseX < 220 && mouseY > 318 && mouseY < 340 && action == true) {
    if(feed<3){
      feed += 1; //fed
      score += 10;
      if(play>0){
      play -=1;
      }

    }
  }

  //clicker for play action
    if (mouseX > 283 && mouseX < 317 && mouseY > 291 && mouseY < 319 && action == true) {
      if(play<3){
        play += 1; //played
        score += 10;
        if(feed>0){
        feed -=1;
        }
if(bath>0){
        bath -=1;
}
      }
    }

    //clicker for bath action
      if (mouseX > 210 && mouseX < 272 && mouseY > 276 && mouseY < 300 && action == true) {
        if(bath<3){
          bath += 1; //bathed
          score += 10;

        }
      }

      //buy purple plant
        if (mouseX > 232 && mouseX < 252 && mouseY > 278 && mouseY < 287 && shop == true) {
          if(score>=10){
              purple = true;
              score -=10;
          }

        }

        //buy white plant
          if (mouseX > 300 && mouseX < 315 && mouseY > 278 && mouseY < 285 && shop == true) {
            if(score>=10){
                white = true;
                score -=10;
            }

          }
          //buy teddy
            if (mouseX > 255 && mouseX < 270 && mouseY > 278 && mouseY < 285 && shop == true) {
              if(score>=10){
                  teddy = true;
                  score -=10;
              }

            }
            //buy doll
              if (mouseX > 278 && mouseX < 291 && mouseY > 278 && mouseY < 285 && shop == true) {
                if(score>=10){
                    doll = true;
                    score -=10;
                }

              }
              //buy light
                if (mouseX > 270 && mouseX < 287 && mouseY > 209 && mouseY < 219 && shop == true) {
                  if(score>=10){
                      light = true;
                      score -=10;
                  }

                }

                //buy cake
                  if (mouseX > 293 && mouseX < 308 && mouseY > 304 && mouseY < 312 && shop == true) {
                    if(score>=10){
                        cake = true;
                        score -=10;
                    }

                  }

                  //buy cat
                    if (mouseX > 270 && mouseX < 284 && mouseY > 346 && mouseY < 352 && shop == true) {
                      if(score>=10){
                          cat = true;
                          score -=10;
                      }

                    }

                    //buy mouse
                      if (mouseX > 300 && mouseX < 316 && mouseY > 346 && mouseY < 352 && shop == true) {
                        if(score>=10){
                            mouse = true;
                            score -=10;
                        }

                      }

                      //end screen
                        if (mouseX > 172 && mouseX < 326 && mouseY > 211 && mouseY < 350 &&message == true) {

                            goodbye = true;


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


  image(img38, 184, 317, 40, 25);//fish

  image(img39, 270, 291, 50, 50);//yarn

    //image(img40, 210, 250, 70, 60);//bath

  image(img5, 230, 310, 70, 45); // cat
  /*

  img38 = loadImage('data/fish.png');//fish action
  img39 = loadImage('data/yarn.png');//yarn action
  img40 = loadImage('data/bathtub.png');//bath action
  */
}

//home Fullscreen
if (home){
  image(img6, 172, 205, 150, 147); //home

  image(img5, 235, 300, 60, 40); // cat

  if(purple){
    image(img14, 168, 277, 40, 40);
  }
  if(white){
  image(img15, 285, 310, 40, 40);
  }
  if(teddy){
  image(img16, 245, 270, 30, 30);
  }
  if(doll){
  image(img33, 72, 270, 150, 147);
  }
  if(light){
  image(img18, 245, 200, 50, 50);//chandelier
  }
  if(cake){
  image(img20, 272, 285, 25, 25); //cake
  }
  if(cat){
    image(img17, 258, 328, 35, 35);
  }
  if(mouse){
    image(img19, 218, 315, 30, 20);
  }
}

/*
let white = false;
let teddy = false;
let doll = false;
let light = false;
let cake = false;
let cat = false;
let mouse = false;
*/

//shop Fullscreen
if (shop){
  image(img12,172, 205, 150, 147); //shop

  image(img5, 180, 300, 80, 55); // cat

  //shop elements
  image(img16, 245, 250, 35, 35); //teddy
  image(img32, 250, 275, 40, 40);//shop sign for teddy

  image(img14, 218, 230, 48, 48); //purple plant
  image(img32, 230, 275, 40, 40);//shop sign for purple plant

  image(img15, 285, 238, 40, 40); //white plant
  image(img32, 294, 275, 40, 40);//shop sign for white plant

  image(img18, 252, 207, 50, 50);//chandelier
  image(img32, 265, 205, 40, 40);//shop sign for chandelier

  image(img33, 172, 205, 150, 147); //red doll in shop
  image(img32, 272, 275, 40, 40);//shop sign for doll

  image(img20, 292, 285, 30, 30); //cake
  image(img32, 288, 300, 40, 40);//shop sign for cake

  image(img19, 288, 325, 30, 20); //pet mouse
  image(img32, 295, 340, 40, 40);//shop sign for pet mouse

  image(img17, 258, 325, 30, 30); //black cat pet
  image(img32, 265, 340, 40, 40);//shop sign for pet cat
  /*

  img16 = loadImage('data/bear.png');//teddy bear
  img17 = loadImage('data/pet.png');//black cat pet

  img19 = loadImage('data/mouse.png');//pet mouse
  img20 = loadImage('data/cake.png');//cake
  img33 = loadImage('data/doll.png');//red doll in shop
  */

  if(purple){
      image(img31, 230, 275, 40, 40);//shop sign for purple plant
  }
  if(white){
    image(img31, 294, 275, 40, 40);//shop sign for white plant
  }
  if(teddy){
    image(img31, 250, 275, 40, 40);//shop sign for teddy
  }
  if(doll){
    image(img31, 272, 275, 40, 40);//shop sign for doll
  }
  if(light){
    image(img31, 265, 205, 40, 40);//shop sign for chandelier
  }
  if(cake){
    image(img31, 288, 300, 40, 40);//shop sign for cake
  }
  if(cat){
    image(img31, 265, 340, 40, 40);//shop sign for pet cat
  }
  if(mouse){
    image(img31, 295, 340, 40, 40);//shop sign for pet mouse
  }
}

//le stats

  image(img21, 177, 210, 15, 15); //coin
  image(img27, 190, 208, 40, 20); //yellow box for coin

  //draw score here

  image(img23, 190, 218, 40, 20); //red low bar food
    image(img23, 190, 223, 40, 20); //red low bar play
      image(img23, 190, 228, 40, 20); //red low bar bath

      image(img29, 173, 220, 20, 20); //yarn
            image(img28, 170, 220, 30, 13); //fish
        image(img30, 173, 233, 20, 13);//bath

        fill(0);
        textSize(8);
        text(score, 197, 221);

        if(feed==0){
  image(img23, 190, 218, 40, 20); //red low bar food
        }else if(feed==1){
            image(img24, 190, 218, 40, 20); //yellow medium bar food
        }else if(feed==2){
              image(img25, 190, 218, 40, 20); //high light green bar food
        }else{
              image(img26, 190, 218, 40, 20); //dark green full food
        }

        if(play==0){
    image(img23, 190, 223, 40, 20); //red low bar play
        }else if(play==1){
            image(img24, 190, 223, 40, 20); //yellow medium bar food
        }else if(play==2){
              image(img25, 190, 223, 40, 20); //high light green bar food
        }else{
              image(img26, 190, 223, 40, 20); //dark green full food
        }

        if(bath==0){
      image(img23, 190, 228, 40, 20); //red low bar bath
}else if(bath==1){
            image(img24, 190, 228, 40, 20); //yellow medium bar food
        }else if(bath==2){
              image(img25, 190, 228, 40, 20); //high light green bar food
        }else{
              image(img26, 190, 228, 40, 20); //dark green full food
        }
/*

img27 = loadImage('data/coinscore.png');//yellow box to track coin score

  img23 = loadImage('data/low.png');//red low bar
img24 = loadImage('data/medium.png');//yellow medium bar
img25 = loadImage('data/high.png');//high light green bar
img26 = loadImage('data/superhigh.png');//dark green full bar

img28 = loadImage('data/food.png');//fish to go next to food bar
img29 = loadImage('data/play.png');//yarn to go next to play bar
img30 = loadImage('data/bath.png');//bathtub to go next to bath clean bar
*/

//bought everything and is rich
if (purple==true && white == true && teddy == true && doll==true && light == true && cake == true && cat == true && mouse == true && score>=300){
  noStroke();
  fill(20, 20, 0);
  rect(173, 206, 154, 151);

  fill(255);
  textSize(8);
  textWrap(WORD);
  text('Wow! Maple is able to live comfortably now with all the new room additions, and she is very wealthy too! And how the time flies! Looks like Maple is already all grown up! And she just got into Maplewood Academy for gifted felines, you must be very proud! Good thing you have been saving up, she can use these coins now for her university expenses! Would you like to say goodbye? (Click in this box to continue)', 182, 219, 129);
  message = true;

  if(goodbye == true){
    //goodbye sequence
    image(img34, 172, 205, 153, 149);
    image(img35,230,245, 48, 32);
    image(img36,196,307, 70, 41);
    image(img37,x,y, 87,22);
    while(y>215){
      y-=1;
    }
    /*
    img34 = loadImage('data/end.png');//ending background with bus stop
    img35 = loadImage('data/endcat.png');//ending cat with backpack
    img36 = loadImage('data/bus.png');//ending bus with school name
    img37 = loadImage('data/theend.png'); //pixel font says The End for finale
    */
  }
}

/*
let purple = false;
let white = false;
let teddy = false;
let doll = false;
let light = false;
let cake = false;
let cat = false;
let mouse = false;
*/

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
//car hood popup

  image(img22, 20, 410, 70, 70); //car hood

  fill(255);
  textSize(8);
  text('Hmmm..', 40, 450);

  if (pressed){
    noStroke();
    fill(57, 133, 66);
    rect(152, 186, 200, 177);

    fill(255);
    textSize(9);
    textWrap(WORD);
    text('Looks like you are checking under the hood! Well if you REALLY want to know how I made this game let me tell you... It was programmed using Javascript, specifically p5js! The website in green was made with HTML, and styled with CSS! You can learn to code too! To get started on p5js go to p5js.org and access the free tutorials online. You can also two finger click on the screen and click "Inspect" to check out my code! To watch my game walkthrough video check out this youtube channel: ________ For more information feel free to contact me @________!', 162, 196, 182);
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
