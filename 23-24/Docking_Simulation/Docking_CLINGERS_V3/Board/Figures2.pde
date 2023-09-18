


// output Figures: Full 3D

// OutputFigures3DOBJ 
// andere OBJ-Funktionen: Siehe objLoader 

void ShowFiguresFull3D () {

  // void ShowFigures () {

  int col1 = #d18b47; 
  int col2 = #ffce9e;   

  stroke(col1);

  for (int i = 0; i < 8; i = i+1) {
    for (int j = 0; j < 8; j = j+1) {

      switch (Board[i][j].charAt(0)) {
      case 'P':
        ShowPieceOBJ ( 0,i,j, colWhite )  ; 
        break; 
      case 'p':
        ShowPieceOBJ ( 0,i,j, colBlack )  ; 
        break;         
      case 'Q':
        ShowPieceOBJ ( 2,i,j, colWhite )  ; 
        break; 
      case 'q':
        ShowPieceOBJ ( 2,i,j, colBlack )  ; 
        break;
      case 'K':
        ShowPieceOBJ ( 1,i,j, colWhite )  ; 
        break; 
      case 'k':
        ShowPieceOBJ ( 1,i,j, colBlack )  ; 
        break;        
      case 'R':
        ShowPieceOBJ ( 4,i,j, colWhite )  ; 
        break; 
      case 'r':
        ShowPieceOBJ ( 4,i,j, colBlack )  ; 
        break;
      case 'B':
        ShowPieceOBJ ( 3,i,j, colWhite )  ; 
        break; 
      case 'b':
        ShowPieceOBJ ( 3,i,j, colBlack )  ; 
        break;        
      case 'N':
        ShowPieceOBJ ( 5,i,j, colWhite )  ; 
        break; 
      case 'n':
        ShowPieceOBJ ( 5,i,j, colBlack )  ; 
        break;                
      case ' ':
        break;   
      default:
        println("ERROR 234");
        break;
      } // switch
    } // for
  } // for
} // function   

void ShowPieceOBJ (int pieceIndex, int i, int j, int colColor) 
{
  //this will do nothing until the model material is turned off
  fill(32,11,10);

  //for (int i = 0; i < maxOBJModel; i = i+1) {

  pushMatrix();
  //pushMatrix();
  PVector MyPVector = new PVector( 0.0, 0.0, 0.0 );
  MyPVector =  GetValuePVector (i,j);
  //  translate ( MyPVector.x+107, MyPVector.y -27, MyPVector.z -23);  
  translate ( 
  MyPVector.x+0, 
  MyPVector.y - 27 + Y_Correction[pieceIndex], 
  MyPVector.z );    
  rotateX(radians(90));

  //popMatrix();
  //   translate(133+i*193, 92, -430);//  rotateY(rotX);

  //    rotateX(rotY);
  //  rotateY(rotX);


  if (colColor!=colBlack) {
    // model[pieceIndex].enableTexture();
    // model[pieceIndex].enableMaterial();
    // model[pieceIndex].disableTexture();
    // model[pieceIndex].disableMaterial();
    // model[0].setTexture (  imgDark ) ; // "burloak.jpg");       
    // translate (0,166,0);
    rotateZ(radians(180));
  } 
  else {
    // model[pieceIndex].disableTexture();
    // model[pieceIndex].disableMaterial();
  }


  //   if (colColor!=colBlack) {
  fill (colColor);

  noStroke();

  if (camIsMouseControlled) { 
    stroke(10,10,10);
    model[pieceIndex].shapeMode(POINTS);
  } 
  else 
  { 
    noStroke(); 
    model[pieceIndex].shapeMode(POLYGON);
  } 
  model[pieceIndex].draw();


  popMatrix();
  // image (imgDark,300,200);
  // noLoop();
  // }

  //model[0].setTexture (  imgDark ) ; // "burloak.jpg");
}

