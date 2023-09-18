PShape s; int p; String sub; Float X,Y,Z;
float rotX, rotY, camX, camY, camZ;
//PShape fred;

//red green blue for + xyz
  
  float r = random(0,50);
  float g = 0;
  float b = random(-20,0);

  float r1 = random(0,50);
  float g1 = 0;
  float b1 = random(-20,0);  
  
   float x = random(0,255);
  float y = random(0,255);
  float z = random(0,255);

      float x1 = random(0,255);
  float y1 = random(0,255);
  float z1 = random(0,255);
void setup(){
  size(600,400,P3D);
  
  /*
    //fred
  //fred = loadShape("chicken.stl");
  s=createShape(); 
  s.beginShape(TRIANGLES); 
  String[] lines = loadStrings("chicken.stl"); //LOAD ASCII STL ONLY!!!
  
  for (int i = 0 ; i < lines.length; i++) 
      { 
        p=lines[i].indexOf("vertex"); 
        if (p>-1) 
        { 
         sub=lines[i].substring(p+7); 
         String[] list = split(sub, ' ');
         X=float(list[0]); Y=float(list[1]); Z=float(list[2]);
         s.vertex(X, Y, Z);
        } 
      } 
      s.endShape(); 
      
  // Scale the shape
  float scaleFactor = 0.1; // Adjust the scale factor as needed
  scale(scaleFactor);

  // Translate the shape
  float xOffset = 0; // Adjust the X offset as needed
  float yOffset = 0; // Adjust the Y offset as needed
  float zOffset = 0; // Adjust the Z offset as needed
  translate(xOffset, yOffset, zOffset);

  // Add lights
  directionalLight(255, 255, 255, 0, 0, 1); // Adjust the direction as needed

*/
}

void drawAxes(float size){
  //X  - red
  stroke(192,0,0);
  line(0,0,0,size,0,0);
  //Y - green
  stroke(0,192,0);
  line(0,0,0,0,size,0);
  //Z - blue
  stroke(0,0,192);
  line(0,0,0,0,0,size);
}


//if you cross the road and cross back have you really crossed?
void draw(){
  background(0);
  translate(width/2,height/2,0);
  lights();
  rotateY(map(mouseX,0,width,-PI,PI));
  rotateX(map(mouseY,0,height,-PI,PI));
  fill(255);
  noStroke();
  
  //grass
  fill(22, 79, 25);
  box(500, 500, 5);
 
  //stump
  translate(0, 0, 30); 
  fill(70, 55, 30);
  box(5, 5, -60);  
  //tree leaves
  translate(0, 0, 20); 
  fill(255, 134, 50);
  box(-30, 30, 40);    
  
  //stump2
  translate(40, 0, -20); 
  fill(70, 55, 30);
  box(-5, 5, 60);  
  //tree leaves2
  translate(8, 8, 20); 
  fill(#F72D5C);
  box(-30, 30, 40);  

    //stump3
  translate(40, 0, -15); 
  fill(70, 55, 30);
  box(-5, 5, 60);  
  //tree leaves3
  translate(8, 8, 20); 
  fill(#FFDD33);
  box(-30, 30, 40); 
  
    //sheep body
  translate(50, 50, -40); 
  fill(255);
  box(20, 20, 20);  
  //sheep head
  translate(-10, 0, 10); 
  fill(255);
  box(10, 10, 10);  
 
 
   //sheep body
  translate(50, 50, -10); 
  fill(255);
  box(20, 20, 20);  
  //sheep head
  translate(-10, 0, 10); 
  fill(255);
  box(10, 10, 10); 
  
  
  
  
  
    //stump4
  translate(r,g,b); 
  fill(70, 55, 30);
  box(5, 5, -60);  
  //tree leaves
  translate(r-37, g+10, b+37); 
  fill(x,y, z);
  box(-30, 30, 40);    
 
      //stump4
  translate(r1,g1,b1); 
  fill(70, 55, 30);
  box(5, 5, -60);  
  //tree leaves
  translate(r1-37, g1+10, b1+37); 
  fill(x1,y1, z1);
  box(-30, 30, 40);  

  

  
  //sphere(10);
  
 //shape(s);
 
   drawAxes(100000); 
}
