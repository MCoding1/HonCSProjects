function setup()
{
  createCanvas(800, 800);
  x = 0;
  y = 0;
  a=200;
  b=200;
  x2=width;
  y2=height;


}

function draw()
{
  const balls = ["balls"]
background(0);
x+=2;
y+=2;
a+=5;
x2-=2;
y2-=2;
  ellipse(x, y, a, b);
    fill(200,20,0);
  ellipse(x2, y2, a, b);
    fill(0,20,200);
    if(x>width/2 && y>height/2){
      x=width;
      a=200;

    }

}
