// stores the needed inGameLogic //<>// //<>//
public class InGameLogic {
  /** create the Logic
   @param playerCount = amount of players
   */
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
   - spiel beenden und zurück zum Mainmenue gehen knöpfe integrieren
   - kommentieren
   -zusammenbauen
   */
  ////////////////logic stuff ///////////////////////////////
  boolean gameOver = false; // defining the end of the game
  boolean ignoreTop = false;//wich logic should be ignored, in case there are less than four players @playersCount
  boolean ignoreRight = false;
  boolean ignoreDown = false;
  boolean ignoreLeft = false;
  int playerCount;
  //first seconds noone can be hit
  boolean initiateDraw = true;
  int winner = -1; //defining the winner


  // center of the picture, origin from where everthing gets calculated
  float originX = width / 3; //width / 2;
  float originY = height/ 2; //width /2;
  //////////Louie/////////////////
  Louie louie;

  float louieRadius = width / (12.14) + height / (5); // radius, depending on the window
  // float louieRadius = 450;
  float louieSpeed = 0.02; // speed of louies Movement [0.01 , doubled = 0.02]
  float hitDuration = 65 / 2; // duration in frames how long Louies Collision is set of or /2  if the speed is doubled !!!!!must be overwritten in louie, is not the case yet


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
  // not perfectly balance = right has a frame less time to manipulate louie  -> @note = the seems to be unnoticed
  float[] topBounds = {topx - playerWidth, topx, topy, topy + playerHeight};
  float[] rightBounds = { rightx - playerWidth, rightx, righty- playerHeight, righty};
  float[] downBounds = { downx, downx + playerWidth, downy - playerHeight, downy + playerHeight};
  float[] leftBounds ={leftx, leftx+playerWidth, lefty, lefty + playerHeight };


  View view; // a view to bound all visuals
  /*
Keep things clean, everything which i need and is not defined for setup() is stored here
   */
  /**
   @param p needed ViewCanvas to transfer it to the View ! -> its the main class, to be called in setup() method
   */
  void inGameLogicSetup(PApplet p) {
    /////////// initiate all instances //////////////
    louie = new Louie(louieRadius, louieSpeed, hitDuration, originX, originY);
    top = new Player(topx, topy, 0, 'w');
    right = new Player(rightx, righty, 0, 'd');
    left = new Player(leftx, lefty, 0, 'a');
    down = new Player(downx, downy, 0, 's');
    view = new View(p);
  }
  /*
Keep things clean, everything i need and is not defined for draw() is stored here
   */
  void drawInGame() {
    if (initiateDraw) { // fairplay = first two seconds louie cant hit a player
      louie.indicator = true;
      initiateDraw = false;
    }

    if (!gameOver) {// while game is still running
      setGameOver();
      background(#ffb61e); // refresh the canvas every second

      ///////////////////////Player hits Louie////////////////////////////
      playerHitLouie();
      ////////////////////////// Louie hits a players cone////////////////
      louieHitPlayer();
      ////////////////////////////////////////////////////////////////////
      ui();
      notifyViewForPlayers(); // draw PLayers

      view.drawLouie(louie.xpos, louie.ypos); // draw louie (always in the same frame as louie.movement() !!
      louie.movement();
    } else {
      gameOver(winner);
    }
  }




  /* returns whether louie hitted a player or not
   @return :
   -1: no playerHit
   0: top hit
   1: right hit
   2: down hit
   3: left
   */
  private int isPlayerHit() {
    if (louie.xpos >= topx && louie.xpos <= topx+ 10 // the "hitbox" of the cones/hearts and if louies hitbox is on
      &&louie.ypos >= topy && louie.ypos <= topy + 10 && !louie.indicator  ) {
      return 0;
    } else if (louie.xpos >= rightx -10 && louie.xpos <= rightx  &&
      louie.ypos >= righty && louie.ypos <= righty + 5 && !louie.indicator ) {
      return 1;
    } else if (louie.xpos >= downx-5 && louie.xpos <= downx  &&
      louie.ypos >= downy -5 &&  louie.ypos <= downy  && !louie.indicator ) {
      return 2;
    } else if (louie.xpos >= leftx && louie.xpos <= leftx + 10 &&
      louie.ypos >= lefty  && louie.ypos <= lefty + 5 && !louie.indicator ) {
      return 3;
    }
    return -1; // casual value
  }


  // logic for confirmation Louie hit a player
  void louieHitPlayer() {
    int hit = isPlayerHit();
    if (hit ==0 && !ignoreTop) {
      top.decreaseCones();
    } else if (hit ==1 && !ignoreRight) {
      right.decreaseCones();
    } else if (hit==2 && !ignoreDown) {
      down.decreaseCones();
    } else if (hit ==3 && !ignoreLeft) {
      left.decreaseCones();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
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
    } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, right, rightBounds) && !ignoreRight) { // right
      louie.indicator = true; // set collision off
    } else if  (checkPlayerHitLouie(louie.xpos, louie.ypos, down, downBounds) && !ignoreDown) { // down
      louie.indicator = true; // set collision off
    } else  if  (checkPlayerHitLouie(louie.xpos, louie.ypos, left, leftBounds) && !ignoreLeft) { // left
      louie.indicator = true; // set collision off
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////

  /*
sets the gameOver state
   */
  private void setGameOver() { 
    if(top.cone.cones == 0 && right.cone.cones == 0 && down.cone.cones == 0 && left.cone.cones > 0){
      winner = 3;
      gameOver =true;
   }else if(top.cone.cones == 0 && right.cone.cones == 0 && down.cone.cones > 0 && left.cone.cones  == 0){
     winner = 2;
      gameOver =true;
   }else if(top.cone.cones == 0 && right.cone.cones > 0 && down.cone.cones == 0 && left.cone.cones  == 0){
     winner = 1;
      gameOver =true;
   }else if(top.cone.cones > 0 && right.cone.cones == 0 && down.cone.cones == 0 && left.cone.cones  == 0){
     winner = 0;
      gameOver =true;
   }
  }

  /*
clean up
   return to main menu ?
   */
  private void gameOver(int winner) { //<>//
    view.drawEndScreen(winner);
  }

  /**
   Draw the given amount of Players
   */
  void notifyViewForPlayers() {
    switch(playerCount) {
    case 1:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.topJumps(top.hadJumped());
      break;
    case 2:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(down.xpos, down.ypos, 2);
      view.topJumps(top.hadJumped());
      view.downJumps(right.hadJumped());
      break;
    case 3:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(right.xpos, right.ypos, 1);
      view.drawPlayer(down.xpos, down.ypos, 2);
      view.topJumps(top.hadJumped());
      view.rightJumps(right.hadJumped());
      view.downJumps(down.hadJumped());
      break;
    case 4:
      view.drawPlayer(top.xpos, top.ypos, 0);
      view.drawPlayer(right.xpos, right.ypos, 1);
      view.drawPlayer(down.xpos, down.ypos, 2);
      view.drawPlayer(left.xpos, left.ypos, 3);
      view.topJumps(top.hadJumped());
      view.rightJumps(right.hadJumped());
      view.downJumps(down.hadJumped());
      view.leftJumps(left.hadJumped());
      break;
    default:
      break;
    }
  }
/*
  logic for the ui-elements: the hearts and the back to menue button
*/
  void ui() {
    int[] hearts = {top.cone.cones, right.cone.cones, down.cone.cones, left.cone.cones};
    view.drawUIElements(hearts, playerCount);
  }
}
