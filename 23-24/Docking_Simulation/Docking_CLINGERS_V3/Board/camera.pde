

// camera

void SetCamera() {

  PVector MyPVectorCenter = new PVector( 0.0, 0.0, 0.0 );
  MyPVectorCenter=GetValuePVectorBoard ( 3, 3 );    
  MyPVectorCenter.z = 6; 

  // camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
  camera (
  ((300 * sin (radians(WinkelCam))) + MyPVectorCenter.x+-0 ), 
  ((40 * sin (radians(WinkelCam))) + MyPVectorCenter.y - 70 ), 
  ((300 * cos (radians(WinkelCam))) + MyPVectorCenter.z-0 ),
  MyPVectorCenter.x, MyPVectorCenter.y, MyPVectorCenter.z,
  0, 1, 0);  // für eyeY: MyPVectorCenter.y + -40

    WinkelCam+=WinkelCamSpeed;

  if (WinkelCam>=360) {  
    WinkelCam=0;
  }
}

