//<>// //<>// //<>// //<>// //<>// //<>// //<>//

/* TODO:
 -Lebensabzug einbauen
 -Hitboxen überarbeiten (die sind zuweit vor der Grafik)
 -Radiusübergang anpassen, schleichende Übergänge
 -Grafik (in blender und dann als gif oder MP4 rendern.
 
 */



// center of the picture, origin from where everthing gets calculated
float originX = 1920 / 2; //width / 2;
float originY = 1080 / 2; //width /2;
//////////Louie/////////////////
Louie louie;

float louieRadius = 450;
float louieSpeed = 0.01; // speed of louies Movement [0.0 - 0.05]
float hitDuration = 65; // duration in frames how long Louies Collision is set of


///////////////////// Koordinates and Hitboxes from the players ////////////////
// all Players
Player top, right, left, down;
// every PlayersWidth;
float playerWidth= 200;
float playerHeight=200;
// cooridnates to spawn/stay
float topx = originX;
float topy = originY - louieRadius;

float rightx = originX + louieRadius;
float righty= originY;

float downx = originX;
float downy =originY + louieRadius;

float leftx = originX - louieRadius;
float lefty = originY;
// hitboxes
//each Player has a Hitbox of a 200x200 box
// not perfectly balance = right has a frame less time to manipulate louie
float[] topBounds = {topx - playerWidth, topx, topy, topy + playerHeight};
float[] rightBounds = { rightx - playerWidth, rightx, righty, righty + playerHeight};
float[] downBounds = { downx, downx + playerWidth, downy - playerHeight/2, downy + playerHeight / 2};
float[] leftBounds ={leftx, leftx+playerWidth, lefty, lefty + playerHeight };
////////////////// temporary//////////////////////
int counter1 = 0;
int counter2 = 0;
int counter3 = 0;
int counter4=0;


View view; // a view to bound all visuals
/*
Keep things clean, everything which i need and is not defined for setup() is stored here
 */
void mySetup() {
  /////////// initiate all instances //////////////
  louie = new Louie(louieRadius, louieSpeed, hitDuration);
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
  background(20, 20, 20); // refresh the canvas every second

  view.drawPlayer(top.xpos, top.ypos, 0);
  view.drawPlayer(right.xpos, right.ypos, 1);
  view.drawPlayer(down.xpos, down.ypos, 2);
  view.drawPlayer(left.xpos, left.ypos, 3);



  if  (checkPlayerHitLouie(louie.xpos, louie.ypos, top, topBounds)) { // top
    louie.indicator = true; // set collision off
    counter1++;
  } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, right, rightBounds)) { // right
    louie.indicator = true; // set collision off
    counter2++;
  } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, down, downBounds)) { // down
    louie.indicator = true; // set collision off
    counter3++;
  } else  if  (checkPlayerHitLouie(louie.xpos, louie.ypos, left, leftBounds)) { // left
    louie.indicator = true; // set collision off
    counter4++;
  }

  if (isPlayerHit() == 1) {
    top.cone.cones--;
  }
  text("TopCones: " + top.cone.cones, 20, 120);
  louie.movement(); // updates louies position every frame
  view.drawLouie(louie.xpos, louie.ypos); // draw louie (always in the same frame as louie.movement() !!


  text("top hits: " + counter1, 20, 40);
  text("right hits: " + counter2, 20, 60);
  text("down hits: " + counter3, 20, 80);
  text("left hits: " + counter4, 20, 100);
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
}


/* returns wheter louie hitted a 
 @return :
 0: no playerHit
 1: top hit
 2: right hit
 3: down hit
 4: left hit
         
 */
int isPlayerHit() { 
  //top
  if (louie.xpos >= topx && louie.xpos <= topx+ 5 // the "hitbox" of the cones/hearts and if louies hitbox is on
    &&louie.ypos >= topy && louie.ypos <= topy + 5 && louie.indicator) {
    return 1;
  }else if(louie.xpos >= rightx && louie.xpos <= rightx + 5 &&
  louie.ypos >= righty && louie.ypos <= righty + 5 && !louie.indicator){
   return 2; 
  }else if (louie.xpos >= downx && louie.xpos <= downx + 5 &&
  louie.ypos >= downy &&  louie.ypos <= downy + 5 && !louie.indicator){
   return 3;
  }else if() {
    return 4
  }else
  
  //right

  //down

  //left

  return 0; // casul value
}
}


/*
if a Player hits Louie return true
 is called in a specific order in draw()
 @param lx = louies xpos
 @param ly = louies ypos
 @param p = the player which hitbox is checked
 @param hb = bounds of the individual player
 */
boolean checkPlayerHitLouie(float lx, float ly, Player p, float[] hb) {
  if (lx >= hb[0] && lx <= hb[1]
    && ly >= hb[2] && ly <= hb[3] && p.hadJumped()) { //had jumped einfügen

    return true;
  }
  return false;
}





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
