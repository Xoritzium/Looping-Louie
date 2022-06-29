//<>// //<>// //<>// //<>// //<>// //<>// //<>//
import processing.video.*;

//-> rgb: 300,182,30 = ffb61e // background

/**
 View which draws the game onto the screen
 */
public class View {

  //PNG louie;
  PImage louie;
  ///////////////////////top
  int topIdleCounter = 0; // counter for the jumo animation
  Movie top; // idle animation
  Movie topJump; // jump animation
  PImage topHeart; // heart of top player
  boolean topJumping; // control if top is jumping or not
  //////////////////// right
  int rightIdleCounter = 0;
  Movie right;
  Movie rightJump;
  PImage rightHeart;
  boolean rightJumping;
  ////////////////////// down
  int downIdleCounter =0;
  Movie down;
  Movie downJump;
  PImage downHeart;
  boolean downJumping;
  ////////////////////// left
  int leftIdleCounter =0;
  Movie left;
  Movie leftJump;
  PImage leftHeart;
  boolean leftJumping;

  PImage[] allHearts = new PImage[4]; // storing all hearts
  int jumpLength = 44; // length of a jump animation in frames


  PImage camera; // temporary vision of the camera

  /**
   initiate view
   @param p PApplet is the main class where setup and draw is called
   */
  public View(PApplet p) {
    camera = loadImage("tempCam.jpg");

    ///////hearts ////////
    topHeart = loadImage("\\hearts\\heart-blue.png");
    rightHeart = loadImage("\\hearts\\heart-yellow.png");
    downHeart = loadImage("\\hearts\\heart-red.png");
    leftHeart = loadImage("\\hearts\\heart-green.png");
    allHearts[0] = topHeart;
    allHearts[1] = rightHeart;
    allHearts[2] = downHeart;
    allHearts[3] = leftHeart;


    louie = loadImage("louie-static.png");

    top = new Movie(p, "\\Player-idle\\player-blue-idle.mp4");
    top.loop();
    /////load Players
    right = new Movie(p, "\\Player-idle\\player-yellow-idle.mp4");
    right.loop();
    down = new Movie(p, "\\Player-idle\\player-red-idle.mp4");
    down.loop();
    left = new Movie(p, "\\Player-idle\\player-green-idle.mp4");
    left.loop();

    topJump = new Movie(p, "\\Player-Jump\\player-blue-jump.mp4");
    rightJump = new Movie(p, "\\Player-Jump\\player-yellow-jump.mp4");
    downJump = new Movie(p, "\\Player-Jump\\player-red-jump.mp4");
    leftJump = new Movie(p, "\\Player-Jump\\player-green-jump.mp4");
  }

  /**
   draw louie onto th canvas
   @param x = x position
   @param y = y position
   */
  void drawLouie( float x, float y) {
    image(louie, x, y, 200, 200);
  }

  /* draw the players onto the canvas
   0=top
   1=right
   2=down
   3=left
   @param x = x position
   @param y = y position
   @param which = the player to be drawn
   */
  void drawPlayer(float x, float y, int which) {

    switch(which) {
    case 0:
      movieEvent(top);
      imageMode(CENTER);
      idleVSJumpTop(top, topJump, x, y);
      image(topHeart, x+100, y+50, 200, 200);
      break;

    case 1:
      imageMode(CENTER);
      movieEvent(right);
      idleVSJumpRight(right, rightJump, x, y);
      image(rightHeart, x, y+150, 200, 200);
      break;
    case 2:
      movieEvent(down);
      imageMode(CENTER);
      idleVSJumpDown(down, downJump, x, y);
      image(downHeart, x-100, y + 50, 200, 200);
      break;
    case 3:
      movieEvent(left);
      imageMode(CENTER);
      idleVSJumpLeft(left, leftJump, x, y);
      image(leftHeart, x, y-100, 200, 200);
      break;
    default:
      System.err.println("invalid Player adressed, check call of 'drawPlayer'");
      break;
    }
  }
  /**
   draw the uiElemtns onto the canvas
   @param hearts = array of the hearts
   @param players = amount of players
   */
  void drawUIElements(int[] hearts, int players) {
    imageMode(CORNER);
    image(camera, width - 640, 0, 640, 480);
    text("Spiel beenden", width * 5/6, height  * 5/6);
    drawHearts(hearts, players);
  }

  /**
   draw the endScreen after the game ends and show the winner
   */
  void drawEndScreen(int winner) {
    background(255, 0, 0);
    imageMode(CENTER);
    switch(winner) {
    case 0:
      image(topHeart, width / 2, height/2, 400, 400);
      break;
    case 1:
      image(rightHeart, width / 2, height/2, 400, 400);
      break;
    case 2:
      image(downHeart, width / 2, height/2, 400, 400);
      break;
    case 3:
      image(leftHeart, width / 2, height/2, 400, 400);
      break;
    default:
      break;
    }
    textSize(100);
    text("game over", 300, 500);
    text("winner is: ", 300, 600);
    textSize(18);
    text("zurück zum Hauptmenu", width * 5/6, height* 5/6);
  }

  /**
   draw the hearts of the UI onto the canvas
   */
  void drawHearts(int[] hearts, int players) {
    float x = width - 640;
    float y = 480;
    float heartSize = 640/players;
    if (players == 1) {
      heartSize = 300;
    }
    for (int h = 0; h < players; h++) {
      if (players == 2 && h == 1) {
        h++;
      }
      for (int i = 0; i < hearts[h]; i++) {
        image(allHearts[h], x, y, heartSize, heartSize);
        y += heartSize * 1/2;
      }

      x += heartSize;
      y = 480;
    }
  }





  ///////////////////////////////////////////////////
  /**
   prepair the next frame of the movie to be shown
   @param m = the movie from where the next frame should be taken
   */
  void movieEvent(Movie m) {
    if (m.available()) {
      m.read();
    }
  }
  ////////////////////////////////////////////////////
  /** every Player can swap between two animations, the idle animation and the jump animation
   here this will be controlled.
   the "...Jumps(boolean) method is called whenever a player should jump)
   idleVSJump() params:
   @param idle = each idle Animation of a player
   @param jump = each jump animation of a player
   @param x = x position to be drawn
   @param y = y position to be drawn
   */
  /////////////////////////////////////////////////////////


  void idleVSJumpTop(Movie idle, Movie jump, float x, float y) {
    if (topJumping) {
      if (topIdleCounter < jumpLength) {
        topIdleCounter++;
        movieEvent(jump);
        image(jump, x, y, 200, 200);
      } else {
        topJumping = false;
        topIdleCounter = 0;
        idle.loop();
        jump.stop();
      }
    } else {
      image(idle, x, y, 200, 200);
    }
  }

  void topJumps(boolean j) {
    if (j) {
      topJump.jump(0);
      topJump.play();
      topJumping = true;
      topIdleCounter = 0;
    }
  };


  void idleVSJumpRight(Movie idle, Movie jump, float x, float y) {
    if (rightJumping) {

      if (rightIdleCounter < jumpLength) {
        rightIdleCounter++;
        movieEvent(jump);
        image(jump, x, y, 200, 200);
      } else {
        rightJumping = false;
        rightIdleCounter = 0;
        idle.loop();
        jump.stop();
      }
    } else {
      image(idle, x, y, 200, 200);
    }
  }
  void rightJumps(boolean j) {
    if (j) {
      rightJump.jump(0);
      rightJump.play();
      rightJumping = true;
      topIdleCounter = 0;
    }
  }

  void idleVSJumpDown(Movie idle, Movie jump, float x, float y) {
    if (downJumping) {

      if (downIdleCounter < jumpLength) {
        downIdleCounter++;
        movieEvent(jump);
        image(jump, x, y, 200, 200);
      } else {
        downJumping = false;
        downIdleCounter = 0;
        idle.loop();
        jump.stop();
      }
    } else {
      image(idle, x, y, 200, 200);
    }
  }

  void downJumps(boolean j) {
    if (j) {
      downJump.jump(0);
      downJump.play();
      downJumping = true;
      downIdleCounter = 0;
    }
  }

  void idleVSJumpLeft(Movie idle, Movie jump, float x, float y) {
    if (leftJumping) {

      if (leftIdleCounter < jumpLength) {
        leftIdleCounter++;
        movieEvent(jump);
        image(jump, x, y, 200, 200);
      } else {
        leftJumping = false;
        leftIdleCounter = 0;
        idle.loop();
        jump.stop();
      }
    } else {
      image(idle, x, y, 200, 200);
    }
  }

  void leftJumps(boolean j) {
    if (j) {
      leftJump.jump(0);
      leftJump.play();
      leftJumping = true;
      leftIdleCounter = 0;
    }
  };
}
