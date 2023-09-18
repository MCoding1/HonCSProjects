

// obj-Files related 
// siehe auch OutputFig2
// http://code.google.com/p/saitoobjloader/
// http://thequietvoid.com/client/objloader/reference/index.html

void initObjLoader () 
{

  imgDark = loadImage ( "burloak.jpg" );

  model[0] = new OBJModel ( this, "pawn.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[1] = new OBJModel ( this, "king.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[2] = new OBJModel ( this, "queen.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[3] = new OBJModel ( this, "bishop.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[4] = new OBJModel ( this, "rook.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[5] = new OBJModel ( this, "knight.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);

  // je größer Zahl, desto tiefer
  Y_Correction[0]= 18;
  Y_Correction[1]= 4;
  Y_Correction[2]= 5;
  Y_Correction[3]= 7;
  Y_Correction[4]= 9; // rook = Turm 
  Y_Correction[5]= 16; // Pferd

  for (int i = 0; i < maxOBJModel; i = i+1) {

    model[i].disableTexture();
    model[i].disableMaterial();

    // turning on the debug output (it's all the stuff that spews out in the black box down the bottom)
    //model[i].enableDebug();

    // Helper function to move the origin point of the model to the center of the objects BoundingBox 
    model[i].translateToCenter();
    model[i].setTexture ( imgDark ) ; // "burloak.jpg"); 
    // model.Material.setTexture (  imgDark ) ; // "burloak.jpg"); 
    // model[i].setTexture (  imgDark ) ; // "burloak.jpg");
    //model[i].scale(8);
    model[i].scale (.45);
  }
  model[2].scale (3.4);
}

