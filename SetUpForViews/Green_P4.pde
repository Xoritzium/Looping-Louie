//+++++++++++++++++++++++++++++++++++
//Player 4 Green+++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++

  PImage scanFieldP4;
  
  void setupP4Green(){
    int adjustHeightP4 = 50;
    scanFieldP4 = cam.get(3*(width/4), ((height/4)/2)+adjustHeightP4, width/4, (height/4)/2);
    stroke(255, 255, 0);
    fill(0, 0);
    rect(3*(width/4), ((height/4)/2)+adjustHeightP4, width/4, (height/4)/2);
  }
  
    boolean isGreen(){
    //char thisColor = 'G';
    int counter = 0; //count appearance of color
    scanFieldP4.loadPixels();
      for (int i = 0; i < jumpArraySize; i++) {
        color c = scanFieldP4.pixels[i];
        float value = hue(c);
                //print("   "+value + "  ");
          if(ifgreenPixel(value)){
            counter++;
            if(ifEnoughGreen(counter)){
              //print(thisColor + " - " + value + " counter: " + counter);
              //println(" - Green");
              return true;
            }
          }
      }
      return false;
  }

  boolean ifgreenPixel(float value){ //if color hue is found
      if(value > 40 && value < 70){
        return true;
      }
  return false;
  }
  
  boolean ifEnoughGreen(int counter){ //check for amount of color appearence
    int minimumAmount = 40;
      if(counter > minimumAmount){
        return true;  
      }
  return false;
  }
