import java.io.FileInputStream;
import java.io.DataInputStream;

    PShape s;  
    float rotX, rotY, camX, camY, camZ;
    boolean shape=false;
    
    java.io.File folder;
    int showfiles=0;
    File[] files;

    void setup() 
    { 
      size(1024, 768, P3D); 
      background(0); 
      stroke(255);
      fill(130); 
      camX=width/2;
      camY=height/2;
      rotX=0;
      rotY=0;
    }

    void draw() 
    { 
     background(0);
     textSize(32);
     if (showfiles>0) {     
      for (int i = 0; i < files.length; i++) {
        if (files[i].isDirectory()) fill(255,0,0); else fill(150);
        text(files[i].getName(),20,32+i*32);
       }
      }
     fill(130);   
     translate(camX, camY, camZ);
     rotateY(rotY);
     rotateX(rotX);
     if (shape) shape(s, 0, 0);
      else text("Click for menu",0,0);
    }
    
void loadSTL(String filename)
{
   float X,Y,Z;
   int vertices=0;
   int p; String sub;
      s=createShape(); 
      s.beginShape(TRIANGLES); 
      String[] lines = loadStrings(filename); //LOAD ASCII STL ONLY!!!
      for (int i = 0 ; i < lines.length; i++) 
      { 
        p=lines[i].indexOf("vertex"); 
        if (p>-1) 
        { 
         sub=lines[i].substring(p+7); 
         String[] list = split(sub, ' ');
         X=float(list[0]); Y=float(list[1]); Z=float(list[2]);
         s.vertex(X, Y, Z);
         vertices++;
        } 
      } 
      s.endShape();
   if (vertices==0) //no vertices? it could be binary STL
    {
      println(filename,"is a binary file");
      try{
      FileInputStream fis = new FileInputStream(sketchPath(filename));
      DataInputStream input = new DataInputStream(fis);
      byte[] header = new byte[80];
      byte[] b4=new byte[4];
      byte[] attribute=new byte[2];
      byte[] normal = new byte[12];
      input.read(header);  //read header and throw away
      input.read(b4); vertices=unhex((hex(b4[3])+hex(b4[2])+hex(b4[1])+hex(b4[0]))); //again this endianity
      println("vertices: ",vertices);
      s=createShape(); 
      s.beginShape(TRIANGLES); 
      for (int i = 0 ; i < vertices; i++){
       input.read(normal); //ignore surface normals
       for (int j=0;j<3;j++){
        input.read(b4); X=annoyingEndian(b4);
        input.read(b4); Y=annoyingEndian(b4);
        input.read(b4); Z=annoyingEndian(b4);
        s.vertex(X, Y, Z);}
        input.read(attribute); //ignore attribute
      }
        s.endShape();      
        input.close();
      }
          catch (IOException e)
    {
      System.out.println("IOException : " + e);
    }
    }
   shape=true;   
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  camZ+=e*5;
}

void mouseDragged()
{
  if (mouseButton == LEFT)
  {
    rotY+=(pmouseX-mouseX)*0.01;
    rotX+=(pmouseY-mouseY)*0.01;
  }
  if (mouseButton==RIGHT)
  {
    camX-=(pmouseX-mouseX);
    camY-=(pmouseY-mouseY);
  }
  if (mouseButton==CENTER)
  {
    camZ+=(pmouseY-mouseY);
  }
}

void mouseClicked()
{
 if (showfiles==0) {  
 files = listFiles(sketchPath(""));
 showfiles=1;
 }
 else
 {showfiles=0;
  if (mouseX<500)
   {
    int Choice=mouseY/32;
    if (Choice<files.length)
    {
     showfiles=1;
     String filename;
     filename=files[Choice].getName();
     println(filename);
     if (filename.toLowerCase().indexOf(".stl")>-1) loadSTL(filename);
    }
   }
 }
}

Float annoyingEndian(byte[] b)
{
  return Float.intBitsToFloat(unhex((hex(b[3])+hex(b[2])+hex(b[1])+hex(b[0]))));
}
