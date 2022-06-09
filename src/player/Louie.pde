public class Louie { //<>//

  float xpos; // his position
  float ypos;
  float radius; // radius of Louies movement, its center is always centered in the middle of the window
  float speed; // defines the speed of louie flying around [0.0; 0.1]
  boolean indicator; // indicates if the collision is on or off and if he took a punch
  float angleMultiplier = 1;
  float angle = 0; // counter to ensure louies movement

  float xmiddle = width/2;
  float ymiddle = height/2;


  public Louie(float radius, float speed) {
    this.radius = radius;
    this.speed = speed;
  }
  /*
  Louies Movement around the Game
   */
  public void movement() {

    angle = angle * angleMultiplier;

    if (angle >=  2*PI) {
      angle = 0;
    }
    xpos = xmiddle + (radius * cos( -angle)); // positive angle changes the direction to clockwise
    ypos = ymiddle + (radius * sin(angle));
    angle =angle + speed; // handles the speed of the rotation
  }

  public void movementTest() {
    xpos = xmiddle + (radius * cos( - (7/8)*PI));
    ypos = ymiddle + (radius * sin( (7/8) *PI));
  }
}
