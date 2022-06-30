  
PImage colorInputAdjustmentP1;
PImage colorInputAdjustmentP2;
PImage colorInputAdjustmentP3;
PImage colorInputAdjustmentP4;

int colorAutoAdjustmentArraySize = ((width/16)/2)*((height/16)/2); //arraysize of scan area

float yellowAutoValue;
float blueAutoValue;

void counter(){
  for (int i = 0; i < 10; i++) {
    println(i);
    delay(900);
  }
}
  
//P1 Yellow
  float playerColorSetupAutoYellow(){
    colorInputAdjustmentP1 = cam.get((width/8)-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
    colorInputAdjustmentP1.loadPixels();
    float totalSum = 0;
      for (int i = 0; i < colorAutoAdjustmentArraySize; i++) {
        color c = colorInputAdjustmentP1.pixels[i];
         float tmp = hue(c);
         totalSum=totalSum+tmp; 
      }
      yellowAutoValue = totalSum/colorAutoAdjustmentArraySize;
      return yellowAutoValue;
  }
  
  
//P2 Blue
  float playerColorSetupAutoBlue(){
    colorInputAdjustmentP2 = cam.get(((width/8)+(2*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
    colorInputAdjustmentP2.loadPixels();
    float totalSum = 0;
      for (int i = 0; i < colorAutoAdjustmentArraySize; i++) {
        color c = colorInputAdjustmentP1.pixels[i];
         float tmp = hue(c);
         totalSum=totalSum+tmp; 
      }
      blueAutoValue = totalSum/colorAutoAdjustmentArraySize;
      return blueAutoValue;
  }
  
//P3 Red
  float playerColorSetupAutoRed(){
    colorInputAdjustmentP3 = cam.get(((width/8)+(4*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
    colorInputAdjustmentP3.loadPixels();
    float totalSum = 0;
      for (int i = 0; i < colorAutoAdjustmentArraySize; i++) {
        color c = colorInputAdjustmentP1.pixels[i];
         float tmp = hue(c);
         totalSum=totalSum+tmp; 
      }
      return totalSum/colorAutoAdjustmentArraySize;
  }
  
//P4 Green
  float playerColorSetupAutoGreen(){
    colorInputAdjustmentP4 = cam.get(((width/8)+(6*(width/8)))-(((width/16)/2)/2), height/2, (width/16)/2, (height/16)/2);
    colorInputAdjustmentP4.loadPixels();
    float totalSum = 0;
      for (int i = 0; i < colorAutoAdjustmentArraySize; i++) {
        color c = colorInputAdjustmentP1.pixels[i];
         float tmp = hue(c);
         totalSum=totalSum+tmp; 
      }
      return totalSum/colorAutoAdjustmentArraySize;
  }
