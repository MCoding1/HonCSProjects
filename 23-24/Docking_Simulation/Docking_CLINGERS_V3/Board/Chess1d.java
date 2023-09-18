import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import peasy.*; 
import saito.objloader.*; 
import shapes3d.utils.*; 
import shapes3d.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Chess1d extends PApplet {



// MAIN ===================================================

//chess. 
//
//Makes use of shapes3D by Quark with picking. 
//Toggle view by cursor down and up.

//You can only pick the Board's Fields and not 
//the figures. 

// Use peasy-cam while pressing SHIFT.

// The general design is from the famous Baushaus-chess. 
// Change design by Cursor up and down. 

// There are no checks performed if the move is valid etc. 

//Be careful: the Board runs from [0 to 7] [0 to 7].
//The internal command to make a move is:  MakeAMove ("E2E4").
//So we use E2E4 (not e2e4) which comes to 5,2 moves to 5,4, 
//but those number refer to a frame 1 to 8 so we have substract 1
//to get a frame 0 to 7 as required by Board. 

// imports ================================================

/** opengl **/


/** PeasyCam **/


// to display the 3D-non-Bauhaus-pieces 


/**
 * library for the shape picking feature. 
 * This uses the off-screen buffer version of the pick
 * shape algorithm.
 * created by Peter Lager 2010
 */



// ====================================================================================

// control behaviour parameters 
// boolean boolGl_Control = false;  // Marble with opengl?
// boolean boolGl_Control_for_Boxes = false; // Boxes with opengl?
boolean CameraMoving = false;    // camera always ahead of Marble
boolean CameraMoving2 = false;    // good for movie (camera on a circle track)
boolean boolMakeMovie = false;   // saves a Movie

// ====================================================================================

// values for position of fields (for Board and pieces) on the screen 
int calculationForScreenPositionX = -120;
int calculationForScreenPositionY = 0; 
int calculationForScreenPositionZ = -130; 

// ====================================================================================

// Board 
String [][] Board ;  

// color for Board (from Wikipedia)
int col1 = 0xffd18b47; 
int col2 = 0xffffce9e;   

// color for figures
int colWhite = 253;
int colBlack = 72; 

// Camera
PeasyCam cam;
//CameraState MyState; 
//CameraState MyStateMove; 
CameraState camMyStateAtBeginning; 
CameraState camMyStateFor2D; 
// Flag to show whether cam is Mouse controlled
boolean camIsMouseControlled = false; 

float WinkelCam=110;
float WinkelCamSpeed=0.21f;

// boxes 
Box[] box = new Box[66];
int iBox=0;

// get Input: status 
final int constStatusGetFromField = 0 ; 
final int constStatusGetToField = 1 ; 
int status1 = constStatusGetFromField ; 

// get Input: from and to 
int FromField = 0; 
int ToField = 0; 

// Game logic 
final int PlayerHuman = 0; 
final int PlayerPC = 1; 
int statusPlayer = PlayerHuman; 

// Player colors 
final int PlayerBlack = 0; 
final int PlayerWhite = 1; 
int PC_playsColor = PlayerBlack; 

// 0 = PC against PC, 1 = PC against human, 
// 2 human against human
int NumberOfPlayers = 1; 

// move as animation
boolean moveRunning=false; 
int moveRunningX_From=-1; 
int moveRunningY_From=-1; 
int moveRunningX_To=-1;
int moveRunningY_To=-1;    

float moveRunningX_ScreenFrom = 0.0f;
float moveRunningY_ScreenFrom = 0.0f;
float moveRunningX_ScreenTo = 0.0f;
float moveRunningY_ScreenTo = 0.0f;
float moveRunningX_ScreenAdd =11.0f; // moveRunningX_ScreenAdd 
float moveRunningY_ScreenAdd =11.0f; 
boolean moveRunningXGT_Flag = false; // x greater or smaller 
boolean moveRunningYGT_Flag = false; // y greater or smaller 
int moveRunningDivide = 10; // Speed (10=fast, 50=slow)

// showFiguresAsImages or Bauhaus or 3D full
final int showFiguresAsBauhaus = 0; 
final int showFiguresAsFull3D = 1; 
final int showFiguresAsImages = 2; 
int showFiguresAsWhat = showFiguresAsBauhaus; 

// new game wish 
boolean newGame = false; 

// declare that we need a OBJModel and we'll be calling it "model"
// OBJModel model;
final int maxOBJModel = 6; 
OBJModel[] model = new OBJModel[maxOBJModel];
float rotX;
float rotY;
int [] Y_Correction = new int [maxOBJModel];

// these booleans will be used to turn on and off bits of the OBJModel
boolean bTexture = true;
boolean bStroke = false;
boolean bMaterial = true;

PImage imgDark; 

// ====================================================================================

public void setup () { 
  SetupNormal3d() ;
}  

public void SetupNormal3d() {
  // P3D or OPENGL 
  // size( screen.width, screen.height, OPENGL );  
  //  size( 580, 480, P3D );   // BEST 
  //size( screen.width, screen.height, P3D );   
  size(850, 850, P3D);   
  // frame.setResizable(true);
  cam = new PeasyCam(this, 400);
  // cam.setMinimumDistance(250);
  //cam.setMaximumDistance(600); 
  cam.setResetOnDoubleClick (true); 
  cam.setMouseControlled (false);
  camIsMouseControlled=false; 
  cam.pan(0, 100);
  camMyStateAtBeginning=cam.getState();

  Board = SetField();
  InitBoxes ();
  initObjLoader ();
}

public void SetupOnly2D_______ALT () {  
  // only 2D
  // size( screen.width, screen.height );  
  println("going to 2D");
  // size( 580, 480, JAVA2D );    
  frame.setSize(580, 480);   //  , JAVA2D 
  println("gone to 2D");  
  //cam = new PeasyCam(this, 400);
  // cam.setMinimumDistance(250);
  //cam.setMaximumDistance(600); 
  //cam.setResetOnDoubleClick (true); 
  cam.setMouseControlled (false);
  camIsMouseControlled=false; 
  //Board = SetField();
  InitBoxes (); // board 
  showFiguresAsWhat=showFiguresAsImages;
}

// ---------------------------------------------------------------

public void draw () {
  background (100);
  if (CameraMoving2) {
    SetCamera();
  }

  if (newGame) {
    background (100);    
    status1 = constStatusGetFromField ;     
    moveRunning=false;
    InitBoxes (); 
    Board = SetField();
    CheckeredBoard () ; 
    if ( showFiguresAsWhat == showFiguresAsBauhaus ) {
      ShowFigures ();
    } 
    else if ( showFiguresAsWhat == showFiguresAsFull3D ) {
      ShowFiguresFull3D ();
    }
    newGame=false;
    if ( NumberOfPlayers == 0 ) {
      PC_playsColor = PlayerWhite;
    } // if
  } // new game   
  lights();
  directionalLight(254, 254, 254, 1, 1, 1);
  // directionalLight(254,254,254, -1, 1, 1);  
  // ambientLight(0,0,0, 1, 1, 1); // (0,0,0);

  CheckeredBoard () ; 

  if ( showFiguresAsWhat == showFiguresAsBauhaus ) {
    ShowFigures ();
  } 
  else if ( showFiguresAsWhat == showFiguresAsFull3D ) {
    ShowFiguresFull3D ();
  }  

  if (moveRunning) {
    moveRunningControl(); 
    delay(1);
  } 
  else if (statusPlayer == PlayerPC) {
    PC_Move ();
  }
  if (boolMakeMovie) {
    // Saves each frame as screen-0000.bmp, screen-0001.bmp, etc.
    saveFrame("chess####.bmp");
  }
} //draw 




// Define the initial start board.


// p is for pawn etc.;  
// big letters are black, 
// small letters are white 
// figures. 
// For Painting the Board see file /tab "OutputBoard". 


public String [][]SetField () {

  String[][] Buffer = new String[8][8]; 

  // pre-init
  for (int i = 0; i < 8; i = i+1) {
    for (int j = 0; j < 8; j = j+1) {
      Buffer [i][j]  = " ";
    }
  }

  // pawns
  for (int i = 0; i < 8; i = i+1) {
    Buffer [i][6]  = "p"; 
  }  
  for (int i = 0; i < 8; i = i+1) {
    Buffer [i][1]  = "P";
  }    

  // others
  Buffer [3][0] = "Q"; //   queen 
  Buffer [3][7] = "q"; //   queen 
  Buffer [4][0] = "K"; //   king
  Buffer [4][7] = "k"; //   king

  Buffer [0][0] = "R"; //   rook
  Buffer [7][7] = "r"; //   rook

  Buffer [7][0] = "R"; //   rook
  Buffer [0][7] = "r"; //   rook

  Buffer [2][0] = "B"; //   bishop 
  Buffer [5][7] = "b"; //   bishop 

  Buffer [5][0] = "B"; //   bishop 
  Buffer [2][7] = "b"; //   bishop 

  Buffer [1][0] = "N"; //   knight 
  Buffer [6][7] = "n"; //   knight 

  Buffer [6][0] = "N"; //   knight 
  Buffer [1][7] = "n"; //   knight 

  return (Buffer); 

}      






// figures: Bauhaus-figures // 3D 


public void ShowFigures () {

int col1 = 0xffd18b47; 
int col2 = 0xffffce9e;   

  stroke(col1);

  for (int i = 0; i < 8; i = i+1) {
    for (int j = 0; j < 8; j = j+1) {

      switch (Board[i][j].charAt(0)) {
      case 'P':
        pawn ( i,j, colWhite )  ; 
        break; 
      case 'p':
        pawn ( i,j, colBlack )  ; 
        break;         
      case 'Q':
        queen ( i,j, colWhite )  ; 
        break; 
      case 'q':
        queen ( i,j, colBlack )  ; 
        break;
      case 'K':
        king ( i,j, colWhite )  ; 
        break; 
      case 'k':
        king ( i,j, colBlack )  ; 
        break;        
      case 'R':
        rook ( i,j, colWhite )  ; 
        break; 
      case 'r':
        rook ( i,j, colBlack )  ; 
        break;
      case 'B':
        bishop ( i,j, colWhite )  ; 
        break; 
      case 'b':
        bishop ( i,j, colBlack )  ; 
        break;        
      case 'N':
        knight ( i,j, colWhite )  ; 
        break; 
      case 'n':
        knight ( i,j, colBlack )  ; 
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

public void queen (int i,int j,int col3) {
  int col1 = 103; 
  int col2 = 11;   
  fill(col3);
  stroke(OtherFigureColor(col3));  
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x, MyPVector.y, MyPVector.z );
  box (20);
  translate ( 0,-17,0 );
  // sphereDetail(11, 11);
  noStroke(); 
  fill(OtherFigureColorQueen(col3));    
  sphere(8); 
  popMatrix();
}

public void king (int i,int j,int col3) {
  int col1 = 103; 
  int col2 = 11;   
  fill(col3);
  stroke(OtherFigureColor(col3));  
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x, MyPVector.y, MyPVector.z );
  box (20);
  translate ( 0,-15,0 );
  rotateY(radians(45));
  box (10);
  popMatrix();
}

public void pawn (int i,int j,int col3) {
  int col1 = 103; 
  int col2 = 11;   
  fill(col3);
  stroke(OtherFigureColor(col3));  
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x, MyPVector.y, MyPVector.z );
  box (17);
  noStroke();
  popMatrix();
}

public void rook (int i,int j,int col3) {
  // tower, marquess, rector, 
  // and comes, and 
  // non-players still 
  // often call it a "castle". 
  // (from Wikipedia)
  int col1 = 103; 
  int col2 = 11;   
  fill(col3);
  stroke(OtherFigureColor(col3));  
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x, MyPVector.y, MyPVector.z );
  box (25);
  popMatrix();
}

public void bishop (int i,int j,int col3) {
  
  // diagonal moving 
  
  int col1 = 103; 
  int col2 = 11;   
  
  
  fill(col3);
  stroke(OtherFigureColor(col3));  
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x, MyPVector.y, MyPVector.z );
  rotateY(radians(45));
  box (5,25,25);
  rotateY(radians(90));
  box (5,25,25);  
  noStroke();
  popMatrix();
}

public void knight (int i,int j,int col3) {
  // jumps 2 and then 1
  int col1 = 103; 
  int col2 = 11;   
  fill(col3);
  stroke(OtherFigureColor(col3));
  pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVector =  GetValuePVector (i,j);
  translate ( MyPVector.x-5, MyPVector.y+5, MyPVector.z-4 );
  ShowL (col3); 
  rotateY(radians(180));
  translate ( -10,-10,-10 );
  ShowL (col3); 
  popMatrix();
}

// ----------------------------------------------------------

public void ShowL (int col3) {
  // help-sub for the knight
  int col1 = 103; 
  int col2 = 11;   
  int Size1 = 10; 
  fill(col3);
  stroke(OtherFigureColor(col3));
  pushMatrix();
  box (Size1);
  translate ( Size1,0,0 );
  box (Size1);  
  translate ( 0,0,Size1 );
  box (Size1);  
  noStroke();
  popMatrix();
}

public int OtherFigureColor (int col3) {
  // This gives you a similar color 
  // for the figure's color. 
  // E.g. you have a white figure 
  // you here get another white-ish color
  // for the stroke lines of the figure.
  // For a black figure you get another 
  // shade of black or dark gray.

  int Buffer=0;

  if (col3==colWhite) 
  {
    Buffer=colWhite-60;
  } 
  else 
  {
    Buffer=50;
  };

  return(Buffer);

}

public int OtherFigureColorQueen (int col3) {
  // QUEEN -----------------
  // This gives you a similar color 
  // for the figure's color. 
  // E.g. you have a white figure 
  // you here get another white-ish color
  // for the stroke lines of the figure.
  // For a black figure you get another 
  // shade of black or dark gray.

  int Buffer=0;

  if (col3==colWhite) 
  {
    Buffer=colWhite-17; 
  } 
  else 
  {
    Buffer=70; 
  };

  return(Buffer);

}

// ------------------------------------------------------------------------

public PVector GetValuePVector ( int x1, int y1 ) {
  // here the calculation for the positions of 
  // figures is made. 
  if ((x1==moveRunningX_From) && (y1==moveRunningY_From)) {
    PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
    MyPVector.set ( moveRunningX_ScreenFrom,160,moveRunningY_ScreenFrom);
    return(MyPVector);
  } 
  else {
    PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
    MyPVector.set (  40*x1 + calculationForScreenPositionX,
    160 + calculationForScreenPositionY,
    40*(7-y1)  + calculationForScreenPositionZ );
    return(MyPVector);
  }
}




// output Figures: Full 3D

// OutputFigures3DOBJ 
// andere OBJ-Funktionen: Siehe objLoader 

public void ShowFiguresFull3D () {

  // void ShowFigures () {

  int col1 = 0xffd18b47; 
  int col2 = 0xffffce9e;   

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

public void ShowPieceOBJ (int pieceIndex, int i, int j, int colColor) 
{
  //this will do nothing until the model material is turned off
  fill(32,11,10);

  //for (int i = 0; i < maxOBJModel; i = i+1) {

  pushMatrix();
  //pushMatrix();
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
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



// get the inputs 

// ==========================================================

public void mouseReleased () {
  // mouse evaluate. 
  // Check what's been 
  // pressed by the mouse.

  boolean done = false; 

  // Wenn linke Taste UND camera not mouse controlled
  if ((mouseButton == LEFT) && 
    (camIsMouseControlled==false)) {  
    // by Quark
    Shape3D picked = Shape3D.pickShapeB(this,mouseX, mouseY);
    if (picked != null) {
      done=true; 
      MakeHumanMove(picked.tagNo);
    }
  }
} // mouseClicked

public void keyPressed() {
  // evaluate key
  if (key == CODED) {
    // coded
    switch (keyCode) {
    case UP: 
      showFiguresAsWhat++; 
      if (showFiguresAsWhat>2) {
        showFiguresAsWhat=showFiguresAsBauhaus;
        moveRunningX_ScreenAdd =11.0f; 
        moveRunningY_ScreenAdd =11.0f;
      }
      if (showFiguresAsWhat==showFiguresAsBauhaus) {
        moveRunningX_ScreenAdd =11.0f; 
        moveRunningY_ScreenAdd =11.0f;
        moveRunningDivide = 50;
      } 
      else if 
        (showFiguresAsWhat==showFiguresAsFull3D) {
        moveRunningX_ScreenAdd =21.0f; 
        moveRunningY_ScreenAdd =21.0f;
        moveRunningDivide = 10;
      }
      InitBoxes () ;      
      break; 
    case DOWN: 
      showFiguresAsWhat--; 
      if (showFiguresAsWhat<0) {
        showFiguresAsWhat=showFiguresAsImages;
      }      
      if (showFiguresAsWhat==showFiguresAsBauhaus) {
        moveRunningX_ScreenAdd =11.0f; 
        moveRunningY_ScreenAdd =11.0f;
        moveRunningDivide = 50;
      } 
      else if 
        (showFiguresAsWhat==showFiguresAsFull3D) {
        moveRunningX_ScreenAdd =11.0f; 
        moveRunningY_ScreenAdd =11.0f;
        moveRunningDivide = 10;
      }
      InitBoxes () ;      
      break; 
    case KeyEvent.VK_SHIFT:
      cam.setMouseControlled(true);
      camIsMouseControlled=true; 
      break;      
    default: 
      // nothing
      break;
    } // switch
  } // if

  else {

    // not coded 
    switch (key) {
    case '0': 
      NumberOfPlayers = 0; 
      statusPlayer=PlayerPC; 
      newGame=true; 
      break; 
    case '1':     
      NumberOfPlayers = 1;     
      break; 
    case '2':     
      NumberOfPlayers = 2; 
      break; 
    case '6':   
      println(camMyStateFor2D);       
      //camMyStateFor2D.Center.x=122; 
      //camMyStateFor2D.y=322;       
      //    camMyStateFor2D.z=422; 
      // cam.setState(CameraState(122,333,444, 122,333,-444 ));
      break;
    case '7':       
      println(camMyStateAtBeginning);
      float [] a1 = cam.getPosition()     ; 
      println(a1[0] + " " + a1[1] +  " "  + a1[2]  );

      a1 = cam.getLookAt()     ;       
      println(a1[0] + " " + a1[1] +  " "  + a1[2]  );      
      cam.lookAt(0,0,-75);
      break;       
    case '9':       
      cam.setState(camMyStateAtBeginning);
      break; 
    case 'n':
      newGame=true; 
      break;  
    case 'd':
      // good for 2D-pieces: place camera above board
      cam.setMouseControlled(false);
      camIsMouseControlled=false; 
      PVector MyPVectorCenter = new PVector( 0.0f, 0.0f, 0.0f );
      MyPVectorCenter=GetValuePVectorBoard ( 3, 3 );    
      MyPVectorCenter.z = 6; 
      camera (
      (MyPVectorCenter.x -0 ), 
      (MyPVectorCenter.y - 320), 
      (MyPVectorCenter.z-55 ),
      MyPVectorCenter.x, MyPVectorCenter.y, MyPVectorCenter.z-9,
      0, -1, 0); 
      break;    
    default: 
      // nothing
      break;
    } // switch
  } // else (not coded)
} // keyPressed


public void keyReleased() {
  // evaluate key release
  if (key == CODED) {
    // coded
    switch (keyCode) {
    case KeyEvent.VK_SHIFT:
      cam.setMouseControlled(false);
      camIsMouseControlled=false; 
      println(camIsMouseControlled);
      break;      
    default: 
      // nothing
      break;
    } // switch
  } // if

  else {

    // not coded 
    switch (key) {

    default: 
      // nothing
      break;
    } // switch
  } // else (not coded)
} // 



// make a move - it's used by human player and 
// by PC's Move.


public boolean MakeAMove (String Move1) {

  int x1; // from 
  int y1;  

  int x2; // to 
  int y2;  

  boolean valid = true; 
  boolean done = false; 

  x1= PApplet.parseInt(Move1.charAt(0))-65;   
  y1= integerFromChar(Move1.charAt(1))-1; 

  x2= PApplet.parseInt(Move1.charAt(2))-65; 
  y2= integerFromChar(Move1.charAt(3))-1;     

  print(x1 + " " + y1 + " to ");  
  println(x2 + " " + y2 + ".");    

  // one must be different 
  if ((x1==x2) && (y1==y2)) { 
    valid = false; 
  }
  // from-field must have a figure 
  if (Board [x1][y1].charAt(0) == ' ' ) { 
    valid = false; 
  }
  // all values must be within 0 and 7
  if (x1<0) { 
    valid = false; 
  }
  if (y1<0) { 
    valid = false; 
  }
  if (x2<0) { 
    valid = false; 
  }
  if (y2<0) { 
    valid = false; 
  }

  if (x1>7) { 
    valid = false; 
  }
  if (y1>7) { 
    valid = false; 
  }
  if (x2>7) { 
    valid = false; 
  }
  if (y2>7) { 
    valid = false; 
  }

  if (valid) {
    if (showFiguresAsWhat==showFiguresAsImages) {
      // if 2D images (and not Bauhaus or 3D figures)
      // execute immediately 
      moveRunning=false;
      Board [x2][y2] = Board [x1][y1]; 
      Board [x1][y1] = " ";
      InitBoxes () ;       
      done=true; 
    } 
    else {
      // init animation of the move 
      moveRunningX_From=-1;
      moveRunningY_From=-1;

      moveRunning=false; 
      PVector MyPVectorFrom = new PVector( 0.0f, 0.0f, 0.0f );
      MyPVectorFrom=GetValuePVector ( x1, y1 );
      PVector MyPVectorTo = new PVector( 0.0f, 0.0f, 0.0f );
      MyPVectorTo=GetValuePVector ( x2, y2 );    

      moveRunningX_From=x1;
      moveRunningY_From=y1;
      moveRunningX_To=x2;
      moveRunningY_To=y2;    

      moveRunning=true; 
      moveRunningX_ScreenFrom = MyPVectorFrom.x; 
      moveRunningY_ScreenFrom = MyPVectorFrom.z; 
      moveRunningX_ScreenTo = MyPVectorTo.x; 
      moveRunningY_ScreenTo = MyPVectorTo.z;     
      moveRunningX_ScreenAdd = (moveRunningX_ScreenTo-moveRunningX_ScreenFrom)/moveRunningDivide ; 
      moveRunningY_ScreenAdd = (moveRunningY_ScreenTo-moveRunningY_ScreenFrom)/moveRunningDivide ;
      if (moveRunningY_ScreenAdd<0) {
        moveRunningYGT_Flag = false; 
      } 
      else  {
        moveRunningYGT_Flag = true; 
      } 

      if (moveRunningX_ScreenAdd<0) {
        moveRunningXGT_Flag = false; 
      } 
      else  {
        moveRunningXGT_Flag = true; 
      } 
      done=true; 
    }
  }

  if (done!=true) {
    println("Illegal."); 
  }
  return(done);
}

public void moveRunningControl () {
  // manage animation of the move. 
  // add
  moveRunningX_ScreenFrom = moveRunningX_ScreenFrom + moveRunningX_ScreenAdd ;
  moveRunningY_ScreenFrom = moveRunningY_ScreenFrom + moveRunningY_ScreenAdd ;
  // check if it's over 
  if (IfMoveRunningIsDone ()) {    
    if (showFiguresAsWhat==showFiguresAsImages) {
      InitBoxes () ; 
    }   
    moveRunning=false;  
    Board [moveRunningX_To][moveRunningY_To] = Board [moveRunningX_From][moveRunningY_From]; 
    Board [moveRunningX_From][moveRunningY_From] = " ";
  }
}

public boolean IfMoveRunningIsDone () {
  // check if it's over 
  int count1 = 0;   
  boolean Buffer = false; 
  if (moveRunningXGT_Flag) { // >=
    if (moveRunningX_ScreenFrom >= moveRunningX_ScreenTo ) {    
      count1++; 
    }
  } 
  else 
  { // <=
    if (moveRunningX_ScreenFrom <= moveRunningX_ScreenTo ) {    
      count1++; 
    }
  }

  if (moveRunningYGT_Flag) { // >=
    if (moveRunningY_ScreenFrom >= moveRunningY_ScreenTo ) {    
      count1++; 
    }
  } 
  else 
  { // <=
    if (moveRunningY_ScreenFrom <= moveRunningY_ScreenTo ) {    
      count1++; 
    }
  }  

  if (count1>=2) { 
    Buffer = true; 
  } 
  else { 
    Buffer = false; 
  }
  return (Buffer); 
}



// human move and tools


public void MakeHumanMove(int pickedTagNo) {
  // get the Input of the human move.
  // pickedTagNo ist the TagNo of the 
  // picked field. 
  if (statusPlayer == PlayerHuman) {
    if (status1 == constStatusGetFromField) {
      if (fieldIsOk(pickedTagNo)) {
        FromField = pickedTagNo; 
        status1 = constStatusGetToField;
      } 
      else {
        // do nothing 
      }
    } 
    else if (status1 == constStatusGetToField)  {
      ToField = pickedTagNo;       
      if (MakeAMove (makeToFieldExpression(FromField) + 
        makeToFieldExpression(ToField))) { 
        status1 = constStatusGetFromField; 
        if ((NumberOfPlayers==1) || (NumberOfPlayers==0) ) {
          statusPlayer = PlayerPC; 
        } // if
      } // if
    } // else if
  }
} // MakeHumanMove

public void setup_TESTING () {
  // test
  println ( makeToFieldExpression(42));
  println ( DivideWithoutModulo (483,100) ); 
  println ( DivideWithoutModulo (83,10) );   
  println ( DivideWithoutModulo (3,1) );   
  exit();
}

public boolean fieldIsOk (int Number1) {
  // delivers true if Field is not empty
  int LeftNumber = DivideWithoutModulo(Number1, 10); 
  int RightNumber = Number1 - (LeftNumber*10); 
  LeftNumber=LeftNumber-1; 
  RightNumber=RightNumber-1;
  if (Board[LeftNumber][RightNumber].equals (" ")) {
    println(LeftNumber + " " + RightNumber + ": EMPTY.");    
    return (false); 
  }
  else {  
    return (true); 
  }
} // function 

public String makeToFieldExpression(int Number1) {
  // delivers A1 from 11.  
  // gets 11..88 as parameter. 
  String Buffer =""; 
  int LeftNumber = DivideWithoutModulo(Number1, 10); 
  int RightNumber =  Number1 - LeftNumber*10;   
  Buffer = str(PApplet.parseChar(LeftNumber+64)) + str(RightNumber); 
  Buffer = trim(Buffer);
  return (Buffer); 
}

public int DivideWithoutModulo ( int dividend1, int divisor1  ) {
  // Division: Give the answer as an integer quotient without the remainder. 
  // This is sometimes called integer division.
  // With (83,10) as parameters the result is 8. 

  int Buffer = -1; 

  int ModuloResult = dividend1 % divisor1 ; 
  dividend1 = dividend1 - ModuloResult; 
  Buffer =  dividend1 / divisor1; 

  return (Buffer);
}      



// random PC Move with no chess rules


public void PC_Move () {

  int RandomResult = PApplet.parseInt( random (0,16) ) ; 
  int Distance = PApplet.parseInt( random (2,6) ) ; 
  int Count=0;
  boolean done = false ; 

  print ("PC move: "); 
  for (int TryAgain = 0; TryAgain < 3; TryAgain = TryAgain+1) {
    for (int i = 0; i < 8; i = i+1) {
      for (int j = 0; j < 8; j = j+1) {
        if (GetFigureColor(Board [i][j]) == PC_playsColor) 
        {
          Count++; 
          if ((Count>=RandomResult) && (!done)) {
            print("suggest " + i + " " + j + ".   "); 
            if (MakeAMove(makeToFieldExpression( (i+1)*10 + (j+1) ) + 
              makeToFieldExpression( (i+1)*10 + (j-Distance) ) )) {
              done = true; 
              break; 
            }
          }
        }
      }
    }
  }

  println ("END PC move."); 

  if ((NumberOfPlayers == 1) || (NumberOfPlayers == 2)) { 
    statusPlayer = PlayerHuman; 
  } 
  else { 
    if (PC_playsColor == PlayerBlack) {
      PC_playsColor = PlayerWhite;
    } 
    else {
      PC_playsColor = PlayerBlack;
    }  
  }

}

public int GetFigureColor ( String FieldOfBoard ) {

  int Buffer = -1; 

  String WhiteFigures = "PQKNRB"; 
  String BlackFigures = "pqknrb";   

  int p_White = WhiteFigures.indexOf(FieldOfBoard);
  int p_Black = BlackFigures.indexOf(FieldOfBoard);

  if (p_White>-1) { 
    return (PlayerWhite); 
  }
  else if (p_Black>-1) { 
    return (PlayerBlack); 
  } 
  else  { 
    // for an empty field 
    return (-1); 
  } 

}






// Board outputs are here. 
// Delivers the simple Board (when figures are 3D) 
// OR 
// the Board with the 2D-Figures painted on the Board (when figures are 2D). 
// ========================================

public void CheckeredBoard() {
  int colLocal=0;
  stroke(col1);
  iBox=0;
  for (int i = 0; i < 8; i = i+1) {
    for (int j = 0; j < 8; j = j+1) {

      // % is modulo, meaning rest of division 
      if (i%2 == 0) { 
        if (j%2 == 0) { 
          fill ( col1 ); 
          colLocal=col1;
        }
        else 
        {
          fill ( col2 ); 
          colLocal=col2;
        }
      }  
      else {
        if (j%2 == 0) { 
          fill ( col2 ); 
          colLocal=col2;
        }
        else 
        {
          fill ( col1 ); 
          colLocal=col1;
        }
      } // if

      pushMatrix();
      PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
      MyPVector =  GetValuePVectorBoard (i, j);
      box[iBox].moveTo(MyPVector.x, MyPVector.y+11, MyPVector.z);
      // wenn die Figuren als Bilder dargestellt werden: 
      if (showFiguresAsWhat==showFiguresAsImages) { 
        if (Board [i][j] != " ") {
          box[iBox].setTexture (GetFileName(i, j), 16 ) ;
        }
      } 
      else 
      {
        if (colLocal == col1) {
          box[iBox].setTexture ( "burloak.jpg", 16 );
        } 
        else {
          box[iBox].setTexture ( "BURLOAL.JPG", 16 );
        }
      }
      box[iBox].fill(colLocal, 63); // ALL_SIDES
      box[iBox].fill(colLocal); // ALL_SIDES      
      box[iBox].tagNo = (i+1)*10 + (j+1);
      box[iBox].draw();
      iBox++; 
      popMatrix();
    } // for
  } // for
} // function   

public String GetFileName (int i, int j) {
  // this applies only when pieces/figures are shown
  // as images on the Board. 
  // The images are from Wikipedia. 
  // The name of the images are: 
  //    "Chess_" + strNameFigure (k,q,p etc.) +  
  //    strColorFigure (l or d) + 
  //    strColorBoard (l or d) + 
  //    "44.png"
  // e.g.  Chess_kll44.png ;   
  String theName = " "; 
  String strColorFigure = " "; 
  String strColorBoard = " "; 
  String strNameFigure = " "; 

  strNameFigure = trim( Board [i][j].toLowerCase() );
  if (GetFigureColor(Board [i][j]) == PlayerBlack) { 
    strColorFigure = "d";
  } 
  else { 
    strColorFigure = "l";
  } 

  strColorBoard = GetColorFieldAsString (i, j); 

  if (Board [i][j] != " ") {
    theName = "Chess_" + strNameFigure +  
      strColorFigure + strColorBoard + "44.png" ;
  }

  return(theName);
} // function   

public String GetColorFieldAsString (int i, int j) {
  // for 2D
  // delivers l or d for field-color 

  final String strCol1 = "d"; 
  final String strCol2 = "l";   
  String Buffer = ""; 
  // % is modulo, meaning rest of division 
  if (i%2 == 0) { 
    if (j%2 == 0) { 
      Buffer=strCol1;
    }
    else 
    {
      Buffer=strCol2;
    }
  }  
  else {
    if (j%2 == 0) { 
      Buffer=strCol2;
    }
    else 
    {
      Buffer =strCol1;
    }
  } // if
  return(Buffer);
}

public PVector GetValuePVectorBoard ( int x1, int y1 ) {
  // here the calculation for the positions of 
  // board is made. 
  // x1 and x2 are 0..7 (the rows and columns of the
  // Board (A..H, 1..8)).
  // oups: the y1 becomes Input for calculation of Z-value. 
  PVector MyPVector = new PVector( 0.0f, 0.0f, 0.0f );
  //   MyPVector.set (  40*x1-160, 160, 40*(7-y1)-230 );  
  MyPVector.set (  
  40*x1 + calculationForScreenPositionX, 
  160 + calculationForScreenPositionY, 
  (40*(7-y1)) + calculationForScreenPositionZ 
    );
  return(MyPVector);
}




// Tools


public void InitBoxes () {
  // boxes = fields of the board 
  for (int i=0; i<64;i++) {
    box[i] = new Box( this, 40, 5, 40 );
  }

}

public int integerFromChar(char MyChar){
  // convert  
  int Buffer = 0; 

  switch (MyChar) {
  case '0':
    Buffer = 0; 
    break; 

  case '1':
    Buffer = 1; 
    break; 

  case '2':
    Buffer = 2; 
    break; 

  case '3':
    Buffer = 3; 
    break;   

  case '4':
    Buffer = 4; 
    break;   

  case '5':
    Buffer = 5; 
    break;   

  case '6':
    Buffer = 6; 
    break;   

  case '7':
    Buffer = 7; 
    break;   

  case '8':
    Buffer = 8; 
    break;   

  case '9':
    Buffer = 9; 
    break;   

  default: 
    // 
    break; 

  } // switch 

  return ( Buffer ) ;

}



// camera

public void SetCamera() {

  PVector MyPVectorCenter = new PVector( 0.0f, 0.0f, 0.0f );
  MyPVectorCenter=GetValuePVectorBoard ( 3, 3 );    
  MyPVectorCenter.z = 6; 

  // camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
  camera (
  ((300 * sin (radians(WinkelCam))) + MyPVectorCenter.x+-0 ), 
  ((40 * sin (radians(WinkelCam))) + MyPVectorCenter.y - 70 ), 
  ((300 * cos (radians(WinkelCam))) + MyPVectorCenter.z-0 ),
  MyPVectorCenter.x, MyPVectorCenter.y, MyPVectorCenter.z,
  0, 1, 0);  // f\u00fcr eyeY: MyPVectorCenter.y + -40

    WinkelCam+=WinkelCamSpeed;

  if (WinkelCam>=360) {  
    WinkelCam=0;
  }
}



// obj-Files related 
// siehe auch OutputFig2
// http://code.google.com/p/saitoobjloader/
// http://thequietvoid.com/client/objloader/reference/index.html

public void initObjLoader () 
{

  imgDark = loadImage ( "burloak.jpg" );

  model[0] = new OBJModel ( this, "pawn.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[1] = new OBJModel ( this, "king.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[2] = new OBJModel ( this, "queen.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[3] = new OBJModel ( this, "bishop.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[4] = new OBJModel ( this, "rook.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);
  model[5] = new OBJModel ( this, "knight.obj", "relative", TRIANGLES);  // "cassini.obj", "relative", TRIANGLES);

  // je gr\u00f6\u00dfer Zahl, desto tiefer
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
    model[i].scale (.45f);
  }
  model[2].scale (3.4f);
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "Chess1d" });
  }
}
