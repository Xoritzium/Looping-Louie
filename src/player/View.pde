/* //<>//
this is not the final view, its just for dev
 */
public class View {
  // colors of each player
  color top = color(255, 0, 0); //red
  color right = color(0, 255, 0); // green
  color down = color(0, 0, 255); // blue
  color left  = color(255, 255, 0); // yellow
  color louieCol = color(1, 1, 1);

  // die scheiße durch PImage ersetzen !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  PShape louie, louieCorner; // images of the players and louie

  public View(float widthP, float heightP, float widthL, float heightL) {

    louie = createShape(RECT, 0, 0, widthL, heightL);
    fill(louieCol);
  }


  void drawLouie( float x, float y) {

    shape(louie, x, y);
  }





  void drawPlayer(float x, float y, int which) {
    switch(which) {
    case 0:
      text("Top", x, y + 40) ;
      fill(top);
      shapeMode(CENTER);
      break;
    case 1:
      text("Right", x, y);
      fill(right);
      shapeMode(CENTER);
      break;
    case 2:
      text("Down", x, y + 20);
      fill(down);
      shapeMode(CENTER);
      break;
    case 3:
      text("Left", x, y);
      fill(left);
      shapeMode(CENTER);
      break;
    default:
      System.err.println("invalid Player adressed, check call of 'drawPlayer'");
      break;
    }
  }
}
