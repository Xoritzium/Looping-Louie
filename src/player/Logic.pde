 //<>//

InGameLogic igl;

void setup() {
  frameRate(60); // should be stick to 60 !
  // background(0, 0, 0);
   fullScreen();
  // size(1000,1000);
  igl = new InGameLogic(4); //////// count of players 1-4
  igl.mySetup(this);
}
void draw() {
  igl.myDraw();
}
