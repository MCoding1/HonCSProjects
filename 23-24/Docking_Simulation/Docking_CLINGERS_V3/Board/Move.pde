

// make a move - it's used by human player and 
// by PC's Move.


boolean MakeAMove (String Move1) {

  int x1; // from 
  int y1;  

  int x2; // to 
  int y2;  

  boolean valid = true; 
  boolean done = false; 

  x1= int(Move1.charAt(0))-65;   
  y1= integerFromChar(Move1.charAt(1))-1; 

  x2= int(Move1.charAt(2))-65; 
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
      PVector MyPVectorFrom = new PVector( 0.0, 0.0, 0.0 );
      MyPVectorFrom=GetValuePVector ( x1, y1 );
      PVector MyPVectorTo = new PVector( 0.0, 0.0, 0.0 );
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

void moveRunningControl () {
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

boolean IfMoveRunningIsDone () {
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

