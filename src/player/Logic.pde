 //<>//
/**
 inGAmeLogic
 */
InGameLogic igl;
Button backToMainMenu;
// temporary setup() and draw()
void setup() {
  frameRate(60); // should be stick to 60 !
  // background(0, 0, 0);
  fullScreen();
  // size(1000,1000);
  igl = new InGameLogic(4); //////// count of players 1-4
  igl.inGameLogicSetup(this); // this = PApplet
}
void draw() {
  igl.drawInGame();
}

//TODO-> bei Sophia eingliedern
void controlEvent(ControlEvent event) {
  if (event.isFrom(backToMainMenu)) {
    //TODO -> setup von Screen: LoopingLouieStart
  }
}
