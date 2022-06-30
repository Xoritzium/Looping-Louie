//++++++++++++++++++++++++++++++++++++++
//Player 3 RED++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++
  
  PImage scanFieldP3;
  
  void setupP3Red(){
    int adjustHeightP3 = 80;
    scanFieldP3 = cam.get(2*(width/4), ((height/4)/2)+adjustHeightP3, width/4, (height/4)/2);
    stroke(255, 0, 0);
    fill(0, 0);
    rect(2*(width/4), ((height/4)/2)+adjustHeightP3, width/4, (height/4)/2);
  }
  
  boolean isRed(){
    //char thisColor = 'R';
    int counter = 0; //count appearance of color
    scanFieldP3.loadPixels();
      for (int i = 0; i < jumpArraySize; i++) {
        color c = scanFieldP3.pixels[i];
        float value = hue(c);
        if(ifRedPixel(value)){
          counter++;
        }
        if(ifEnoughRed(counter)){
          //println(thisColor + " - " + value + " counter: " + counter);
        return true;
        }
      }
      return false;
  }

  boolean ifRedPixel(float value){ //check for RED Hue value
      if(value < 16 || value > 350){
        return true;
      }
  return false;
  }
  
  boolean ifEnoughRed(int counter){ //check for amount of color appearence
  int minimumAmount = 30;
    if(counter > minimumAmount){
      return true;  
    }
  return false;
  }
