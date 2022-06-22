public class Louie { //<>//

  float xpos; // his position
  float ypos;
  // center of louies circle
  float xmiddle;
  float ymiddle;

  float radius; // radius of Louies movement, its center is always centered in the middle of the window
  float speed; // defines the speed of louie flying around [0.0; 0.1]
  float tempSpeed;
  float speed2;

  boolean indicator; // indicates if the collision is on or off and if he took a punch
  float collisionOn; // stores the value how long louies collision is set off (counted in frames);
  float tempRadius;
  float indicatorCounter = 0;
  float actualRadius; // the slow de-/increasing radius to make a smooth transition to louies flight after he took a hit

  float angleMultiplier = 1;
  float angle = 0; // counter to ensure louies movement




  public Louie(float radius, float speed, float cON, float xmiddle,float ymiddle) {
    this.radius = radius;
    this.speed = speed;
    this.speed2 = speed;
    this.collisionOn = cON;
    this.xmiddle = xmiddle;
    this.ymiddle = ymiddle;
    tempRadius = radius -(radius / 3); //////////////////////////// temporary radius and speed because of the changed radius
    tempSpeed = speed +(speed/2);
  }
  /*
  Louies Movement around the Game
   */
  public void movement() {
    float tr = gotHit();


    if (angle >=  2*PI) { // keep somehow control over the angle
      angle = 0;
    }
    xpos = xmiddle + (tr * cos( -angle)); // positive angle changes the direction to clockwise
    ypos = ymiddle + (tr * sin(angle));
    angle =angle + speed; // handles the speed of the rotation
  }


  private float gotHit() {

    if (indicator) { // running collision of

      if (indicatorCounter < collisionOn) {
        indicatorCounter++;
        speed = tempSpeed;
      } else {
        indicator = false; // reset the collision to status quo
        indicatorCounter = 0;
        speed = speed2;
      }
      return tempRadius;
    } else {
      return radius;
    }
  } // 3 methods: 1= who controlls the collision 2 =changes the speed 3= changes the radius
}
