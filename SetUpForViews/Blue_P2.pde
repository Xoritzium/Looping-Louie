//++++++++++++++++++++++++++++++++++++++
//Player 2 BLUE+++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++
  
  PImage scanFieldP2;
  
  void setupP2Blue(){
    int adjustHeightP2 = 80;
    scanFieldP2 = cam.get(1*(width/4), ((height/4)/2)+adjustHeightP2, width/4, (height/4)/2);
    stroke(0, 0, 255);
    fill(0, 0);
    rect(1*(width/4), ((height/4)/2)+adjustHeightP2, width/4, (height/4)/2);
  }
  
  boolean isBlue(){
    int counter = 0; //count appearance of color
    scanFieldP2.loadPixels();
      for (int i = 0; i < jumpArraySize; i++) {
        color c = scanFieldP2.pixels[i];
        float value = hue(c);

          if(ifBluePixel(value)){
            counter++;
            if(ifEnoughBlue(counter)){
              print(" - " + value + " counter: " + counter);
              print(" - BLUE----->");
              return true;
            }
          }
      }
      return false;
  }

  boolean ifBluePixelAutoMode(float value){ //check for BLUE Hue value
      if(value > blueAutoValue - 5 && value < blueAutoValue + 5){ //auto
        return true;
      }
  return false;
  }

  boolean ifBluePixel(float value){ //check for BLUE Hue value
      if(value > 160 && value < 190){ //manuell
        return true;
      }
  return false;
  }
  

  
  boolean ifEnoughBlue(int counter){ //check for amount of color appearence
  int minimumAmount = 20;
    if(counter > minimumAmount){
      return true;  
      }
  return false;
  }
