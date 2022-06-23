// stores the needed inGameLogic //<>// //<>//
public class InGameLogic {
  // create the Logic
  public InGameLogic(int playerCount) {
    this.playerCount = playerCount;
    switch(playerCount) {
    case 1:
      ignoreRight = true;
      ignoreDown = true;
      ignoreDown = true;
      break;
    case 2:
      ignoreRight = true;
      ignoreLeft = true;
      break;
    case 3:
      ignoreLeft = true;
    case 4:
      break; // all players are used
    default:
      System.err.println("invalid Number of Players");
    }
  }


  /* TODO:
   -dile/jump neu rendern vor gelben Hintergrund -> die als Movie abspielen !
   -ggf playerHit() und playerHItLouie() noch in methoden mit switches auslagern -> performance
   */
  ////////////////logic stuff ///////////////////////////////
  boolean gameOver = false;
  boolean ignoreTop = false;
  boolean ignoreRight = false;
  boolean ignoreDown = false;
  boolean ignoreLeft = false;
  int playerCount;


  // center of the picture, origin from where everthing gets calculated
  float originX = width / 3; //width / 2;
  float originY = height / 2; //width /2;
  //////////Louie/////////////////
  Louie louie;

  float louieRadius = 450;
  float louieSpeed = 0.02; // speed of louies Movement [0.01 , doubled = 0.02]
  float hitDuration = 65 / 2; // duration in frames how long Louies Collision is set of or /2 if the speed is doubled !!!!!must be overwritten in louie, is not the case yet


  ///////////////////// Koordinates and Hitboxes from the players ////////////////
  // all Players
  Player top, right, left, down;
  // every PlayersWidth;
  float playerWidth= 25;
  float playerHeight=25;
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
  float[] rightBounds = { rightx - playerWidth, rightx, righty- playerHeight, righty};
  float[] downBounds = { downx, downx + playerWidth, downy - playerHeight, downy + playerHeight};
  float[] leftBounds ={leftx, leftx+playerWidth, lefty, lefty + playerHeight };
  //float[][] allBounds = {topBounds,rightBounds,downBounds,leftBounds};



  ////////////////// temporary//////////////////////
  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;
  int counter4=0;
  //////////////////////////////////////////////////

  View view; // a view to bound all visuals
  /*
Keep things clean, everything which i need and is not defined for setup() is stored here
   */
  /**
   @param p needed ViewCanvas to transfer it to the View !
   */
  void mySetup(PApplet p) {
    /////////// initiate all instances //////////////
    louie = new Louie(louieRadius, louieSpeed, hitDuration, originX, originY);
    top = new Player(topx, topy, 0);
    right = new Player(rightx, righty, 0);
    left = new Player(leftx, lefty, 0);
    down = new Player(downx, downy, 0);
    view = new View(p);
  }
  /*
Keep things clean, everything which i need and is not defined for void() is stored here
   */
  void myDraw() {
    if (!gameOver) {// while game is still running
      setGameOver();
      background(#ffb61e); // refresh the canvas every second

      ///////////////////////Player hits Louie////////////////////////////
      playerHitLouie();
      ////////////////////////// Louie hits a players cone////////////////
      louieHitPlayer();
      ////////////////////////////////////////////////////////////////////
      text("TopCones: " + top.cone.cones, 20, 120);
      text("RightCones: " + right.cone.cones, 20, 140);
      text("DownCones: " + down.cone.cones, 20, 160);
      text("LeftCones: " + left.cone.cones, 20, 180);
      louie.movement(); // updates louies position every frame
      ////////////////////////////////////////////////////////////////////
      view.drawUIElements(); // draw ui elements
      notifyViewForPlayers(); // draw PLayers
      view.drawLouie(louie.xpos, louie.ypos); // draw louie (always in the same frame as louie.movement() !!
      /*
  text("top hits: " + counter1, 20, 40);
       text("right hits: " + counter2, 20, 60);
       text("down hits: " + counter3, 20, 80);
       text("left hits: " + counter4, 20, 100);
       */
    } else {
      gameOver();
    }
  }




  /* returns wheter louie hitted a
   @return :
   -1: no playerHit
   0: top hit
   1: right hit
   2: down hit
   3: left
   
   */
  private int isPlayerHit() {
    if (louie.xpos >= topx && louie.xpos <= topx+ 5 // the "hitbox" of the cones/hearts and if louies hitbox is on
      &&louie.ypos >= topy && louie.ypos <= topy + 5 && !louie.indicator  ) {
      return 0;
    } else if (louie.xpos >= rightx -5 && louie.xpos <= rightx  &&
      louie.ypos >= righty && louie.ypos <= righty + 2 && !louie.indicator ) {
      return 1;
    } else if (louie.xpos >= downx-5 && louie.xpos <= downx  &&
      louie.ypos >= downy -5 &&  louie.ypos <= downy  && !louie.indicator ) {
      return 2;
    } else if (louie.xpos >= leftx && louie.xpos <= leftx + 5 &&
      louie.ypos >= lefty  && louie.ypos <= lefty + 5 && !louie.indicator ) {
      return 3;
    }
    return -1; // casual value
  }


  // logic for confirmation Luie hit a player
  void louieHitPlayer() {
    int hit = isPlayerHit();
    if (hit ==0 && !ignoreTop) {
      top.cone.cones--;
    } else if (hit ==1 && !ignoreRight) {
      right.cone.cones--;
    } else if (hit==2 && !ignoreDown) {
      down.cone.cones--;
    } else if (hit ==3 && !ignoreLeft) {
      left.cone.cones--;
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
      && ly >= hb[2] && ly <= hb[3] && p.hadJumped()) {
      return true;
    }
    return false;
  }


  /**
   Logic for the confirmation a player hit Louie
   */
  void playerHitLouie() {
    if  (checkPlayerHitLouie(louie.xpos, louie.ypos, top, topBounds) && !ignoreTop) { // top
      louie.indicator = true; // set collision off
      counter1++;
    } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, right, rightBounds) && !ignoreRight) { // right
      louie.indicator = true; // set collision off
      counter2++;
    } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, down, downBounds) && !ignoreDown) { // down
      louie.indicator = true; // set collision off
      counter3++;
    } else  if  (checkPlayerHitLouie(louie.xpos, louie.ypos, left, leftBounds) && !ignoreLeft) { // left
      louie.indicator = true; // set collision off
      counter4++;
    }
  }


  /*
sets the gameOver state
   */
  private void setGameOver() {
    if (top.cone.cones ==0 || right.cone.cones ==0 ||down.cone.cones ==0 || left.cone.cones ==0) {
      gameOver = true;
    }
  }

  /*
clean up
   return to main menu ?
   */
  private void gameOver() {
    view.drawEndScreen();
  }

  /**
   Draw the given amount of Players
   */
  void notifyViewForPlayers() {
    switch(playerCount) {
    case 1:
      view.drawPlayer(top.xpos, top.ypos, 0);
      break;
    case 2:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(down.xpos, down.ypos, 2);
      break;
    case 3:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(right.xpos, right.ypos, 1);
      view.drawPlayer(down.xpos, down.ypos, 2);
      break;
    case 4:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(right.xpos, right.ypos, 1);
      view.drawPlayer(down.xpos, down.ypos, 2);
      view.drawPlayer(left.xpos, left.ypos, 3);
      break;
    default:
      break;
    }
  }
}
