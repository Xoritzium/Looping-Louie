 //<>// //<>// //<>//

// center of the picture, origin from where everthing gets calculated
float originX = 1920 / 2; //width / 2;
float originY = 1080 / 2; //width /2;
//////////Louie/////////////////
Louie louie;


float louieRadius = 450;
float louieSpeed = 0.01; // speed of louies Movement [0.0 - 0.05]


///////////////////// Koordinates and Hitboxes from the players ////////////////
// all Players
Player top, right, left, down;

float topx = originX;
float topy = originY - louieRadius;

float rightx = originX + louieRadius;
float righty= originY;

float downx = originX;
float downy =originY + louieRadius;

float leftx = originX - louieRadius;
float lefty = originY;


float[]topBounds = {
  originX + (louieRadius *sin((7/8)*PI)), // top lowerBound X
  originY + (louieRadius *cos((7/8) * PI)), //top lowerBound Y
  originX + (louieRadius * sin(PI)), // top higherBound X
  originY +(louieRadius * sin(PI))// top higher bound Y
};
float[] rightBounds = {
  originX + (louieRadius *sin((9/8)*PI)), // right
  originY + (louieRadius *cos((9/8)*PI)),
  originX + (louieRadius * sin((1/2)*PI)),
  originY + (louieRadius * cos((1/2)*PI))
};
float[] downBounds = {
  originX + (louieRadius *sin((15/8)*PI)), // down
  originY + (louieRadius *cos((15/8)*PI)),
  originX + (louieRadius * sin(2*PI)),
  originY + (louieRadius * cos(2*PI))
};
float[] leftBounds ={
  originX + (louieRadius *sin((3/8)*PI)), // left
  originY + (louieRadius *cos((3/8)*PI)),
  originX + (louieRadius * sin(PI/2)),
  originY + (louieRadius * cos(PI/2))
};

int counter = 0;
View view; // a view to bound all visuals
/*
Keep things clean, everything which i need and is not defined for setup() is stored here
 */
void mySetup() {
  /////////// initiate all instances //////////////
  louie = new Louie(louieRadius, louieSpeed);
  top = new Player(topx, topy, 0);
  right = new Player(rightx, righty, 0);
  left = new Player(leftx, lefty, 0);
  down = new Player(downx, downy, 0);
  view = new View();
}
/*
Keep things clean, everything which i need and is not defined for void() is stored here
 */
void myDraw() {
  background(20, 20, 20); // refresh the canvas

  view.drawPlayer(top.xpos, top.ypos, 0);
  view.drawPlayer(right.xpos, right.ypos, 1);
  view.drawPlayer(down.xpos, down.ypos, 2);
  view.drawPlayer(left.xpos, left.ypos, 3);

  louie.movement(); // updates louies position every frame
  view.drawLouie(louie.xpos, louie.ypos); // draw louie (always in the same frame as louie.movement() !!

  if  (checkPlayerHitLouie(louie.xpos, louie.ypos)) {
    counter++;
  }
  text("top hits: " + counter, 20, 40);
}

void setup() {
  frameRate(60); // should be stick to 60 !
  // background(0, 0, 0);
  fullScreen();
  // size(600,40);
  mySetup();
}
void draw() {
  myDraw();
  
  if(counter++ < 200) {
   text("qqqqqqqqqqqqqqqqqqqqqqq", 120,120); 
  }
 
}



/* if a Player is hit his value "coneHit" will set true and this returns true as well
 */
boolean isPlayerHit() {
  return false;
}


/*
if a Player hits Louie return true
 @param lx = louies xpos
 @param ly = louies ypos
 @param b = bounds of the individual player
 */
boolean checkPlayerHitLouie(float lx, float ly) { // exemplarisch für top // einmal das ganze Raster ablaufen von lower x/y bis higher x/y
 float[] topBounds = {topx - 200, topx, topy, topy+200};
  if (lx >= topBounds[0] - 200 && lx <= topBounds[1]
    && ly >= topy && ly <= topy +200 && top.hadJumped()) {
    return true;
  }
  return false;
}
//      xpos = xmiddle + (radius * sin( -angle)); // positiv angle changes the direction to clockwise
//   ypos = ymiddle + (radius * cos(angle));




// better safe then sorry/////////////
/*
float topLB =originX + (louieRadius *sin((7/8)*PI)); //LB = lowerBound
 y=originY + (louieRadius *cos((7/8) * PI));
 
 float topHB =originx + (louieRadius * sin(PI));     // HB = higherBound
 y= originY +(LouieRadius * sin(PI));
 float rightLB =originX + (louieRadius *sin((9/8)*PI));//
 y = originy + (louieRadius *cos((9/8)*PI));
 
 float rightHB =originY + (louieRadius * sin((1/2)*PI));
 y=originY + (louieRadius * cos((1/2)*PI));
 
 float downLB =originX + (louieRadius *sin((15/8)*PI));
 y=originY + (louieRadius *cos((15/8)*PI));
 
 float downHB =originY + (louieRadius * sin(2*PI));
 y=originY + (louieRadius * cos(2*PI));
 
 float leftLB =originX + (louieRadius *sin((3/8)*PI));
 y=originY + (louieRadius *cos((3/8)*PI));
 
 float leftHB =originX + (louieRadius * sin(PI/2));
 y=originY + (louieRadius * cos(PI/2));
 */
