

// get the inputs 

// ==========================================================

void mouseReleased () {
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

void keyPressed() {
  // evaluate key
  if (key == CODED) {
    // coded
    switch (keyCode) {
    case UP: 
      showFiguresAsWhat++; 
      if (showFiguresAsWhat>2) {
        showFiguresAsWhat=showFiguresAsBauhaus;
        moveRunningX_ScreenAdd =11.0; 
        moveRunningY_ScreenAdd =11.0;
      }
      if (showFiguresAsWhat==showFiguresAsBauhaus) {
        moveRunningX_ScreenAdd =11.0; 
        moveRunningY_ScreenAdd =11.0;
        moveRunningDivide = 50;
      } 
      else if 
        (showFiguresAsWhat==showFiguresAsFull3D) {
        moveRunningX_ScreenAdd =21.0; 
        moveRunningY_ScreenAdd =21.0;
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
        moveRunningX_ScreenAdd =11.0; 
        moveRunningY_ScreenAdd =11.0;
        moveRunningDivide = 50;
      } 
      else if 
        (showFiguresAsWhat==showFiguresAsFull3D) {
        moveRunningX_ScreenAdd =11.0; 
        moveRunningY_ScreenAdd =11.0;
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
      PVector MyPVectorCenter = new PVector( 0.0, 0.0, 0.0 );
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


void keyReleased() {
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

