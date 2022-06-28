//<>// //<>// //<>// //<>// //<>// //<>//
import processing.video.*;

//-> rgb: 300,182,30 = ffb61e
/*
this is not the final view, its just for dev
 */
public class View {

  //Gif louie;
  PImage louie;
  LouieAnimation louieAnim;
  ///////////////////////top
  int topIdleCounter = 0;
  Movie top;
  Movie topJump;
  PImage topHeart;
  boolean topJumping;
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

  PImage[] allHearts = new PImage[4];
  int jumpLength = 44;


  //  Movie idleLouie;
  int counterTop =0;
  boolean jumpedTop = false;
  PImage camera;

  public View(PApplet p) {
    camera = loadImage("tempCam.jpg");

    louieAnim = new LouieAnimation();
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



  void drawLouie( float x, float y) {
    image(louie, x,y, 200,200);
  }

  /*
   0=top
   1=right
   2=down
   3=left
   */
  void drawPlayer(float x, float y, int which) {

    switch(which) {
    case 0:
      /*   if(top.available()){
       top.read();
       }
       */
      movieEvent(top);
      imageMode(CENTER);
      //image(top, x, y, 200, 200);
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

  void drawUIElements(int[] hearts, int players) {
    imageMode(CORNER);
    image(camera, width - 640, 0, 640, 480);
    text("Spiel beenden", width * 5/6, height  * 5/6);
    drawHearts(hearts, players);
  }


  void drawEndScreen() {
    background(255, 0, 0);
    text("game over", 500, 500);
    textSize(100);
  }


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
  void movieEvent(Movie m) {
    if (m.available()) {
      m.read();
    }
  }


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
