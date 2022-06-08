

public class Player {

  float xpos; // position of the player
  float ypos;
  float pWidth;
  float pHeight;
  float defaultHeight; // defines how hight the player must jump to trigger "hadJumped()"
  boolean hitsLouie;
  boolean coneHit;
  /* bounds in which Louie can be hit from the player
   each bound are calculated from the origin to louies circle and represents a part or the circlecurve
   */
  float[] hitBounds; // 0 =x, 1 =y from lowerBound, 3,4 for upperBound



  Cone cone;



  public Player(float xSpawn, float ySpawn, float[] bounds ) {
    cone = new Cone();
    xpos = xSpawn;
    ypos = ySpawn;
    hitBounds = bounds;
  }
  /*
  @return true if the player had jumped
   */
  public boolean hadJumped() {
    return false;
  }

  public boolean playerHitLouie() {
    return false;
  }


  // capsulate the information for the cones
  private class Cone {
    int cones = 3;
  }
}
