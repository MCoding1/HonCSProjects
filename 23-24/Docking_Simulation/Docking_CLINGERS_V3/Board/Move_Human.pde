

// human move and tools


void MakeHumanMove(int pickedTagNo) {
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

void setup_TESTING () {
  // test
  println ( makeToFieldExpression(42));
  println ( DivideWithoutModulo (483,100) ); 
  println ( DivideWithoutModulo (83,10) );   
  println ( DivideWithoutModulo (3,1) );   
  exit();
}

boolean fieldIsOk (int Number1) {
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

String makeToFieldExpression(int Number1) {
  // delivers A1 from 11.  
  // gets 11..88 as parameter. 
  String Buffer =""; 
  int LeftNumber = DivideWithoutModulo(Number1, 10); 
  int RightNumber =  Number1 - LeftNumber*10;   
  Buffer = str(char(LeftNumber+64)) + str(RightNumber); 
  Buffer = trim(Buffer);
  return (Buffer); 
}

int DivideWithoutModulo ( int dividend1, int divisor1  ) {
  // Division: Give the answer as an integer quotient without the remainder. 
  // This is sometimes called integer division.
  // With (83,10) as parameters the result is 8. 

  int Buffer = -1; 

  int ModuloResult = dividend1 % divisor1 ; 
  dividend1 = dividend1 - ModuloResult; 
  Buffer =  dividend1 / divisor1; 

  return (Buffer);
}      

