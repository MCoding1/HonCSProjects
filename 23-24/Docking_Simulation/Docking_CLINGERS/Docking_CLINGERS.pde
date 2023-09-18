PShape s; int p; String sub; Float X,Y,Z;
    float rotX, rotY, camX, camY, camZ;
 
    void setup() 
    { 
      size(640, 360, P3D); 
      background(0); 
      stroke(255);
      fill(130); 
      s=createShape(); 
      s.beginShape(TRIANGLES); 
      String[] lines = loadStrings("test.stl"); //LOAD ASCII STL ONLY!!!
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
      camX=width/2;
      camY=height/2;
      rotX=0;
      rotY=0;
    }
 
    void draw() 
    { 
     background(0);
     translate(camX, camY, camZ);
     rotateY(rotY);
     rotateX(rotX);
     shape(s, 0, 0);
    }
 
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camZ+=e*5;
}
 
void mouseDragged()
{
  if (mouseButton == LEFT)
  {
    rotY += (pmouseX - mouseX)*0.01;
    rotX += (pmouseY - mouseY)*0.01;
  }
  if (mouseButton == RIGHT)
  {
    camX -= (pmouseX - mouseX);
    camY -= (pmouseY - mouseY);
  }
  if (mouseButton == CENTER)
  {
    camZ += (pmouseY - mouseY);
  }
}
