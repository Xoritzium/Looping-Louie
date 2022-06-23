 //<>//

InGameLogic igl;

void setup() {
  frameRate(30); // should be stick to 60 !
  // background(0, 0, 0);
  fullScreen();
  // size(600,40);
  igl = new InGameLogic(2); //////// count of players 1-4
  igl.mySetup(this);
}
void draw() {
  igl.myDraw();
}
