PShape s, s1; int p; String sub; Float X,Y,Z;
float rotX, rotY, camX, camY, camZ;

//peasycam try

void setup(){
  size(1000,1000,P3D);
  s = loadShape("girl.obj");
  s1 = loadShape("grass.obj");
  //s2 = loadShape("tree.obj");
  //s3 = loadShape("flower.obj");  
}

void drawAxes(float size){
  //X  - red
  stroke(#F72419);
  line(0,0,0,size,0,0);
  //Y - green
 stroke(#0EE336);  
  line(0,0,0,0,size,0);
  //Z - blue
stroke(#0E21E3); 
  line(0,0,0,0,0,size);
}


//if you cross the road and cross back have you really crossed?
void draw(){
  background(0);
  translate(width/2,height/2,0);
  lights();

  // Set the camera position and orientation for an isometric view
  float cameraAngleX = radians(30); // Rotate around the X-axis
  float cameraAngleY = radians(-30); // Rotate around the Y-axis
  float cameraDistance = 400; // Adjust this distance as needed

  float cameraX = cos(cameraAngleY) * cameraDistance;
  float cameraY = sin(cameraAngleX) * cameraDistance;
  float cameraZ = sin(cameraAngleY) * cameraDistance;

  camera(cameraX, cameraY, cameraZ, 0, 0, 0, 0, 1, 0);


rotateY(map(mouseX,0,width,-PI,PI));
 rotateX(map(mouseY,0,height,-PI,PI));
 // rotateX(0);
  //rotateY(0);
  
  fill(255);
  noStroke();
  
 //do a translate so orogion setup so things start at corner and go out, not center at orign
  
  //grass

 fill(#2E8939);
 box(400,400,20);
    translate(-200,-200,0); 
    
    
    
 pushMatrix();
 float angleX = radians(90);  // Rotate 90 degrees around the X-axis to make it perpendicular
float angleY = 0;            // No rotation around the Y-axis
float angleZ = 0;            // No rotation around the Z-axis

rotateX(angleX);
rotateY(angleY);
rotateZ(angleZ);

    //shape(s, 100, 100, 50, 50);  
    //shape,x,y,width,height
    
    //do translation
    
   translate(0,0,-200); 
    
    
shape(s, 200, 10, 100, 100); // Reduced Z-coordinate to 50
//all object files here?

    translate(200,10,0); 
shape(s1, 0, 20, 300, 20);
popMatrix();

  drawAxes(100000);
      
pushMatrix();
float textSize = 40; // Adjust the text size as needed
textSize(textSize); // Set the text size
text("Welcome to the random forest!", 0, -20, 0);
popMatrix();

}
