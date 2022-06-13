//import GifAnimation.*; //<>//

/*
this is not the final view, its just for dev
 */
public class View {
  /*  // colors of each player
   color top = color(255, 0, 0); //red
   color right = color(0, 255, 0); // green
   color down = color(0, 0, 255); // blue
   color left  = color(255, 255, 0); // yellow
   color louieCol = color(1, 1, 1);
   */
  PImage top, down, left, right;
  PImage heart;//optional !
  //Gif louie;
  PImage louie;
  public View() {
    
    //louie = new Gif("virus backround.gif");
    louie = loadImage("virus backround.gif");
    louie.resize(100, 100);
    top = loadImage("Spritze.png");
    down = loadImage("Spritze.png");
    left = loadImage("Spritze.png");
    right = loadImage("Spritze.png");
    heart = loadImage("herz.jpg");
  }



  void drawLouie( float x, float y) {
    image(louie, x, y);
  }

  /*
1= top
   2= right
   3=down
   4=left
   */
  void drawPlayer(float x, float y, int which) {
    switch(which) {
    case 0:
      imageMode(CENTER);
      image(top, x, y, 200, 200);
      image(heart, x+200, y+50, 100, 100);
      break;
    case 1:
      imageMode(CENTER);
      image(right, x, y, 200, 200);
      image(heart, x-50, y+200, 100, 100);
      break;
    case 2:
      imageMode(CENTER);
      image(down, x, y, 200, 200);
      image(heart, x-200, y-50, 100, 100);
      break;
    case 3:
      imageMode(CENTER);
      image(left, x, y, 200, 200);
      image(heart, x+50, y-200, 100, 100);
      break;
    default:
      System.err.println("invalid Player adressed, check call of 'drawPlayer'");
      break;
    }
  }
}
