//+++++++++++++++++++++++++++++++++++
//Player 1 YELLOW++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++
  
  PImage scanFieldP1;
  boolean yellow;
  
  void setupP1Yellow(){
    int adjustHeightP1 = 50;
    scanFieldP1 = cam.get(0, ((height/4)/2)+adjustHeightP1, width/4, (height/4)/2);
    stroke(255, 255, 0);
    fill(0, 0);
    rect(0, ((height/4)/2)+adjustHeightP1, width/4, (height/4)/2);
  }

  boolean isYellow(){
    int counter = 0; //count appearance of color
    scanFieldP1.loadPixels();
      for (int i = 0; i < jumpArraySize; i++) {
        color c = scanFieldP1.pixels[i];
        float value = hue(c);
                //print("   "+value + "  ");
          if(ifYellowPixel(value)){
            counter++;
            if(ifEnoughYellow(counter)){
              print(" - " + value + " counter: " + counter);
              print(" - YELLOW----->");
            yellow = true;
            return yellow;
            }
          }
      }
  yellow = false;
  return yellow;
  }
  

  boolean ifYellowPixelAutoMode(float value){ //if color hue is found
        if(value > yellowAutoValue - 5 && value < yellowAutoValue + 5){
        return true;
      }
  return false;
  }
  
   boolean ifYellowPixel(float value){ //if color hue is found
      if(value > 43 && value < 55){ //manuell
        return true;
      }
  return false;
  }
  
  
  
  
  boolean ifEnoughYellow(int counter){ //check for amount of color appearence
    int minimumAmount = 40;
      if(counter > minimumAmount){
        return true;  
      }
  return false;
  }
