


// Tools


void InitBoxes () {
  // boxes = fields of the board 
  for (int i=0; i<64;i++) {
    box[i] = new Box( this, 40, 5, 40 );
  }

}

int integerFromChar(char MyChar){
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

