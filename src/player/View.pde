//<>// //<>// //<>// //<>// //<>// //<>//
import processing.video.*;

//-> rgb: 300,182,30 = ffb61e
/*
this is not the final view, its just for dev
 */
public class View {

  PImage heart;//optional !
  //Gif louie;
  PImage louie;

  ///////////////////////top
  int topIdleCounter = 0;
  Movie top;
  PImage topHeart;
  //////////////////// right
  int rightIdleCounter = 0;
  Movie right;
  PImage rightHeart;
  ////////////////////// down
  int downIdleCounter =0;
  Movie down;
  PImage downHeart;
  ////////////////////// left
  int leftIdleCounter =0;
  Movie left;
  PImage leftHeart;

  //  Movie idleLouie;
  int counterTop =0;
  boolean jumpedTop = false;
  PImage camera;

  public View(PApplet p) {
    camera = loadImage("tempCam.jpg");

    ///////hearts ////////
    topHeart = loadImage("\\hearts\\heart-blue.png");
    rightHeart = loadImage("\\hearts\\heart-yellow.png");
    downHeart = loadImage("\\hearts\\heart-red.png");
    leftHeart = loadImage("\\hearts\\heart-green.png");
    

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
  }



  void drawLouie( float x, float y) {
    image(louie, x, y, 200, 200);
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
      image(top, x, y, 200, 200);

      /*
        image(idleTop, x, y + 50, 200, 200);
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
      image(topHeart, x+100, y+50, 200, 200);
      break;


    case 1:
      imageMode(CENTER);
      movieEvent(right);
      image(right, x, y, 200, 200);
      image(rightHeart, x, y+150, 200, 200);
      break;
    case 2:
      movieEvent(down);
      imageMode(CENTER);
      image(down, x, y, 200, 200);
      image(downHeart, x-100, y + 50, 200, 200);
      break;
    case 3:
      movieEvent(left);
      imageMode(CENTER);
      image(left, x, y, 200, 200);
      image(leftHeart, x, y-100, 200, 200);
      break;
    default:
      System.err.println("invalid Player adressed, check call of 'drawPlayer'");
      break;
    }
  }

  void drawUIElements(int[] hearts) {
    imageMode(CORNER);
    image(camera, width - 640, 0, 640, 480);
    text("Spiel beenden", width * 5/6, height  * 5/6);
    drawHearts(hearts);
  }


  void drawEndScreen() {
    background(255, 0, 0);
    text("game over", 500, 500);
    textSize(100);
  }


  void drawHearts(int[] hearts) {
    
  }





  ///////////////////////////////////////////////////
  void videoTop(Movie idle, Movie jump) {
    if (idle.available() || jump.available()) {
      idle.read();
      jump.read();
    }
  }
  void movieEvent(Movie m) {
    if (m.available()) {
      m.read();
    }
  }
}
