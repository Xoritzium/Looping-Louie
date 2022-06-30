boolean autoSetupLoopOnOff = true;
boolean gamePlayLoopOnOff = false;
 /*
 void stupidFuck(boolean f){
     if(f){
      autoSetupLoop();
      autoSetupLoopOnOff = false;
     }
 }
 */
 
void autoSetupLoop(){
  println("Please hold color in front of small rectangle field");
  counter(); //ca 10 secs counter
    //noLoop();
      playerColorSetupAutoYellow();//get the yellow
      println(yellowAutoValue);
      
      playerColorSetupAutoBlue(); //get the blue
      println(blueAutoValue);
      
      println(playerColorSetupAutoRed());
      
      println(playerColorSetupAutoGreen());
    //loop();
      
      gamePlayLoopOnOff = true;

}
  
void gameLoop(){
      setupP1Yellow();
      thread("isYellow");
      
      setupP2Blue();
      thread("isBlue");
      
      setupP3Red();
      thread("isRed");
    
      setupP4Green();
      thread("isGreen");
}
