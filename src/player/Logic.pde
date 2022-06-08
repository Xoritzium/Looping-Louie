 //<>// //<>// //<>// //<>// //<>//
// Louie
Louie louie;
// all Players
Player top, right, left, down;
float originX = 1920/2;
float originY =1080/2;
float louieRadius = 450;
float louieSpeed = 0.015; // speed of louies Movement [0.0 - 0.05]

float topx = originX;
float topy = originY - louieRadius;

float rightx = originX + louieRadius;
float righty= originY;

float downx = originX;
float downy =originY + louieRadius;

float leftx = originX - louieRadius;
float lefty = originY;




View view; // a view to bound all visuals


void setup() {
  frameRate(60); // should be stick to 60 !
  // background(0, 0, 0);
  fullScreen();

  //size(800,800);
  /////////// initiate all instances //////////////
  louie = new Louie(louieRadius, louieSpeed);
  top = new Player(topx, topy);
  right = new Player(rightx, righty);
  left = new Player(leftx, lefty);
  down = new Player(downx, downy);
  view = new View(200, 200, 50, 50);
}
void draw() {

  background(0, 0, 0); // refresh the canvas
  louie.movement(); // updates louies position every frame
  view.drawLouie(louie.xpos, louie.ypos); // draw louie (always in the same frame as louie.movement() !! //<>//

  view.drawPlayer(top.xpos, top.ypos, 0);
  view.drawPlayer(right.xpos, right.ypos, 1);
  view.drawPlayer(down.xpos, down.ypos, 2);
  view.drawPlayer(left.xpos, left.ypos, 3);
}



/* if a Player is hit his value "coneHit" will set true and this returns true as well
 */
boolean isPlayerHit() {
  return false;
}


/*
if a Player hits Louie return true
 */
boolean checkPlayerHitLouie() {
  return false;
}
