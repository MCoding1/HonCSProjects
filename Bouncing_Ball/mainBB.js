var balls = [];

function setup()
{
  createCanvas(400, 400);
  for (var i = 0; i < 10; i++) {
  balls[i] = new Ball(Math.random() * 401, Math.random() * 401);
}
  //x = (Math.floor(Math.random() * 801));
  //y = (Math.floor(Math.random() * 801));

  //vx = Math.floor(Math.random() * 10);
  //vy = Math.floor(Math.random() * 10);

}

function draw()
{
    //background(Math.floor(Math.random() * 256),Math.floor(Math.random() * 256),Math.floor(Math.random() * 256));
    background(0);
    for (var i = 0; i < balls.length; i++) {
    balls[i].update();
    balls[i].display();
    balls[i].bounce();
  }
}

function mousePressed() {
  balls.push( new Ball(mouseX, mouseY) );
}

function Ball(x, y) {
	this.x = x;
	this.y = y;
	this.vx = Math.floor(Math.random() * 10);
	this.vy = Math.floor(Math.random() * 10);
	this.sz = 50;

  this.update = function() {
  		this.x += this.vx;
  		this.y += this.vy;
  };

  this.display = function() {
  		fill(Math.floor(Math.random() * 256),Math.floor(Math.random() * 256),Math.floor(Math.random() * 256));
  		stroke(0);
      ellipse(this.x, this.y, this.sz, this.sz);
  	};

  //fill(Math.floor(Math.random() * 256),Math.floor(Math.random() * 256),Math.floor(Math.random() * 256));
  //ellipse(x, y, 50, 50);

  this.bounce = function() {
  	if (this.x > width || this.x < 0) {
  		this.vx *= -1;
  	}
  	if (this.y > height || this.y < 0) {
  		this.vy *= -1;
  	}
  }

}
    /*
    if(x>width || x<0){
      vx = vx*-1;
    }else if(y>height || y<0){
      vy = vy*-1;
    } */
    //x = x + vx;
  //  y = y + vy;
