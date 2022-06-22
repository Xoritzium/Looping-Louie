 //<>// //<>// //<>//
import processing.video.*;


/*
this is not the final view, its just for dev
 */
public class View {

  PImage heart;//optional !
  //Gif louie;
  PImage louie;

  ///////////////////////top
  int topIdleCounter = 0;
  PImage[] idleTop;
  ////////////////////// right
  int rightIdleCounter = 0;
  PImage[] idleRight;
  ////////////////////// down
  int downIdleCounter =0;
  PImage[] idleDown;
  ////////////////////// left
  int leftIdleCounter =0;
  PImage[] idleLeft;


  Movie idleLouie;
  int counterTop =0;
  boolean jumpedTop = false;
  PImage camera;

  public View(PApplet p) {
    camera = loadImage("tempCam.jpg");

    heart = loadImage("herz.jpg");////////////////////////
    idleLouie = new Movie(p, "Louie-Idle-animation.mp4");
    idleLouie.loop();


    /////load Players
    idleTop = loadIdlePlayer("\\bluePlayerIdle\\playerBlue00");
    idleRight = loadIdlePlayer("\\greenPlayerIdle\\playerGreen00");
    idleDown = loadIdlePlayer("\\redPlayerIdle\\playerRed00");
    idleLeft = loadIdlePlayer("\\yellowPlayerIdle\\playerYellow00");
  }



  void drawLouie( float x, float y) {
    if (idleLouie.available()) {
      idleLouie.read();
    }
    image(idleLouie, x, y, 200, 200);
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
      playTopIdle(x, y);

      /*   imageMode(CENTER);
       videoTop(idleTop, jumpTop);
       //     image(idleTop, x, y + 50, 200, 200);
       if (jumpedTop) {
       if (counterTop < 46) {
       counterTop++;
       image(jumpTop, x, y+50, 200, 200);
       } else {
       jumpedTop = false;
       counterTop = 0;
       idleTop.loop();
       jumpTop.stop();
       }
       } else {
       image(idleTop, x, y, 200, 200);
       }
       
       */
      image(heart, x+200, y+50, 100, 100);
      break;


    case 1:
      imageMode(CENTER);
      playRightIdle(x, y);
      image(heart, x-50, y+200, 100, 100);
      break;
    case 2:
      imageMode(CENTER);
      playDownIdle(x, y);
      image(heart, x-200, y-50, 100, 100);
      break;
    case 3:
          imageMode(CENTER);
      playDownIdle(x, y);
      image(heart, x+50, y-200, 100, 100);
      break;
    default:
      System.err.println("invalid Player adressed, check call of 'drawPlayer'");
      break;
    }
  }

  void drawUIElements() {
    imageMode(CORNER);
    image(camera, width * 2/3, 0, 640, 480);
    text("Spiel beenden", width * 5/6, height  * 5/6);
  }


  void drawEndScreen() {
    background(0, 0, 0);
    text("game over", 500, 500);
    textSize(100);
  }

  ///////////////////////////////////////////////////
  void videoTop(Movie idle, Movie jump) {
    if (idle.available() || jump.available()) {
      idle.read();
      jump.read();
    }
  }

  ////////////////////////////////load and play something via ImageSequence///////////////////////

  PImage[] loadIdlePlayer(String path) {
    PImage[] list = new PImage[56];
    String file = path;
    for (int i = 0; i < 56; i++) {
      if (i < 10) {
        file = path + "0" + i + ".png";
      } else if (i >= 10) {
        file = path + i + ".png";
      }
      list[i] = loadImage(file);
    }
    return list;
  }




  void playTopIdle(float x, float y) {
    if (topIdleCounter < idleTop.length) {
      image(idleTop[topIdleCounter], x, y, 200, 200 );
      topIdleCounter++;
      if (topIdleCounter ==idleTop.length) {
        topIdleCounter = 0;
      }
    }
  }


  void playRightIdle(float x, float y) {
    if (rightIdleCounter < idleRight.length) {
      image(idleRight[rightIdleCounter], x, y, 200, 200);
      rightIdleCounter++; //<>//
      if (rightIdleCounter == idleRight.length) {
        rightIdleCounter =0; //<>//
      } //<>//
    }
  }
  void playDownIdle(float x, float y) {
    if (downIdleCounter < idleDown.length) {
      image(idleDown[downIdleCounter], x, y, 200, 200);
      downIdleCounter++;
      if (downIdleCounter == idleDown.length) {
        downIdleCounter =0;
      }
    }
  }
  void playLeftIdle(float x, float y) {
    if (leftIdleCounter < idleLeft.length) {
      image(idleLeft[leftIdleCounter], x, y, 200, 200);
      leftIdleCounter++;
      if (leftIdleCounter == idleLeft.length) {
        leftIdleCounter =0;
      }
    }
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////
