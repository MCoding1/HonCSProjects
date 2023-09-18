

// random PC Move with no chess rules


void PC_Move () {

  int RandomResult = int( random (0,16) ) ; 
  int Distance = int( random (2,6) ) ; 
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

int GetFigureColor ( String FieldOfBoard ) {

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




