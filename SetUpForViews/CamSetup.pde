//---------------------------------------
//--Cam Setup----------------------------
//---------------------------------------
  
  Capture cam;
  
  int jumpArraySize = (width/4)*((height/4)/2); //(9.600) arraysize of scan area for jumping
  
  void camSetup(){  
    String[] cameras = Capture.list();
    
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(this, cameras[0]);
      cam.start();     
    }
 }
  
  
//---------------------------------------
//--Cam Draw-----------------------------
//---------------------------------------

  void camDraw(){
    if(cam.available()) {
    cam.read();
    }
  image(cam, -62, 0,  762, 480); //weired tech, weired values :) (-62, 0,  762, 480)
  }
