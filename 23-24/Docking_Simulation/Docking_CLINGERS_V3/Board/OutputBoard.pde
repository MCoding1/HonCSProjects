

// Board outputs are here. 
// Delivers the simple Board (when figures are 3D) 
// OR 
// the Board with the 2D-Figures painted on the Board (when figures are 2D). 
// ========================================

void CheckeredBoard() {
  color colLocal=0;
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
      PVector MyPVector = new PVector( 0.0, 0.0, 0.0 );
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

String GetFileName (int i, int j) {
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

String GetColorFieldAsString (int i, int j) {
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

PVector GetValuePVectorBoard ( int x1, int y1 ) {
  // here the calculation for the positions of 
  // board is made. 
  // x1 and x2 are 0..7 (the rows and columns of the
  // Board (A..H, 1..8)).
  // oups: the y1 becomes Input for calculation of Z-value. 
  PVector MyPVector = new PVector( 0.0, 0.0, 0.0 );
  //   MyPVector.set (  40*x1-160, 160, 40*(7-y1)-230 );  
  MyPVector.set (  
  40*x1 + calculationForScreenPositionX, 
  160 + calculationForScreenPositionY, 
  (40*(7-y1)) + calculationForScreenPositionZ 
    );
  return(MyPVector);
}

