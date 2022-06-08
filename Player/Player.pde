public class Player {

  float xpos; // position of the player
  float ypos;
  float pWidth;
  float pHeight;
  float defaultHeight; // defines how hight the player must jump to trigger "hadJumped()"
  boolean hitsLouie;
  boolean coneHit;

  Cone cone;



  public Player() {
    cone = new Cone();
  }
  /*
  @return true if the player had jumped
   */
  public boolean hadJumped() {
    return false;
  }


  // capsulate the information for the cones
  private class Cone {
    int cones = 3;
  }
}
