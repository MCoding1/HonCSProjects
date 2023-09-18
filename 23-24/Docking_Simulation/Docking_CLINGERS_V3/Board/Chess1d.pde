

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
import processing.opengl.*;

/** PeasyCam **/
import peasy.*;

// to display the 3D-non-Bauhaus-pieces 
import saito.objloader.*;

/**
 * library for the shape picking feature. 
 * This uses the off-screen buffer version of the pick
 * shape algorithm.
 * created by Peter Lager 2010
 */
import shapes3d.utils.*;
import shapes3d.*;

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
int col1 = #d18b47; 
int col2 = #ffce9e;   

// color for figures
color colWhite = 253;
color colBlack = 72; 

// Camera
PeasyCam cam;
//CameraState MyState; 
//CameraState MyStateMove; 
CameraState camMyStateAtBeginning; 
CameraState camMyStateFor2D; 
// Flag to show whether cam is Mouse controlled
boolean camIsMouseControlled = false; 

float WinkelCam=110;
float WinkelCamSpeed=0.21;

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

float moveRunningX_ScreenFrom = 0.0;
float moveRunningY_ScreenFrom = 0.0;
float moveRunningX_ScreenTo = 0.0;
float moveRunningY_ScreenTo = 0.0;
float moveRunningX_ScreenAdd =11.0; // moveRunningX_ScreenAdd 
float moveRunningY_ScreenAdd =11.0; 
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

void setup () { 
  SetupNormal3d() ;
}  

void SetupNormal3d() {
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

void SetupOnly2D_______ALT () {  
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

void draw () {
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

